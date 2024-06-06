//
//  KeychainManagerError.swift
//  CourseApp
//
//  Created by Marcel Mravec on 02.06.2024.
//

import Foundation

enum KeychainManagerError: Error {
    case encodingError(Error)
    case decodingError(Error)
    case dataNotFound
    case removeFailure(Error?)
}
