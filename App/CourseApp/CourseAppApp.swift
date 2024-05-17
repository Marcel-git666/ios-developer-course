//
//  CourseAppApp.swift
//  CourseApp
//
//  Created by Marcel Mravec on 25.04.2024.
//

import FirebaseCore
import os
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct CourseAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    private let logger = Logger()
    private let isUIKit = false
    var body: some Scene {
        WindowGroup {
            homeView
                .onAppear {
                    logger.info("🦈 HomeView has appeared.")
                }
        }
    }
    @ViewBuilder
    var homeView: some View {
        if isUIKit {
            HomeView()
        } else {
            HomeViewSwiftUI()
        }
    }
}
