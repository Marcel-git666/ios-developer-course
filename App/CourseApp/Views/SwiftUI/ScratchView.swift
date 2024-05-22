//
//  ScratchView.swift
//  CourseApp
//
//  Created by Marcel Mravec on 17.05.2024.
//

import SwiftUI

struct Line {
    var points = [CGPoint]()
    var lineWidth: Double = 50.0
}

struct ScratchView: View {
    // MARK: Variables
    let image: Image
    let text: String

    @State private var currentLine = Line()
    @State private var lines = [Line]()

    var body: some View {
        GeometryReader { geometry in
            let aspectRatio = UIConstants.aspectRatio
            let imageWidth = geometry.size.width
            let imageHeight = imageWidth / aspectRatio
            
            ZStack(alignment: .top) {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: imageWidth, height: imageHeight)
                    .bordered(cornerRadius: UIConstants.normalImageRadius)

                RoundedRectangle(cornerRadius: UIConstants.normalImageRadius)
                    .fill(.bg)
                    .frame(width: imageWidth, height: imageHeight)
                    .overlay {
                        Text(text)
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                    .mask(
                        Canvas { context, _ in
                            for line in lines {
                                var path = Path()
                                path.addLines(line.points)
                                context.stroke(
                                    path,
                                    with: .color(.white),
                                    style: StrokeStyle(
                                        lineWidth: line.lineWidth,
                                        lineCap: .round,
                                        lineJoin: .round
                                    )
                                )
                            }
                        }
                            .frame(width: imageWidth - UIConstants.normalImageRadius, height: imageHeight - UIConstants.normalImageRadius)
                    )
                    .gesture(dragGesture)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }

    // MARK: Drag gesture
    private var dragGesture: some Gesture {
        DragGesture(minimumDistance: 0, coordinateSpace: .local)
            .onChanged { value in
                let newPoint = value.location
                currentLine.points.append(newPoint)
                lines.append(currentLine)
            }
    }
}

#Preview {
    ScratchView(image: Image("nature"), text: "Joke")
}
