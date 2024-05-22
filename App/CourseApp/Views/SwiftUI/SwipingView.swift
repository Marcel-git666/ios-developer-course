//
//  SwipingView.swift
//  CourseApp
//
//  Created by Marcel Mravec on 17.05.2024.
//

import os
import SwiftUI

struct SwipingView: View {
    private let dataProvider = MockDataProvider()
    @State private var flipped = false
    @State private var animate3d = false
    @State private var rotate = false
    let logger = Logger()
    
    // swiftlint:disable no_magic_numbers
    var body: some View {
        GeometryReader { geometry in
            HStack {
                Spacer()
                
                VStack {
                    if let jokes = dataProvider.data.first?.jokes {
                        ZStack {
                            ForEach(jokes, id: \.self) { joke in
                                ZStack {
                                    if flipped {
                                        Image("back")
                                            .resizable()
                                            .frame(width: geometry.size.width / 1.2, height: (geometry.size.width / 1.2) * 1.5)
                                    } else {
                                        SwipingCard(
                                            configuration: SwipingCard.Configuration(
                                                image: Image(uiImage: joke.image ?? UIImage()),
                                                title: dataProvider.data.first?.title ?? "Unknown",
                                                description: joke.text
                                            ),
                                            swipeStateAction: { action in
                                                switch action {
                                                case .finished:
                                                    logger.info("swipe action: finished")
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
                            .modifier(FlipEffect(flipped: $flipped, angle: animate3d ? 360 : 0, axis: (x: 1, y: 5)))
                            .rotationEffect(Angle(degrees: rotate ? 0 : 360))
                            .onAppear {
                                withAnimation(Animation.linear(duration: 3.0)) {
                                    self.animate3d = true
                                }
                                withAnimation(Animation.linear(duration: 2.0)) {
                                    self.rotate = true
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
            .navigationTitle("Random")
        }
    }
} // swiftlint:enable no_magic_numbers

#Preview {
    SwipingView()
}
