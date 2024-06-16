//
//  HTTPHeader.swift
//  CourseApp
//
//  Created by Marcel Mravec on 05.06.2024.
//

import Foundation

enum HTTPHeader {
    enum HeaderField: String {
        case contentType = "Content-Type"
    }
    
    enum ContentType: String {
        case json = "application/json"
        case text = "text/html;charset=utf-8"
    }
}
