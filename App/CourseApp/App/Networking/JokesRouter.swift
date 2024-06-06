//
//  JokesRouter.swift
//  CourseApp
//
//  Created by Marcel Mravec on 05.06.2024.
//

import Foundation

enum JokesRouter: Endpoint {
    case getJokeCategories
    case getRandomJoke
    case getJokeFor(category: String)
    
    var host: URL {
        BuildConfiguration.default.apiJokesBaseURL
    }
    
    var path: String {
        switch self {
        case .getJokeCategories:
            "jokes/categories"
        case .getRandomJoke, .getJokeFor:
            "jokes/random"
        }
    }
    
    var urlParameters: [String: String] {
        switch self {
        case let .getJokeFor(category):
            ["category": category]
        default:
            [String: String]()
        }
    }
}
