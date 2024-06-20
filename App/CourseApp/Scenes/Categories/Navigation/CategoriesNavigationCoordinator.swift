//
//  CategoriesNavigationCoordinator.swift
//  CourseApp
//
//  Created by Marcel Mravec on 27.05.2024.
//

import Combine
import DependencyInjection
import os
import SwiftUI
import UIKit

protocol CategoriesNavigationCoordinating: NavigationControllerCoordinator {}

final class CategoriesNavigationCoordinator: CategoriesNavigationCoordinating, SwipingViewFactory, CancellablesContaining {
    private(set) lazy var navigationController: UINavigationController = CustomNavigationController()
    var childCoordinators = [Coordinator]()
    private let eventSubject = PassthroughSubject<CategoriesNavigationCoordinatorEvent, Never>()
    var cancellables = Set<AnyCancellable>()
    private let logger = Logger()
    var container: Container
    
    init(container: Container) {
        self.container = container
    }
}

extension CategoriesNavigationCoordinator: EventEmitting {
    var eventPublisher: AnyPublisher<CategoriesNavigationCoordinatorEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
}

extension CategoriesNavigationCoordinator {
    func start() {
        navigationController.setViewControllers([makeCategoriesView()], animated: true)
    }
}

private extension CategoriesNavigationCoordinator {
    func makeCategoriesView() -> UIViewController {
        let categoriesView = CategoriesViewController()
        categoriesView.eventPublisher.sink { [weak self] event in
            self?.handleEvent(event)
        }
        .store(in: &cancellables)
        return categoriesView
    }
}

// MARK: - Handling events
private extension CategoriesNavigationCoordinator {
    func handleEvent(_ event: CategoriesViewEvent) {
        switch event {
        case let .itemTapped(joke):
            logger.info("Joke on home screen was tapped \(joke.text)")
            logger.info("Categories: \(joke.categories.description)")
            navigationController.pushViewController(makeSwipingCard(), animated: true)
        }
    }
}

extension CategoriesNavigationCoordinator {
    func handleEvent(_ event: SwipingViewEvent) {
        switch event {
        case .dismiss:
            navigationController.popViewController(animated: true)
        }
    }
}
