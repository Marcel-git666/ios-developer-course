//
//  AppCoordinator.swift
//  CourseApp
//
//  Created by Marcel Mravec on 25.05.2024.
//

import UIKit

protocol AppCoordinating: ViewControllerCoordinator {}

final class AppCoordinator: AppCoordinating {
    private(set) lazy var rootViewController = makeTabBarFlow()
    
    var childCoordinators = [Coordinator]()
}

extension AppCoordinator {
    func start() {
        setupAppUI()
    }
    
    func setupAppUI() {
        UITabBar.appearance().backgroundColor = .systemBrown
        UITabBar.appearance().tintColor = .white
        UITabBarItem.appearance().setTitleTextAttributes(
            [
                NSAttributedString.Key.font: TextType.caption.uiFont
            ], for: .normal
        )
        UINavigationBar.appearance().tintColor = .white
    }
    
    func makeTabBarFlow() -> UIViewController {
        let coordinator = MainTabBarCoordinator()
        childCoordinators.append(coordinator)
        coordinator.start()
        return coordinator.rootViewController
    }
    
    func handleDeeplink(deeplink: Deeplink) {
        childCoordinators.forEach { $0.handleDeeplink(deeplink: deeplink) }
    }
}
