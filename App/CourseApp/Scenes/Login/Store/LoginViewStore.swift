//
//  LoginViewStore.swift
//  CourseApp
//
//  Created by Marcel Mravec on 17.06.2024.
//

import Combine
import os

final class LoginViewStore: ObservableObject, Store {
    private let keychainService: KeychainServicing
    private let authManager: FirebaseAuthManaging
    private let logger = Logger()
    private let eventSubject = PassthroughSubject<LoginViewEvent, Never>()
    @Published var state: LoginViewState = .initial
    var eventPublisher: AnyPublisher<LoginViewEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
    
    init(keychainService: KeychainServicing, authManager: FirebaseAuthManaging) {
        self.keychainService = keychainService
        self.authManager = authManager
    }
}

extension LoginViewStore {
    @MainActor
    func send(_ action: LoginViewAction) {
        switch action {
        case .viewdidLoad:
            fetchLogin()
        case .removeLogin:
            removeLogin()
        case let .storeLogin(email):
            storeLogin(email)
        }
    }
}

extension LoginViewStore {
    func storeLogin(_ email: String) {
        do {
            try keychainService.storeLogin(email)
        } catch {
            logger.info("❌ Login (email) not saved due to exception.")
        }
    }
    
    func removeLogin() {
        do {
            try keychainService.removeLoginData()
        } catch {
            logger.info("❌ Login (email) not removed due to exception.")
        }
    }
    
    @MainActor
    func fetchLogin() {
        do {
            let loginString = try keychainService.fetchLogin()
            state.email = loginString
            state.rememberMe = true
        } catch {
            logger.info("❌ Credentials are not fetched.")
        }
    }
}

extension LoginViewStore {
    @MainActor
    func signIn() {
        Task {
            do {
                try await authManager.signIn(Credentials(email: state.email, password: state.password))
                eventSubject.send(.loggedIn)
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func signUp() {
        Task {
            do {
                try await authManager.signUp(Credentials(email: state.email, password: state.password))
                DispatchQueue.main.async {
                    self.eventSubject.send(.loggedIn)
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
