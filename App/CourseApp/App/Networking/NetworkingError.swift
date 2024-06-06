//
//  NetworkingError.swift
//  CourseApp
//
//  Created by Marcel Mravec on 05.06.2024.
//

import Foundation

enum NetworkingError: Error {
    case unacceptableStatusCode
    case noHttpResponse
    case decodingFailed(error: Error)
    case invalidUrlComponents
}
