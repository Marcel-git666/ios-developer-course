//
//  ProfileCoordinator.swift
//  CourseApp
//
//  Created by Marcel Mravec on 27.05.2024.
//

import SwiftUI
import UIKit

final class ProfileCoordinator: NSObject, NavigationControllerCoordinator {
    private(set) var navigationController: UINavigationController = CustomNavigationController()
    
    var childCoordinators = [Coordinator]()
    
    func start() {
        navigationController.setViewControllers([makeProfile()], animated: true)
    }
}

// MARK: - Factories
private extension ProfileCoordinator {
    func makeProfile() -> UIViewController {
        UIHostingController(rootView: ProfileView())
    }
}
