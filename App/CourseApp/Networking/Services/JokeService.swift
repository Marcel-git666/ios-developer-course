//
//  JokeService.swift
//  CourseApp
//
//  Created by Marcel Mravec on 07.06.2024.
//

import Foundation

protocol JokeServicing {
    var apiManager: APIManaging { get }
    
    func fetchCategories() async throws -> [String]
    func fetchRandomJoke() async throws -> JokeResponse
    func fetchJokeForCategory(_ category: String) async throws -> JokeResponse
}
 
final class JokeService: JokeServicing {
    let apiManager: APIManaging
    
    init(apiManager: APIManaging) {
        self.apiManager = apiManager
    }
}

extension JokeService {
    func fetchRandomJoke() async throws -> JokeResponse {
        try await apiManager.request(JokesRouter.getRandomJoke)
    }
    
    func fetchCategories() async throws -> [String] {
        try await apiManager.request(JokesRouter.getJokeCategories)
    }
    
    func fetchJokeForCategory(_ category: String) async throws -> JokeResponse {
        try await apiManager.request(JokesRouter.getJokeFor(category: category))
    }
}
