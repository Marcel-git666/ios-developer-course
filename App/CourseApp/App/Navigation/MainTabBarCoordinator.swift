//
//  MainTabBarCoordinator.swift
//  CourseApp
//
//  Created by Marcel Mravec on 24.05.2024.
//

import Combine
import SwiftUI
import UIKit

final class MainTabBarCoordinator: NSObject, TabBarControllerCoordinator {
    var childCoordinators = [Coordinator]()
    private(set) lazy var tabBarController = makeTabBarController()
    private lazy var cancellables = Set<AnyCancellable>()
}

extension MainTabBarCoordinator {
    func start() {
        tabBarController.viewControllers = [
            setupCategoriesView(),
            setupSwipingCardView()
        ]
    }
    
    func handleDeeplink(deeplink: Deeplink) {
        switch deeplink {
        case let .onboarding(page):
            let coordinator = makeOnboardingFlow(page: page)
            startChildCoordinator(coordinator)
            tabBarController.present(coordinator.rootViewController, animated: true)
        default:
            break
        }
        childCoordinators.forEach { $0.handleDeeplink(deeplink: deeplink) }
    }
}

private extension MainTabBarCoordinator {
    func makeOnboardingFlow(page: Int) -> ViewControllerCoordinator {
        let coordinator = OnboardingNavigationCoordinator(currentPage: page)
        coordinator.eventPublisher
            .sink { [weak self] event in
                self?.handleEvent(event)
            }
            .store(in: &cancellables)
        return coordinator
    }
    
    func handleEvent(_ event: OnboardingNavigationEvent) {
        switch event {
        case let .dismiss(coordinator):
            release(coordinator: coordinator)
        }
    }
    
    func makeTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.delegate = self
        return tabBarController
    }
    
    func setupCategoriesView() -> UIViewController {
        let categoriesNavigationController = CustomNavigationController(rootViewController: HomeViewController())
        categoriesNavigationController.tabBarItem = UITabBarItem(
            title: "Categories",
            image: UIImage(systemName: "list.bullet.rectangle.portrait"),
            tag: 0
        )
        
        return categoriesNavigationController
    }
    
    func setupSwipingCardView() -> UIViewController {
        let swipingCoordinator = SwipingNavigationCoordinator()
        startChildCoordinator(swipingCoordinator)
        swipingCoordinator.rootViewController.tabBarItem = UITabBarItem(title: "Random", image: UIImage(systemName: "switch.2"), tag: 1)
        
        return swipingCoordinator.rootViewController
    }
}

extension MainTabBarCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if viewController === tabBarController.viewControllers?.last {
            // rootViewController.showInfoAlert(title: "Last view controller alert.")
        }
    }
}

extension UIViewController {
    func showInfoAlert(title: String, message: String? = nil, handler: (() -> Void)? = nil) {
        guard presentedViewController == nil else {
            return
        }

        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let okAction = UIAlertAction(
            title: "OK",
            style: .default
        ) { _ in
            handler?()
        }
        alertController.addAction(okAction)

        present(alertController, animated: true)
    }
}
