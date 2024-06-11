//
//  SwipingView.swift
//  CourseApp
//
//  Created by Marcel Mravec on 17.05.2024.
//

import os
import SwiftUI

struct SwipingViewConfiguration {
    var flipped = false
    var animate3d = false
    var rotate = false
}

struct SwipingView: View {
    @State private var config = SwipingViewConfiguration()
    let logger = Logger()
    private let jokesService = JokeService(apiManager: APIManager())
    private let category: String?
    @State private var jokes: [Joke] = []
    private let store = FirebaseStoreManager() 
    
    init(joke: Joke? = nil) {
        self.category = joke?.categories.first
        if let joke {
            self.jokes.append(joke)
        }
    }
    // swiftlint:disable no_magic_numbers
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                HStack {
                    Spacer()
                    
                    VStack {
                        if !jokes.isEmpty {
                            ZStack {
                                ForEach(jokes, id: \.self) { joke in
                                    ZStack {
                                        if config.flipped {
                                            Image("back")
                                                .resizable()
                                                .frame(width: geometry.size.width / 1.2, height: (geometry.size.width / 1.2) * 1.5)
                                        } else {
                                            SwipingCard(
                                                configuration: SwipingCard.Configuration(
                                                    title: joke.categories.first ?? "Unknown category",
                                                    description: joke.text
                                                ),
                                                swipeStateAction: { action in
                                                    switch action {
                                                    case .finished(let direction):
                                                        Task {
                                                            try await self.store.storeLike(jokeId: joke.id, liked: direction == .left)
                                                        }
                                                    case .swiping:
                                                        logger.info("swipe action: swiping")
                                                    case .cancelled:
                                                        logger.info("swipe action: cancelled")
                                                    }
                                                }
                                            )
                                        }
                                    }
                                }
                                .padding(.top, geometry.size.height / 20)
                                .frame(width: geometry.size.width / 1.2, height: (geometry.size.width / 1.2) * 1.5)
                                .modifier(FlipEffect(flipped: $config.flipped, angle: config.animate3d ? 360 : 0, axis: (x: 1, y: 5)))
                                .rotationEffect(Angle(degrees: config.rotate ? 0 : 360))
                                .onAppear {
                                    withAnimation(Animation.linear(duration: 3.0)) {
                                        self.config.animate3d = true
                                    }
                                    withAnimation(Animation.linear(duration: 2.0)) {
                                        self.config.rotate = true
                                    }
                                }
                            }
                        } else {
                            Text("Empty data!")
                        }
                        Spacer()
                    }
                    Spacer()
                }
            }
        }
        .onFirstAppear {
            fetchRandomJokes()
        }
        .navigationTitle("Random Jokes")
        .embedInScrollViewIfNeeded()
    }
    
    
    func fetchRandomJokes() {
        Task {
            try await withThrowingTaskGroup(of: JokeResponse.self) { group in
                for _ in 1...5 {
                    group.addTask {
                        if let category {
                            try await jokesService.fetchJokeForCategory(category)
                        } else {
                            try await jokesService.fetchRandomJoke()
                        }
                    }
                    
                    for try await jokeResponse in group {
                        jokes.append(Joke(jokeResponse: jokeResponse))
                    }
                }
            }
        }
    }
} // swiftlint:enable no_magic_numbers

#Preview {
    SwipingView()
}
