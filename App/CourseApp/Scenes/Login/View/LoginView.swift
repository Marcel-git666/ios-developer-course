//
//  LoginView.swift
//  CourseApp
//
//  Created by Marcel Mravec on 30.05.2024.
//

import Combine
import SwiftUI

struct LoginView: View {
    @StateObject private var store: LoginViewStore

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
                CustomTextField(placeHolder: "E-mail", imageName: "envelope", imageOpacity: 1, imageColor: .white, value: $store.state.email)
                CustomTextLabel(text: "Password", textTypeSize: .baseText)
                CustomSecretTextField(placeHolder: "Password", imageName: "key", imageOpacity: 1, imageColor: .white, value: $store.state.password)
                Toggle(isOn: $store.state.rememberMe) {
                    CustomTextLabel(text: "Remember me", textTypeSize: .caption)
                }
                .toggleStyle(SwitchToggleStyle(tint: .orange))
                .padding(.vertical, UIConst.padding)
                .onChange(of: store.state.rememberMe) {
                    if store.state.rememberMe {
                        store.send(.storeLogin(store.state.email))
                    } else {
                        store.send(.removeLogin)
                    }
                }
                Spacer()
                HStack {
                    LoginButton(buttonText: "SignIn", buttonTextColor: .white, buttonBackground: .indigo) {
                        store.signIn()
                    }
                    LoginButton(buttonText: "SignUp", buttonTextColor: .white, buttonBackground: .teal) {
                        store.signUp()
                    }
                }
                Spacer()
            }
            .padding()
        }
        .ignoresSafeArea(.all)
        .onAppear {
            store.send(.viewDidLoad)
        }
    }
}

#Preview {
    LoginView(store: LoginViewStore(keychainService: KeychainService(keychainManager: KeychainManager()), authManager: FirebaseAuthManager()))
}
