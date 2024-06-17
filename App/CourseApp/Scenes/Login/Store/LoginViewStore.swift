//
//  LoginViewStore.swift
//  CourseApp
//
//  Created by Marcel Mravec on 17.06.2024.
//

import Foundation

final class LoginViewStore: ObservableObject, Store {
    @Published var state: LoginViewState = .initial
    
}

extension LoginViewStore {
    @MainActor
    func send(_ action: LoginViewAction) {
        switch action {
        case .viewdidLoad:
            break
        }
    }
}
