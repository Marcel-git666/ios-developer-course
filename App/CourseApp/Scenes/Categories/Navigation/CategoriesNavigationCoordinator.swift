//
//  CategoriesNavigationCoordinator.swift
//  CourseApp
//
//  Created by Marcel Mravec on 27.05.2024.
//

import Combine
import os
import SwiftUI
import UIKit

protocol CategoriesNavigationCoordinating: NavigationControllerCoordinator, SwipingViewFactory {}

final class CategoriesNavigationCoordinator: CategoriesNavigationCoordinating  {
    private(set) lazy var navigationController: UINavigationController = CustomNavigationController()
    var childCoordinators = [Coordinator]()
    private let eventSubject = PassthroughSubject<CategoriesNavigationCoordinatorEvent, Never>()
    private lazy var cancellables = Set<AnyCancellable>()
    private let logger = Logger()
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
            navigationController.pushViewController(makeSwipingCard(), animated: true)
        }
    }
}
