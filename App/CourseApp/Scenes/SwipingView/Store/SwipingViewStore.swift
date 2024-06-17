//
//  SwipingViewStore.swift
//  CourseApp
//
//  Created by Marcel Mravec on 12.06.2024.
//

import Combine
import Foundation
import os

protocol Store {
    associatedtype State
    associatedtype Action
    
    @MainActor var state: State { get }
    
    @MainActor func send(action: Action)
}

final class SwipingViewStore: ObservableObject, EventEmitting {
    private let jokesService = JokeService(apiManager: APIManager())
    private let store: StoreManaging
    private lazy var logger = Logger()
    private var counter: Int = 0
    private let eventSubject = PassthroughSubject<SwipingViewEvent, Never>()
    var eventPublisher: AnyPublisher<SwipingViewEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
    let category: String?
    
    @Published var viewState: SwipingViewState = .initial
    
    init(joke: Joke? = nil, store: StoreManaging) {
        self.store = store
        self.category = joke?.categories.first
        if let joke {
            self.viewState.jokes.append(joke)
        }
    }
}

extension SwipingViewStore {
    @MainActor
    func send(_ action: SwipingViewAction) {
        switch action {
        case let .dataFetched(jokes):
            logger.info("thread jokes fetching: \(Thread.current.description)")
            viewState.jokes.append(contentsOf: jokes)
            viewState.status = .ready
        case .viewDidLoad:
            logger.info("thread Swiping view did load: \(Thread.current.description)")
            fetchRandomJokes()
            viewState.status = .loading
        case let .didLike(jokeId, liked):
            storeLike(jokeId: jokeId, liked: liked)
            counter += 1
            if counter == viewState.jokes.count {
                send(.noMoreJokes)
            }
        case .noMoreJokes:
            eventSubject.send(.dismiss)
        }
    }
}

private extension SwipingViewStore {
    func fetchRandomJokes() {
        logger.info("thread: \(Thread.current.description)")
        let numberOfJokesToLoad = 5
        Task {
            try await withThrowingTaskGroup(of: JokeResponse.self) { [weak self] group in
                guard let self else {
                    return
                }
                for _ in 1...numberOfJokesToLoad {
                    group.addTask {
                        if let category = self.category {
                            try await self.jokesService.fetchJokeForCategory(category)
                        } else {
                            try await self.jokesService.fetchRandomJoke()
                        }
                    }
                    var jokes: [Joke] = []
                    for try await jokeResponse in group {
                        jokes.append(Joke(jokeResponse: jokeResponse, liked: false))
                    }
                    logger.info("thread \(Thread.current.description)")
                    await send(.dataFetched(jokes))
                }
            }
        }
    }
        
    func storeLike(jokeId: String, liked: Bool) {
        Task {
            try await self.store.storeLike(jokeId: jokeId, liked: liked)
        }
    }
}
