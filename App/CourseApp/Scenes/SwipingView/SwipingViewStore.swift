//
//  SwipingViewStore.swift
//  CourseApp
//
//  Created by Marcel Mravec on 12.06.2024.
//

import Foundation

struct SwipingViewState {
    var jokes: [Joke] = []
    
    static let initial = SwipingViewState()
}

final class SwipingViewStore: ObservableObject {
    private let jokesService = JokeService(apiManager: APIManager())
    private let store = FirebaseStoreManager()
    let category: String?
    
    @Published var viewState: SwipingViewState = .initial
    
    init(joke: Joke? = nil) {
        self.category = joke?.categories.first
        if let joke {
            self.viewState.jokes.append(joke)
        }
    }
}

@MainActor
extension SwipingViewStore {
    func fetchRandomJokes() {
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
                    self.viewState.jokes.append(contentsOf: jokes)
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
