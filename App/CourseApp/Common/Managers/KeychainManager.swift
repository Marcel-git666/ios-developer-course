//
//  KeychainManager.swift
//  CourseApp
//
//  Created by Marcel Mravec on 02.06.2024.
//

import Foundation
import KeychainAccess

class KeychainManager: KeychainManaging {
    private let keychain = Keychain()
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    func store<T: Encodable>(key: String, value: T) throws {
        do {
            let data = try encoder.encode(value)
            keychain[data: key] = data
        } catch {
            throw KeychainManagerError.encodingError(error)
        }
    }
    
    func fetch<T: Decodable>(key: String) throws -> T {
        guard let data = try keychain.getData(key) else { throw KeychainManagerError.dataNotFound }
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw KeychainManagerError.decodingError(error)
        }
    }
    
    func remove(key: String) throws {
        do {
            try keychain.remove(key)
        } catch {
            throw KeychainManagerError.removeFailure(error)
        }
    }
}
