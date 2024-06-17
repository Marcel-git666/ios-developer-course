//
//  ImagesRouter.swift
//  CourseApp
//
//  Created by Marcel Mravec on 05.06.2024.
//

import Foundation

enum ImagesRouter: Endpoint {
    case size300x200
    
    var host: URL {
        BuildConfiguration.default.apiImagesBaseURL
    }
    
    var path: String {
        "300/200"
    }
}
