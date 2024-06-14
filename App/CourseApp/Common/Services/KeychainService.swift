//
//  KeychainService.swift
//  CourseApp
//
//  Created by Marcel Mravec on 11.06.2024.
//

import Foundation

final class KeychainService: KeychainServicing {
    enum KeychainKey: String {
        case authData = "com.course.app.authData"
        case loginString = "com.course.app.loginString"
    }

    private(set) var keychainManager: KeychainManaging

    init(keychainManager: KeychainManaging) {
        self.keychainManager = keychainManager
    }

    func storeAuthData(authData: String) throws {
        try keychainManager.store(key: KeychainKey.authData.rawValue, value: authData)
    }

    func fetchAuthData() throws -> String {
        try keychainManager.fetch(key: KeychainKey.authData.rawValue)
    }

    func removeAuthData() throws {
        try keychainManager.remove(key: KeychainKey.authData.rawValue)
    }
    
    func storeLogin(_ login: String) throws {
        try keychainManager.store(key: KeychainKey.loginString.rawValue, value: login)
    }
    
    func fetchLogin() throws -> String {
        try keychainManager.fetch(key: KeychainKey.loginString.rawValue)
    }
    
    func removeLoginData() throws {
        try keychainManager.remove(key: KeychainKey.loginString.rawValue)
    }
}
