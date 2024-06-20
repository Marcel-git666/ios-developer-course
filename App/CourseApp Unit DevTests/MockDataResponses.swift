//
//  MockDataResponses.swift
//  CourseApp Unit DevTests
//
//  Created by Marcel Mravec on 20.06.2024.
//

import Foundation

enum MockDataResponses {
    static let mockJokeResponse =
    """
    {
        "id": "123456"
        "categories": ["funny", "programming"],
        "created_at": "2024-06-17T13:00:00Z",
        "url": "https://api.example.com/jokes/123456",
        "value": "Why do submarines all run Linux? You can’t open Windows under water."
    }
    """.data(using: .utf8)!
    
    static let mockCategoriesResponse =
    """
    [
        "programming", "funny"
    ]
    """.data(using: .utf8)!
    
}
