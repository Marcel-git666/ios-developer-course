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
    let text: String
    
    @State private var currentLine = Line()
    @State private var lines = [Line]()
    
    var body: some View {
        GeometryReader { geometry in
            let aspectRatio = UIConst.aspectRatio
            let imageWidth = geometry.size.width
            let imageHeight = imageWidth / aspectRatio
            
            ZStack(alignment: .top) {
                if let url = try? ImagesRouter.size300x200.asURLRequest().url {
                    AsyncImage(url: url) { image in
                        image
                            .resizableBordered()
                            .scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                } else {
                    Text("Error")
                }
                
                
                RoundedRectangle(cornerRadius: UIConst.normalImageRadius)
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
                            .frame(width: imageWidth - UIConst.normalImageRadius, height: imageHeight - UIConst.normalImageRadius)
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

private extension ScratchView {
    enum UIConst {
        static let normalImageRadius: CGFloat = 10
        static let aspectRatio: CGFloat = 1.5
    }
}

#Preview {
    ScratchView(text: "Joke")
}
