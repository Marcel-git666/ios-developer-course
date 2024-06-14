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
    private let eventSubject = PassthroughSubject<MainTabBarEvent, Never>()
    private lazy var cancellables = Set<AnyCancellable>()
}

extension MainTabBarCoordinator {
    func start() {
        tabBarController.viewControllers = [
            setupCategoriesView().rootViewController,
            setupSwipingCardView().rootViewController,
            setupProfileView().rootViewController
        ]
    }
    
    func handleDeeplink(_ deeplink: Deeplink) {
        switch deeplink {
        case let .onboarding(page):
            let coordinator = makeOnboardingFlow(page: page)
            startChildCoordinator(coordinator)
            tabBarController.present(coordinator.rootViewController, animated: true)
        default:
            break
        }
        childCoordinators.forEach { $0.handleDeeplink(deeplink) }
    }
}

private extension MainTabBarCoordinator {
    func makeOnboardingFlow(page: Int) -> ViewControllerCoordinator {
        let coordinator = OnboardingNavigationCoordinator()
        coordinator.eventPublisher
            .sink { [weak self] event in
                self?.handleEvent(event)
            }
            .store(in: &cancellables)
        return coordinator
    }
    
    func handleEvent(_ event: OnboardingNavigationCoordinatorEvent) {
        switch event {
        case let .dismiss(coordinator):
            release(coordinator: coordinator)
        }
    }
    
    func makeTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        let appearance = UITabBarAppearance()
        appearance.backgroundEffect = .none
        tabBarController.tabBar.standardAppearance = appearance
        tabBarController.tabBar.scrollEdgeAppearance = appearance
        tabBarController.delegate = self
        return tabBarController
    }
    
    func setupCategoriesView() -> ViewControllerCoordinator {
        let categoriesCoordinator = CategoriesNavigationCoordinator()
        startChildCoordinator(categoriesCoordinator)
        categoriesCoordinator.rootViewController.tabBarItem = UITabBarItem(
            title: "Categories",
            image: UIImage(systemName: "list.bullet.rectangle.portrait"),
            tag: 0
        )
        
        return categoriesCoordinator
    }
    
    func setupSwipingCardView() -> ViewControllerCoordinator {
        let swipingCoordinator = SwipingNavigationCoordinator()
        startChildCoordinator(swipingCoordinator)
        swipingCoordinator.rootViewController.tabBarItem = UITabBarItem(title: "Random", image: UIImage(systemName: "switch.2"), tag: 1)
        
        return swipingCoordinator
    }
    
    func setupProfileView() -> ViewControllerCoordinator {
        let profileCoordinator = ProfileNavigationCoordinator()
        startChildCoordinator(profileCoordinator) // swiftlint:disable:next no_magic_numbers
        profileCoordinator.rootViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle"), tag: 2)
        
        return profileCoordinator
    }
}

extension MainTabBarCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if viewController === tabBarController.viewControllers?.last {
            // rootViewController.showInfoAlert(title: "Last view controller alert.")
        }
    }
}

extension MainTabBarCoordinator: EventEmitting {
    var eventPublisher: AnyPublisher<MainTabBarEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
}
