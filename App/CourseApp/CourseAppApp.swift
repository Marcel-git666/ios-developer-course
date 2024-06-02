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
    // Delegate pattern
    weak var deeplinkHandler: DeeplinkHandling?
    
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
            self?.deeplinkHandler?.handleDeeplink(.onboarding(page: 0))
        }
    }
}

@main
struct CourseAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @ObservedObject private var appCoordinator = AppCoordinator()
    private let logger = Logger()
    
    init() {
        appCoordinator.start()
        delegate.deeplinkHandler = appCoordinator
    }
    var body: some Scene {
        WindowGroup {
            CoordinatorView(coordinator: appCoordinator )
                .id(appCoordinator.isAuthorized)
                .onAppear {
                    logger.info("🦈 AppCoordinator has appeared.")
                }
                .ignoresSafeArea(.all)
        }
    }
}
