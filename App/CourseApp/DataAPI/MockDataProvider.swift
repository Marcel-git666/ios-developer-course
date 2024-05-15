//
//  MockDataProvider.swift
//  CourseApp
//
//  Created by Marcel Mravec on 10.05.2024.
//

import UIKit

let mockImages = [
    UIImage.nature,
    UIImage.computer,
    UIImage.food
]

struct SectionData: Identifiable, Hashable {
    let id = UUID()
    let title: String
    var jokes: [Joke]
}

struct Joke: Identifiable, Hashable {
    let id = UUID()
    let text: String
    let image = mockImages.randomElement()
}

final class MockDataProvider: ObservableObject {
    @Published var data: [SectionData]

    // MARK: Data
    private var localData = [
        SectionData(title: "Celebrations", jokes: [
            Joke(text: "Chuck Norris can make hamburger out of ham."),
            Joke(text: "All your base are belong to Chuck Norris"),
            Joke(text: "Chuck Norris can hit a barn door with a broad's side.")
        ])
    ]

    init() {
        data = localData
        updateData()
    }
}

// MARK: - Private methods
private extension MockDataProvider {
    func updateData() {
        let delayInSeconds: TimeInterval = 4
        DispatchQueue.main.asyncAfter(deadline: .now() + delayInSeconds, execute: {
            if var section = self.localData.first {
                // section.jokes.remove(at: Int.random(in: 0..<section.jokes.count))
                section.jokes.remove(at: 1)
                self.data = [section]
            }
        })
    }
}
