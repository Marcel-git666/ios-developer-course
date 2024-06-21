//
//  SnapshotTests.swift
//  CourseApp Unit DevTests
//
//  Created by Marcel Mravec on 21.06.2024.
//

import SnapshotTesting
import SwiftUI
import XCTest
@testable import CourseApp_Dev

class CategoriesViewControllerTests: XCTestCase {
    func testSwipingCard() {
        isRecording = false
        let view = SwipingCard(configuration: .init(title: "Title", description: "")) { state in
            // nothing
        }
        let hostingController = UIHostingController(rootView: view)
        hostingController.view.frame = UIScreen.main.bounds
        hostingController.view.layoutIfNeeded()
        assertSnapshot(of: hostingController, as: .image)
    }
    
    func testProfileView() {
        isRecording = false
        let view = ProfileView(store: ProfileViewStore())
        let hostingController = UIHostingController(rootView: view)
        hostingController.view.frame = UIScreen.main.bounds
        hostingController.view.layoutIfNeeded()
        assertSnapshot(of: hostingController, as: .image)
    }
    
    func testLoginView() {
        isRecording = false
        let view = LoginView(store: LoginViewStore(keychainService: KeychainService(keychainManager: KeychainManager()), authManager: FirebaseAuthManager()))
        let hostingController = UIHostingController(rootView: view)
        hostingController.view.frame = UIScreen.main.bounds
        hostingController.view.layoutIfNeeded()
        assertSnapshot(of: hostingController, as: .image)
    }
    
    func testHorizontalCell() {
        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 56)
        let view = HorizontalScrollingImageCell(frame: frame)
        view.configure([Joke(jokeResponse: JokeResponse(id: "123", categories: ["funny"], createdAt: Date(), url: URL(string: "http://test.com")!, value: "I like jokes"), liked: false)])
        assertSnapshot(of: view, as: .image)
    }
}
