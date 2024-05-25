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
    private let tabBarCoordinator = {
        let coordinator = MainTabBarCoordinator()
        coordinator.start()
        return coordinator
    }()
    
    var body: some Scene {
        WindowGroup {
            CoordinatorView(coordinator: tabBarCoordinator)
                .onAppear {
                    logger.info("🦈 MainTabView has appeared.")
                }
                .ignoresSafeArea(.all)
        }
    }
}
