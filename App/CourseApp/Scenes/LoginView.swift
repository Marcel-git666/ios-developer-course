//
//  LoginView.swift
//  CourseApp
//
//  Created by Marcel Mravec on 30.05.2024.
//

import Combine
import os
import SwiftUI

struct LoginCredentials {
    var email: String = ""
    var password: String = ""
}

struct LoginView: View {
    @State private var credentials = LoginCredentials()
    private let eventSubject = PassthroughSubject<LoginViewEvent, Never>()
    let logger = Logger()
    
    var body: some View {
        ZStack {
            Color.bg
            VStack {
                Spacer()
                CustomTextLabel(text: "Login screen", textTypeSize: .navigationTitle)
                Spacer()
                CustomTextLabel(text: "E-mail", textTypeSize: .baseText)
                CustomTextField(placeHolder: "E-mail", imageName: "envelope", imageOpacity: 1, imageColor: .white, value: $credentials.email)
                CustomTextLabel(text: "Password", textTypeSize: .baseText)
                CustomSecretTextField(placeHolder: "Password", imageName: "key", imageOpacity: 1, imageColor: .white, value: $credentials.password)
                Spacer()
                LoginButton(buttonText: "Login", buttonTextColor: .white, buttonBackground: .indigo) {
                    logger.info("🔑 Login is pressed")
                    eventSubject.send(.login(credentials))
                }
                Spacer()
            }
            .padding()
        }
        .ignoresSafeArea(.all)
    }
}

extension LoginView {
    var eventPublisher: AnyPublisher<LoginViewEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
}

#Preview {
    LoginView()
}
