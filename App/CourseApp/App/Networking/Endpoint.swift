//
//  Endpoint.swift
//  CourseApp
//
//  Created by Marcel Mravec on 05.06.2024.
//

import Foundation

protocol Endpoint {
    var host: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var urlParameters: [String: String] { get }
    
    func asURLRequest() throws -> URLRequest
}

extension Endpoint {
    var method: HTTPMethod {
        .get
    }
    
    var headers: [String: String] {
        [:]
    }
    
    var urlParameters: [String: String] {
        [:]
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = host.appendingPathComponent(path)
        
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            throw NetworkingError.invalidUrlComponents
        }
        
        if !urlParameters.isEmpty {
            urlComponents.queryItems = urlParameters.map { URLQueryItem(name: $0, value: String(describing: $1)) }
        }
        
        guard let url = urlComponents.url else {
            throw NetworkingError.invalidUrlComponents
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.setValue(HTTPHeader.ContentType.json.rawValue, forHTTPHeaderField: HTTPHeader.HeaderField.contentType.rawValue)
        
        return request
    }
}
