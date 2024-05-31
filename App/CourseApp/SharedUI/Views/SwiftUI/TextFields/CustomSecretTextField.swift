//
//  CustomSecretTextField.swift
//  CourseApp
//
//  Created by Marcel Mravec on 30.05.2024.
//

import SwiftUI

struct CustomSecretTextField: View {
    var placeHolder: String
    var imageName: String
    var imageOpacity: Double
    let imageColor: Color
    @Binding var value: String
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .frame(width: UIConstants.systemImageSize, height: UIConstants.systemImageSize)
                .padding(.leading, UIConstants.cellSpacing)
                .foregroundColor(.primary.opacity(imageOpacity))
            SecureField(placeHolder, text: $value)
                .autocapitalization(.none)
                .autocorrectionDisabled()
                .padding(UIConstants.normalPadding)
        }
        .overlay(
            RoundedRectangle(
                cornerRadius: UIConstants.normalImageRadius
            )
            .stroke(UIConstants.frameGradient, lineWidth: UIConstants.thinLine)
            )
    }
}

private extension CustomSecretTextField {
    enum UIConstants {
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

#Preview {
    VStack {
        CustomSecretTextField(placeHolder: "Password", imageName: "key", imageOpacity: 1, imageColor: .red, value: .constant(""))
            .padding()
    }
}
