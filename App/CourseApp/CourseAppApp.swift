//
//  CourseAppApp.swift
//  CourseApp
//
//  Created by Marcel Mravec on 25.04.2024.
//

import FirebaseCore
import os
import SwiftUI

enum Deeplink {
    case onboarding(page: Int)
    case closeOnboarding
    case signIn
}

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
        deeplinkFromService()
        return true
    }
    
    func deeplinkFromService() { // swiftlint:disable:next no_magic_numbers
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            self?.appCoordinator.handleDeeplink(deeplink: .onboarding(page: 0))
        }
        // ?wiftlint:disable:next no_magic_numbers
//         }
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
