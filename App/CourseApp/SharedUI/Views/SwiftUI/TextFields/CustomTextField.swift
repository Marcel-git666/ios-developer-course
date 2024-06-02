//
//  CustomTextField.swift
//  CourseApp
//
//  Created by Marcel Mravec on 30.05.2024.
//

import SwiftUI

struct CustomTextField: View {
    let placeHolder: String
    let imageName: String
    let imageOpacity: Double
    let imageColor: Color
    @Binding var value: String
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .frame(width: UIConst.systemImageSize, height: UIConst.systemImageSize)
                .padding(.leading, UIConst.cellSpacing)
                .foregroundColor(imageColor.opacity(imageOpacity))
            TextField(placeHolder, text: $value)
                .foregroundColor(imageColor)
                .padding(UIConst.normalPadding)
        }
        .overlay(
            RoundedRectangle(cornerRadius: UIConst.normalImageRadius)
                .stroke(UIConst.frameGradient, lineWidth: UIConst.thinLine)
            )
    }
}

private extension CustomTextField {
    enum UIConst {
        static let normalPadding: CGFloat = 10
        static let thinLine: CGFloat = 3
        static let normalImageRadius: CGFloat = 10
        static let cellSpacing: CGFloat = 8
        static let systemImageSize: CGFloat = 20
        static let frameGradient = LinearGradient(
            gradient: Gradient(
            colors: [
            .red, .orange, .yellow, .green, .blue, .indigo, .purple
            ]
            ),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

#Preview { // swiftlint:disable no_magic_numbers
    VStack {
        CustomTextField(placeHolder: "E-mail", imageName: "envelope", imageOpacity: 0.3, imageColor: .primary, value: .constant(""))
            .padding()
        CustomTextField(placeHolder: "Password", imageName: "key", imageOpacity: 0.7, imageColor: .blue, value: .constant(""))
            .padding()
    }
    .padding() // swiftlint:enable no_magic_numbers
}
