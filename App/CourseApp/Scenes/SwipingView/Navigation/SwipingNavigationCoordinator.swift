//
//  SwipingNavigationCoordinator.swift
//  CourseApp
//
//  Created by Marcel Mravec on 26.05.2024.
//

import os
import UIKit

final class SwipingNavigationCoordinator: NSObject, NavigationControllerCoordinator, SwipingViewFactory {
    private(set) var navigationController: UINavigationController = CustomNavigationController()
    
    var childCoordinators = [Coordinator]()
    private lazy var logger = Logger()
    
    // MARK: Lifecycle
    deinit {
        logger.info("Deinit SwipingViewNavigationCoordinator")
    }
}

extension SwipingNavigationCoordinator {
    func start() {
        navigationController.setViewControllers([makeSwipingCard(nil)], animated: true)
    }
}
