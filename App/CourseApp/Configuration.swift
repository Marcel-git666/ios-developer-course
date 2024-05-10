//
//  Configuration.swift
//  CourseApp
//
//  Created by Marcel Mravec on 10.05.2024.
//

import Foundation

struct Configuration: Decodable {
    private enum CodingKeys: String, CodingKey {
        case apiJokesBaseURL = "API_JOKES_BASE_URL"
        case apiImagesBaseURL = "API_IMAGES_BASE_URL"
    }

    let apiJokesBaseURL: URL
    let apiImagesBaseURL: URL
}

// MARK: Static properties

extension Configuration {
    static let `default`: Configuration = {
        guard let propertyList = Bundle.main.infoDictionary else {
            fatalError("Unable to get property list.")
        }

        guard let data = try? JSONSerialization.data(withJSONObject: propertyList, options: []) else {
            fatalError("Unable to instantiate data from property list.")
        }

        let decoder = JSONDecoder()

        guard let configuration = try? decoder.decode(Configuration.self, from: data) else {
            fatalError("Unable to decode the Environment configuration file.")
        }

        return configuration
    }()
}
