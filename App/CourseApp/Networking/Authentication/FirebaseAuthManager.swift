//
//  FirebaseAuthManager.swift
//  CourseApp
//
//  Created by Marcel Mravec on 11.06.2024.
//

import FirebaseAuth
import Foundation

final class FirebaseAuthManager: FirebaseAuthManaging {
    private let authService = Auth.auth()
    private let keychainService: KeychainServicing = KeychainService(keychainManager: KeychainManager())
    
    func signUp(_ credentials: Credentials) async throws {
        let result = try await authService.createUser(withEmail: credentials.email, password: credentials.password)
        guard let accessToken = try? await result.user.getIDToken() else {
            return
        }
        
        try keychainService.storeAuthData(authData: accessToken)
    }
    
    func signIn(_ credentials: Credentials) async throws {
        let result = try await authService.signIn(withEmail: credentials.email, password: credentials.password)
        guard let accessToken = try? await result.user.getIDToken() else {
            return
        }

        try keychainService.storeAuthData(authData: accessToken)
    }
    
    func signOut() async throws {
        try authService.signOut()
        try keychainService.removeAuthData()
    }
}
