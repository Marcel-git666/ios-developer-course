//
//  SwipingNavigationCoordinator.swift
//  CourseApp
//
//  Created by Marcel Mravec on 26.05.2024.
//

import Combine
import DependencyInjection
import os
import SwiftUI
import UIKit

final class SwipingNavigationCoordinator: NSObject, NavigationControllerCoordinator, CancellablesContaining, SwipingViewFactory {
    private(set) lazy var navigationController: UINavigationController = CustomNavigationController()
    var container: Container
    var childCoordinators = [Coordinator]()
    private lazy var logger = Logger()
    var cancellables = Set<AnyCancellable>()
    
    // MARK: Lifecycle
    deinit {
        logger.info("Deinit SwipingViewNavigationCoordinator")
    }
    
    init(container: Container) {
        self.container = container
    }
}

extension SwipingNavigationCoordinator {
    func start() {
        navigationController.setViewControllers([makeSwipingCard()], animated: true)
    }
}

extension SwipingNavigationCoordinator {
    func handleSwipingEvent(_ event: SwipingViewEvent) {
        switch event {
        case .dismiss:
            navigationController.popToRootViewController(animated: true)
        }
    }
}
