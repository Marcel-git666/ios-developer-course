//
//  LoginView.swift
//  CourseApp
//
//  Created by Marcel Mravec on 30.05.2024.
//

import Combine
import os
import SwiftUI

struct LoginView: View {
    @StateObject private var store: LoginViewStore
    
    private let eventSubject = PassthroughSubject<LoginViewEvent, Never>()
    private let authManager = FirebaseAuthManager()
    private let keychainService = KeychainService(keychainManager: KeychainManager())
    let logger = Logger()
    enum UIConst {
        static let padding: CGFloat = 5
    }
    
    init(store: LoginViewStore) {
        _store = .init(wrappedValue: store)
    }
    
    var body: some View {
        ZStack {
            Color.bg
            VStack {
                Spacer()
                CustomTextLabel(text: "Login screen", textTypeSize: .navigationTitle)
                Spacer()
                CustomTextLabel(text: "E-mail", textTypeSize: .baseText)
                CustomTextField(placeHolder: "E-mail", imageName: "envelope", imageOpacity: 1, imageColor: .white, value: store.state.email)
                CustomTextLabel(text: "Password", textTypeSize: .baseText)
                CustomSecretTextField(placeHolder: "Password", imageName: "key", imageOpacity: 1, imageColor: .white, value: store.state.password)
                Toggle(isOn: store.state.rememberMe) {
                    CustomTextLabel(text: "Remember me", textTypeSize: .caption)
                }
                .toggleStyle(SwitchToggleStyle(tint: .orange))
                .padding(.vertical, UIConst.padding)
                .onChange(of: store.state.remeberMe) {
                    do {
                        if store.state.remeberMe {
                            try keychainService.storeLogin(store.state.email)
                        } else {
                            try keychainService.removeLoginData()
                        }
                    } catch {
                        logger.info("Login (email) not saved/removed due to exception.")
                    }
                }
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
        .onAppear {
            do {
                let loginString = try keychainService.fetchLogin()
                credentials.email = loginString
                remeberMe = true
            } catch {
                logger.info("❌ Credentials are not fetched.")
            }
        }
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
