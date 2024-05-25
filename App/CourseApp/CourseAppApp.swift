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
    let appCoordinator: some AppCoordinating = {
        let coordinator = AppCoordinator()
        coordinator.start()
        return coordinator
    }()
    
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
    
    var body: some Scene {
        WindowGroup {
            CoordinatorView(coordinator: delegate.appCoordinator )
                .onAppear {
                    logger.info("🦈 MainTabView has appeared.")
                }
                .ignoresSafeArea(.all)
        }
    }
}
