//
//  CustomError.swift
//  CourseApp
//
//  Created by Marcel Mravec on 02.06.2024.
//

import Foundation

enum CustomError: Error {
    case networkError(message: String)
    case unknownError

        var localizedDescription: String {
            switch self {
            case .networkError(let message):
                return "Network Error: \(message)"
            case .unknownError:
                return "An unknown error occurred."
            }
        }
}
