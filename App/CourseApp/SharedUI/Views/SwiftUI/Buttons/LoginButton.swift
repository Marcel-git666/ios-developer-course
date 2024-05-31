//
//  LoginButton.swift
//  CourseApp
//
//  Created by Marcel Mravec on 30.05.2024.
//

import SwiftUI

struct LoginButton: View {
    let buttonText: String
    let buttonTextColor: Color
    let buttonBackground: Color
    let action: VoidAction
    
    var body: some View {
        Button(action: action, label: {
            Text(buttonText)
                .fontWeight(.medium)
                .foregroundColor(buttonTextColor)
                .frame(height: UIConstants.buttonHeight)
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(buttonBackground)
                .cornerRadius(UIConstants.largeImageRadius)
        })
    }
}

private extension LoginButton {
    enum UIConstants {
        static let largeImageRadius: CGFloat = 15
        static let buttonHeight: CGFloat = 50
    }
}

#Preview {
    LoginButton(buttonText: "Login", buttonTextColor: .white, buttonBackground: .purple) { }
        .padding()
}
