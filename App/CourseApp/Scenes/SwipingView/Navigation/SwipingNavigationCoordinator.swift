//
//  SwipingNavigationCoordinator.swift
//  CourseApp
//
//  Created by Marcel Mravec on 26.05.2024.
//

import UIKit

final class SwipingNavigationCoordinator: NSObject, NavigationControllerCoordinator, SwipingViewFactory {
    private(set) var navigationController: UINavigationController = CustomNavigationController()
    
    var childCoordinators = [Coordinator]()
    
    func start() {
        navigationController.setViewControllers([makeSwipingCard()], animated: true)
    }
}
