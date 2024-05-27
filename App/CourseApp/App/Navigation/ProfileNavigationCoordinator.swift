//
//  ProfileNavigationCoordinator.swift
//  CourseApp
//
//  Created by Marcel Mravec on 27.05.2024.
//

import SwiftUI
import UIKit

final class ProfileNavigationCoordinator: NSObject, NavigationControllerCoordinator {
    private(set) var navigationController: UINavigationController = CustomNavigationController()
    
    var childCoordinators = [Coordinator]()
    
    func start() {
        navigationController.setViewControllers([makeProfile()], animated: true)
    }
}

// MARK: - Factories
private extension ProfileNavigationCoordinator {
    func makeProfile() -> UIViewController {
        UIHostingController(rootView: ProfileView())
    }
}
