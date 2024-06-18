//
//  LoginNavigationCoordinator.swift
//  CourseApp
//
//  Created by Marcel Mravec on 01.06.2024.
//

import Combine
import DependencyInjection
import os
import SwiftUI
import UIKit

protocol LoginCoordinating: NavigationControllerCoordinator {}

final class LoginNavigationCoordinator: NSObject, LoginCoordinating {
    private(set) var navigationController: UINavigationController = CustomNavigationController()
    private lazy var cancellables = Set<AnyCancellable>()
    private let eventSubject = PassthroughSubject<LoginNavigationEvent, Never>()
    private let logger = Logger()
    var childCoordinators = [Coordinator]()
    var container: Container
    
    // MARK: Lifecycle
    deinit {
        logger.info("❌ Deinit ProfileNavigationCoordinator")
    }
    
    init(container: Container) {
        self.container = container
    }
    
    func start() {
        navigationController.setViewControllers([makeLogin()], animated: true)
    }
}

// MARK: - Factories
private extension LoginNavigationCoordinator {
    func makeLogin() -> UIViewController {
        let store = LoginViewStore()
        store.eventPublisher
            .sink { [weak self] event in
                self?.handleEvent(event)
            }
            .store(in: &cancellables)
        return UIHostingController(rootView: LoginView(store: store))
    }
}

private extension LoginNavigationCoordinator {
    func handleEvent(_ event: LoginViewEvent) {
        switch event {
        case .loggedIn:
            eventSubject.send(.signedIn(self))
        }
    }
}

extension LoginNavigationCoordinator: EventEmitting {
    var eventPublisher: AnyPublisher<LoginNavigationEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
}

extension LoginNavigationCoordinator {
    func handleDeeplink(_ deeplink: Deeplink) {
        switch deeplink {
        case let .onboarding(page):
            let coordinator = makeOnboardingFlow(page: page)
            startChildCoordinator(coordinator)
            navigationController.present(coordinator.rootViewController, animated: true)
        default:
            break
        }
        childCoordinators.forEach { $0.handleDeeplink(deeplink) }
    }
    
    func makeOnboardingFlow(page: Int) -> ViewControllerCoordinator {
        let coordinator = OnboardingNavigationCoordinator(container: container)
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
}
