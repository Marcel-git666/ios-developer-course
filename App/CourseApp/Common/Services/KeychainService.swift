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
}
