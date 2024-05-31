//
//  LoginView.swift
//  CourseApp
//
//  Created by Marcel Mravec on 30.05.2024.
//

import os
import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    let logger = Logger()
    
    var body: some View {
        ZStack {
            Color.bg
            VStack {
                Spacer()
                CustomTextLabel(text: "Login screen", textTypeSize: .navigationTitle)
                Spacer()
                CustomTextLabel(text: "E-mail", textTypeSize: .baseText)
                CustomTextField(placeHolder: "E-mail", imageName: "envelope", imageOpacity: 1, imageColor: .white, value: $email)
                CustomTextLabel(text: "Password", textTypeSize: .baseText)
                CustomSecretTextField(placeHolder: "Password", imageName: "key", imageOpacity: 1, imageColor: .white, value: $email)
                Spacer()
                LoginButton(buttonText: "Login", buttonTextColor: .white, buttonBackground: .indigo) {
                    logger.info("🔑 Login is pressed")
                }
                Spacer()
            }
            .padding()
        }
        .ignoresSafeArea(.all)
    }
}


#Preview {
    LoginView()
}
