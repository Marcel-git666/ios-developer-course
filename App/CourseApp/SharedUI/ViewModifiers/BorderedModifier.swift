//
//  BorderedModifier.swift
//  CourseApp
//
//  Created by Marcel Mravec on 16.05.2024.
//

import SwiftUI

struct BorderedModifier: ViewModifier {
    var cornerRadius: CGFloat
    
    func body(content: Content) -> some View {
        content
            .background(.gray)
            .cornerRadius(cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                .red, .orange, .yellow, .green, .blue, .indigo, .purple
                            ]),
                            startPoint: .leading,
                            endPoint: .trailing
                        ),
                        lineWidth: UIConst.thinLine
                    )
            )
            .shadow(radius: UIConst.shadowRadius)
    }
}

private extension BorderedModifier {
    enum UIConst {
        static let thinLine: CGFloat = 3
        static let shadowRadius: CGFloat = 2
    }
}

extension View {
    func bordered(cornerRadius: CGFloat) -> some View {
        self.modifier(BorderedModifier(cornerRadius: cornerRadius))
    }
}
