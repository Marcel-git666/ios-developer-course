//
//  Joke.swift
//  CourseApp
//
//  Created by Marcel Mravec on 10.06.2024.
//

import Foundation

struct Joke: Identifiable, Hashable {
    let id: String
    let text: String
    let categories: [String]
    
    init(jokeResponse: JokeResponse) {
        self.id = jokeResponse.id
        self.text = jokeResponse.value
        self.categories = jokeResponse.categories
    }
}
