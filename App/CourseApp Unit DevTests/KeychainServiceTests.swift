//
//  KeychainServiceTests.swift
//  CourseApp Unit DevTests
//
//  Created by Marcel Mravec on 21.06.2024.
//

@testable import CourseApp_Dev
import XCTest

final class KeychainServiceTests: XCTestCase {
    var mockKeychainManager: MockKeychainManager!
    var keychainService: KeychainService!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockKeychainManager = MockKeychainManager()
        keychainService = KeychainService(keychainManager: mockKeychainManager)
    }

    override func tearDownWithError() throws {
        mockKeychainManager = nil
        keychainService = nil
        try super.tearDownWithError()
    }

    func testAuthDataKeychainServiceFlow() throws {
        try keychainService.storeAuthData(authData: "authorized")
        let fetchAuthTokenFromKeychain = try keychainService.fetchAuthData()
        XCTAssertTrue(fetchAuthTokenFromKeychain == "authorized")
        try keychainService.removeAuthData()
        XCTAssertThrowsError(try keychainService.fetchAuthData())
    }
    
    func testLoginDataFlow() throws {
        try keychainService.storeLogin("mylogin")
        let fetchLoginFromKeychain = try keychainService.fetchLogin()
        XCTAssertTrue(fetchLoginFromKeychain == "mylogin")
        try keychainService.removeLoginData()
        XCTAssertThrowsError(try keychainService.fetchLogin())
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
