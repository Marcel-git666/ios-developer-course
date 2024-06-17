//
//  SectionData.swift
//  CourseApp
//
//  Created by Marcel Mravec on 10.06.2024.
//

import Foundation

struct SectionData: Identifiable, Hashable {
    let id = UUID()
    let title: String
    var jokes: [Joke]
    
    init(title: String, jokes: [JokeResponse], likes: [String: Bool]) {
        self.title = title
        self.jokes = jokes.map { Joke(jokeResponse: $0, liked: likes[$0.id] ?? false) }
    }
}
