//
//  SwipingViewStore.swift
//  CourseApp
//
//  Created by Marcel Mravec on 12.06.2024.
//

import Combine
import Foundation
import os

final class SwipingViewStore: ObservableObject, EventEmitting, Store {
    private let jokesService: JokeServicing
    private let store: StoreManaging
    private let keychainService: KeychainServicing
    private var category: String?
    private let logger = Logger()
    private var counter: Int = 0
    private let eventSubject = PassthroughSubject<SwipingViewEvent, Never>()
    
    @Published var state: SwipingViewState = .initial
    
    var eventPublisher: AnyPublisher<SwipingViewEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
    
    init(store: StoreManaging, keychainService: KeychainServicing, jokeService: JokeServicing) {
        self.keychainService = keychainService
        self.store = store
        self.jokesService = jokeService
//        self.category = joke?.categories.first
//        if let joke {
//            self.viewState.jokes.append(joke)
//        }
    }
}

extension SwipingViewStore {
    @MainActor
    func send(_ action: SwipingViewAction) {
        switch action {
        case let .dataFetched(jokes):
            logger.info("thread jokes fetching: \(Thread.current.description)")
            state.jokes.append(contentsOf: jokes)
            state.status = .ready
        case .viewDidLoad:
            logger.info("thread Swiping view did load: \(Thread.current.description)")
            fetchRandomJokes()
            state.status = .loading
        case let .didLike(jokeId, liked):
            storeLike(jokeId: jokeId, liked: liked)
            counter += 1
            if counter == state.jokes.count {
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
