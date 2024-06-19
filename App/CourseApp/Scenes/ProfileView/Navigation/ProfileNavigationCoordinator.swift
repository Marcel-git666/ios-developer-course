//
//  ProfileNavigationCoordinator.swift
//  CourseApp
//
//  Created by Marcel Mravec on 27.05.2024.
//

import Combine
import DependencyInjection
import os
import SwiftUI
import UIKit

protocol ProfileCoordinating: NavigationControllerCoordinator {}

final class ProfileNavigationCoordinator: NSObject, ProfileCoordinating {
    private(set) var navigationController: UINavigationController = CustomNavigationController()
    private lazy var cancellables = Set<AnyCancellable>()
    private let eventSubject = PassthroughSubject<ProfileNavigationCoordinatorEvent, Never>()
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
        navigationController.setViewControllers([makeProfile()], animated: true)
    }
}

// MARK: - Factories
private extension ProfileNavigationCoordinator {
    func makeProfile() -> UIViewController {
        let store = container.resolve(type: ProfileViewStore.self)
        store.eventPublisher
            .sink { [weak self] event in
                self?.handleEvent(event)
            }
            .store(in: &cancellables)
        return UIHostingController(rootView: ProfileView(store: store))
    }
}

private extension ProfileNavigationCoordinator {
    func handleEvent(_ event: ProfileViewEvent) {
        switch event {
        case .startOnboarding:
            self.navigationController.present(
                makeOnboardingFlow().rootViewController,
                animated: true
            )
        case .logout:
            eventSubject.send(.logout)
        }
    }
}

extension ProfileNavigationCoordinator {
    func makeOnboardingFlow() -> ViewControllerCoordinator {
        let coordinator = OnboardingNavigationCoordinator(container: container)
        startChildCoordinator(coordinator)
        coordinator.eventPublisher
            .sink { [weak self] event in
                self?.handle(event)
            }
            .store(in: &cancellables)
        return coordinator
    }

    func handle(_ event: OnboardingNavigationCoordinatorEvent) {
        switch event {
        case let .dismiss(coordinator):
            release(coordinator: coordinator)
        }
    }
}

extension ProfileNavigationCoordinator: EventEmitting {
    var eventPublisher: AnyPublisher<ProfileNavigationCoordinatorEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
}
