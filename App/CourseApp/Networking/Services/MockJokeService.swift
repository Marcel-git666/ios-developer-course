//
//  MockJokeService.swift
//  CourseApp
//
//  Created by Marcel Mravec on 19.06.2024.
//

import Foundation

final class MockJokeService: JokeServicing {
    var apiManager: any APIManaging
    
    init(apiManager: APIManaging) {
        self.apiManager = apiManager
    }
    
    func fetchCategories() async throws -> [String] {
        ["funny", "animals", "blondes"]
    }
    
    func fetchRandomJoke() async throws -> JokeResponse {
        JokeResponse(id: UUID().uuidString, categories: ["funny"], createdAt: Date(), url: URL(string: "https://example.com")!, value: "Joke1")
    }
    
    func fetchJokeForCategory(_ category: String) async throws -> JokeResponse {
        JokeResponse(id: UUID().uuidString, categories: ["blondes"], createdAt: Date(), url: URL(string: "https://example.com")!, value: "Joke2")
    }
}
