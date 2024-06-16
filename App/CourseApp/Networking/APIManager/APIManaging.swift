//
//  APIManaging.swift
//  CourseApp
//
//  Created by Marcel Mravec on 07.06.2024.
//

import Foundation

protocol APIManaging {
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T
}
