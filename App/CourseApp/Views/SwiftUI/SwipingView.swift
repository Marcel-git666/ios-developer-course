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
    
    var body: some View {
        let binding = Binding<Bool>(get: { self.flipped }, set: { self.updateBinding($0) })
        GeometryReader { geometry in
            HStack {
                Spacer()

                VStack {
                    if let jokes = dataProvider.data.first?.jokes {
                        ZStack {
                            ForEach(jokes, id: \.self) { joke in
                                flipped ? SwipingCard(
                                    configuration: SwipingCard.Configuration(
                                        image: Image(uiImage: joke.image ?? UIImage()),
                                        title: "Category",
                                        description: joke.text
                                    ),
                                    swipeStateAction: { action in
                                        print("swipe action \(action)")
                                    }
                                )
                                
                                : SwipingCard(
                                    configuration: SwipingCard.Configuration(
                                        image: Image(uiImage: joke.image ?? UIImage()),
                                        title: "Category",
                                        description: joke.text
                                    ),
                                    swipeStateAction: { action in
                                        print("swipe action \(action)")
                                    }
                                )
                            }
                        }
                        .padding(.top, geometry.size.height / 20)
                        .frame(width: geometry.size.width / 1.2, height: (geometry.size.width / 1.2) * 1.5)
                        .modifier(FlipEffect(flipped: binding, angle: animate3d ? 360 : 0, axis: (x: 1, y: 5)))
                        .rotationEffect(Angle(degrees: rotate ? 0 : 360))
                        .onAppear {
                            withAnimation(Animation.linear(duration: 2.0)) {
                                self.animate3d = true
                            }
                            
                            withAnimation(Animation.linear(duration: 3.0)) {
                                self.rotate = true
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
    func updateBinding(_ value: Bool) {
        flipped = value
    }
}

#Preview {
    SwipingView()
}
