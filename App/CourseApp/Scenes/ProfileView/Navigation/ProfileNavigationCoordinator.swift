//
//  ProfileNavigationCoordinator.swift
//  CourseApp
//
//  Created by Marcel Mravec on 27.05.2024.
//

import Combine
import os
import SwiftUI
import UIKit

final class ProfileNavigationCoordinator: NSObject, NavigationControllerCoordinator {
    private(set) var navigationController: UINavigationController = CustomNavigationController()
    private lazy var cancellables = Set<AnyCancellable>()
    private let eventSubject = PassthroughSubject<ProfileViewEvent, Never>()
    private let logger = Logger()
    var childCoordinators = [Coordinator]()
    
    
    // MARK: Lifecycle
    deinit {
        logger.info("❌ Deinit ProfileNavigationCoordinator")
    }
    
    func start() {
        navigationController.setViewControllers([makeProfile()], animated: true)
    }
}

// MARK: - Factories
private extension ProfileNavigationCoordinator {
    func makeProfile() -> UIViewController {
        let profileView = ProfileView()
        profileView.eventPublisher
            .sink { [weak self] event in
                self?.handleEvent(event)
            }
            .store(in: &cancellables)
        return UIHostingController(rootView: profileView)
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
        }
    }
}

extension ProfileNavigationCoordinator {
    func makeOnboardingFlow() -> ViewControllerCoordinator {
        let coordinator = OnboardingNavigationCoordinator()
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
    var eventPublisher: AnyPublisher<ProfileViewEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
}
