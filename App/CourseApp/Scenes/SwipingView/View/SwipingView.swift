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
    @StateObject private var store: SwipingViewStore
    
    init(store: SwipingViewStore) {
        _store = .init(wrappedValue: store)
    }
    
    
    // swiftlint:disable no_magic_numbers
    var body: some View {
        GeometryReader { geometry in
            VStack {
                if store.state.status == .loading {
                    ProgressView()
                        .progressViewStyle(.circular)
                } else {
                    ZStack {
                        ForEach(store.state.jokes, id: \.self) { joke in
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
                                                store.send(.didLike(joke.id, direction == .left))
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
                    }
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
            }
        }
        .onFirstAppear {
            store.send(.viewDidLoad)
        }
        .navigationTitle("Random Jokes")
        .embedInScrollViewIfNeeded()
    }
} // swiftlint:enable no_magic_numbers
