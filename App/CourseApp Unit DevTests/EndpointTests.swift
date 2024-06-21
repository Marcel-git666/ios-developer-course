//
//  EndpointTests.swift
//  CourseApp Unit DevTests
//
//  Created by Marcel Mravec on 20.06.2024.
//

@testable import CourseApp_Dev
import XCTest

final class EndpointTests: XCTestCase {

    enum MockEndpoint: Endpoint {
        case mockMethodGet
        case mockMethodPost
        case mockGetParameters
        
        var host: URL {
            URL(string: "http://example.com")!
        }
        
        var path: String {
            "api/test"
        }
        
        var method: HTTPMethod {
            switch self {
            case .mockMethodGet, .mockGetParameters:
                return .get
            case .mockMethodPost:
                return .post
            }
        }
        
    }
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testHTTPMethod() throws {
        guard let urlRequestGet = try? MockEndpoint.mockGetParameters.asURLRequest() else {
             XCTFail(" Can't create url request")
            return
        }
        XCTAssert(urlRequestGet.httpMethod == HTTPMethod.get.rawValue)
        
        guard let urlRequestPost = try? MockEndpoint.mockMethodPost.asURLRequest() else {
             XCTFail(" Can't create url request")
            return
        }
        XCTAssert(urlRequestPost.httpMethod == HTTPMethod.post.rawValue)
    }
}
