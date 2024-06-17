//
//  OnboardingNavigationCoordinator.swift
//  CourseApp
//
//  Created by Marcel Mravec on 26.05.2024.
//

import Combine
import DependencyInjection
import os
import SwiftUI
import UIKit

protocol OnboardingCoordinating: NavigationControllerCoordinator {}

final class OnboardingNavigationCoordinator: OnboardingCoordinating {
    let logger = Logger()
    let onboardingPages: [AnyView] = [
        AnyView(OnboardingView()),
        AnyView(OnboardingNextView()),
        AnyView(OnboardingLastView())
    ]
    private enum Page: Int, CaseIterable {
        case welcome
        case services
        case letstart
    }
    var container: Container
    
    deinit {
        logger.info("❌ Deinit of Onboarding Navigation Coordinator")
    }
    
    init(container: Container) {
        self.container = container
    }
    
    private(set) lazy var navigationController: UINavigationController = makeNavigationController()
    private var cancellables = Set<AnyCancellable>()
    private let eventSubject = PassthroughSubject<OnboardingNavigationCoordinatorEvent, Never>()
    var childCoordinators: [any Coordinator] = []
}

// MARK: - Factories
extension OnboardingNavigationCoordinator {
    func makeNavigationController() -> UINavigationController {
        let navigationController = CustomNavigationController()
        navigationController.eventPublisher.sink { [weak self] _ in // swiftlint:disable:next conditional_returns_on_newline
            guard let self else { return }
            self.eventSubject.send(.dismiss(self))
        }
        .store(in: &cancellables)
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.modalTransitionStyle = .crossDissolve
        return navigationController
    }
    
    func start() {
        navigationController.setViewControllers(
            [makeOnboardingView(page: Page.welcome)],
            animated: false
        )
    }
}

extension OnboardingNavigationCoordinator {
    private func makeOnboardingView(page: Page) -> UIViewController {
        switch page {
        case .welcome:
            return createHostingController(for: OnboardingView(), page: page)
        case .services:
            return createHostingController(for: OnboardingNextView(), page: page)
        case .letstart:
            return createHostingController(for: OnboardingLastView(), page: page)
        }
    }
    
    private func createHostingController<T: EventEmittingView>(for view: T, page: Page) -> UIHostingController<T> {
        view.eventPublisher.sink { [weak self] event in // swiftlint:disable:next conditional_returns_on_newline
            guard let self = self else { return } // swiftlint:disable:next force_cast
            self.handleEvent(from: page, event: event as! OnboardingViewEvent)
        }
        .store(in: &cancellables)
        return UIHostingController(rootView: view)
    }
    
    private func handleEvent(from page: Page, event: OnboardingViewEvent) {
        switch event {
        case .close:
            navigationController.dismiss(animated: true)
        case let .nextPage(from):
            let newPage: Page
            if from < Page.allCases.count - 1 {
                newPage = Page(rawValue: from + 1) ?? Page.letstart
            } else {
                newPage = Page.welcome
            }
            let viewController = makeOnboardingView(page: newPage)
            if newPage == Page.welcome {
                navigationController.setViewControllers([viewController], animated: true)
            } else {
                navigationController.pushViewController(viewController, animated: true)
            }
        }
    }
}


extension OnboardingNavigationCoordinator: EventEmitting {
    var eventPublisher: AnyPublisher<OnboardingNavigationCoordinatorEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
}
