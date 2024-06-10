//
//  APIManager.swift
//  CourseApp
//
//  Created by Marcel Mravec on 05.06.2024.
//

import Foundation
import os

final class APIManager: APIManaging {
    private let logger = Logger()
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSSSS"
        return formatter
    }()
    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }()
    
    
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        let data = try await request(endpoint)
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkingError.decodingFailed(error: error)
        }
    }
    
    func request(_ endpoint: Endpoint) async throws -> Data {
        let request: URLRequest = try endpoint.asURLRequest()
        logger.info("🧨 Request for \(request.description)")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkingError.noHttpResponse
        }
        
        try checkStatusCode(httpResponse)
        
        let body = String(decoding: data, as: UTF8.self)
        logger.info("""
            ☀️ Response for \(request.description):
            👀 Status: \(httpResponse.statusCode),
            🫀 Body:
            \(body)
        """)
        
        return data
    }
    
    func checkStatusCode(_ urlResponse: HTTPURLResponse) throws {
        guard let statusCode = urlResponse.status else {
            throw NetworkingError.unacceptableStatusCode
        }
        
        guard statusCode.responseType == .success else {
            throw NetworkingError.unacceptableStatusCode
        }
    }
}
