//
//  SwipingNavigationCoordinator.swift
//  CourseApp
//
//  Created by Marcel Mravec on 26.05.2024.
//

import SwiftUI
import UIKit

final class SwipingNavigationCoordinator: NSObject, NavigationControllerCoordinator {
    private(set) var navigationController: UINavigationController = CustomNavigationController()
    
    var childCoordinators = [Coordinator]()
    
    func start() {
        navigationController.setViewControllers([makeSwipingCard()], animated: true)
    }
}

// MARK: - Factories
private extension SwipingNavigationCoordinator {
    func makeSwipingCard() -> UIViewController {
        UIHostingController(rootView: SwipingView())
    }
}
