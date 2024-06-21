//
//  MockKeychainManager.swift
//  CourseApp Unit DevTests
//
//  Created by Marcel Mravec on 21.06.2024.
//

@testable import CourseApp_Dev
import Foundation

final class MockKeychainManager: KeychainManaging {
    private var keychain = [String: Data]()
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    func store<T: Encodable>(key: String, value: T) throws {
        do {
            let data = try encoder.encode(value)
            keychain[key] = data
        } catch {
            throw KeychainManagerError.encodingError(error)
        }
    }
    
    func fetch<T: Decodable>(key: String) throws -> T {
        guard let data = keychain[key] else { throw KeychainManagerError.dataNotFound }
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw KeychainManagerError.decodingError(error)
        }
    }
    
    func remove(key: String) throws {
        keychain[key] = nil
    }
}
