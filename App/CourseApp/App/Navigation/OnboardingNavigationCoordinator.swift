//
//  OnboardingNavigationCoordinator.swift
//  CourseApp
//
//  Created by Marcel Mravec on 26.05.2024.
//

import Combine
import os
import SwiftUI
import UIKit

protocol OnboardingCoordinating: NavigationControllerCoordinator {}

enum OnboardingNavigationEvent {
    case dismiss(Coordinator)
}

final class OnboardingNavigationCoordinator: OnboardingCoordinating {
    var currentPage: Int
    let logger = Logger()
    init(currentPage: Int) {
        self.currentPage = currentPage
    }
    
    deinit {
        logger.info("❌ Deinit of Onboarding Navigation Coordinator")
    }
    
    private(set) lazy var navigationController: UINavigationController = makeNavigationController()
    private var cancellables = Set<AnyCancellable>()
    private let eventSubject = PassthroughSubject<OnboardingNavigationEvent, Never>()
    var childCoordinators: [any Coordinator] = []
}

// MARK: - Factories
extension OnboardingNavigationCoordinator {
    func handleDeeplink(deeplink: Deeplink) {
        switch deeplink {
        case .closeOnboarding:
            logger.info("❌ closing onboarding....")
            rootViewController.dismiss(animated: true)
        case let .onboarding(page):
            switchToOnboardingPage(page)
        default:
            break
        }
    }
    
    func makeNavigationController() -> UINavigationController {
        let navigationController = CustomNavigationController()
        navigationController.eventPublisher.sink { [weak self] _ in // swiftlint:disable:next conditional_returns_on_newline
            guard let self else { return }
            self.eventSubject.send(.dismiss(self))
        }
        .store(in: &cancellables)
        return navigationController
    }
    
    func start() {
        switchToOnboardingPage(currentPage)
    }
    
    private func switchToOnboardingPage(_ page: Int) { // swiftlint:disable:next conditional_returns_on_newline
        guard page != currentPage || navigationController.viewControllers.isEmpty else { return }
        currentPage = page
        let viewController: UIViewController
        switch page {
        case 0:
            logger.info("0️⃣ Page 0, number of vc is \(self.navigationController.viewControllers.count)")
            viewController = makeOnboardingView()
        case 1:
            logger.info("1️⃣ Page 1, number of vc is \(self.navigationController.viewControllers.count)")
            viewController = makeNextOnboardingView() // swiftlint:disable:next no_magic_numbers
        case 2:
            logger.info("2️⃣ Page 2, number of vc is \(self.navigationController.viewControllers.count)")
            viewController = makeLastOnboardingView()
        default:
            return
        }
        if navigationController.viewControllers.isEmpty || currentPage == 0 {
            navigationController.setViewControllers([viewController], animated: true)
        } else {
            navigationController.pushViewController(viewController, animated: true)
        }
    }
}

extension OnboardingNavigationCoordinator {
    func makeOnboardingView() -> UIViewController {
        let controller = UIHostingController(rootView: OnboardingView(coordinator: self))
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        return controller
    }
    
    func makeNextOnboardingView() -> UIViewController {
        let controller = UIHostingController(rootView: OnboardingNextView(coordinator: self))
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        return controller
    }
    
    func makeLastOnboardingView() -> UIViewController {
        let controller = UIHostingController(rootView: OnboardingLastView(coordinator: self))
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        return controller
    }
}

extension OnboardingNavigationCoordinator: EventEmitting {
    var eventPublisher: AnyPublisher<OnboardingNavigationEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
}
