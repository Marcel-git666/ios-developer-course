//
//  JokeResponse.swift
//  CourseApp
//
//  Created by Marcel Mravec on 05.06.2024.
//

import Foundation

struct JokeResponse: Codable {
    let id: String
    let categories: [String]
    let createdAt: Date
    let url: URL
    let value: String
}
