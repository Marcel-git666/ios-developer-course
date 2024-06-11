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
    @State private var credentials: LoginCredentials
    private let eventSubject = PassthroughSubject<LoginViewEvent, Never>()
    private let authManager = FirebaseAuthManager()
    let logger = Logger()
    
    init(credentials: LoginCredentials = LoginCredentials(email: "", password: "")) {
        self.credentials = credentials
    }
    
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
                HStack {
                    LoginButton(buttonText: "SignIn", buttonTextColor: .white, buttonBackground: .indigo) {
                        logger.info("🔑 SignIn is pressed")
                        signIn()
                    }
                    LoginButton(buttonText: "SignUp", buttonTextColor: .white, buttonBackground: .teal) {
                        logger.info("🔑 SignUp is pressed")
                        signUp()
                    }
                }
                Spacer()
            }
            .padding()
        }
        .ignoresSafeArea(.all)
    }
}

private extension LoginView {
    @MainActor
    func signIn() {
        Task {
            do {
                try await authManager.signIn(Credentials(email: credentials.email, password: credentials.password))
                eventSubject.send(.loggedIn)
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func signUp() {
        Task {
            do {
                try await authManager.signUp(Credentials(email: credentials.email, password: credentials.password))
                DispatchQueue.main.async {
                    eventSubject.send(.loggedIn)
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
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
