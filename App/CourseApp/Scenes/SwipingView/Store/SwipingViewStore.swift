//
//  SwipingViewStore.swift
//  CourseApp
//
//  Created by Marcel Mravec on 12.06.2024.
//

import Foundation
import os

final class SwipingViewStore: ObservableObject {
    private let jokesService = JokeService(apiManager: APIManager())
    private let store = FirebaseStoreManager()
    private lazy var logger = Logger()
    let category: String?
    
    @Published var viewState: SwipingViewState = .initial
    
    init(joke: Joke? = nil) {
        self.category = joke?.categories.first
        if let joke {
            self.viewState.jokes.append(joke)
        }
    }
}

extension SwipingViewStore {
    func send(_ action: SwipingViewAction) {
    }
}

@MainActor
extension SwipingViewStore {
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
                    
                    viewState.jokes.append(contentsOf: jokes)
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
