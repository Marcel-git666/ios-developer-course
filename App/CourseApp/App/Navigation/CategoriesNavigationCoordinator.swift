//
//  CategoriesNavigationCoordinator.swift
//  CourseApp
//
//  Created by Marcel Mravec on 27.05.2024.
//

import SwiftUI
import UIKit

final class CategoriesNavigationCoordinator: NSObject, NavigationControllerCoordinator {
    private(set) var navigationController: UINavigationController = CustomNavigationController()
    
    var childCoordinators = [Coordinator]()
    
    func start() {
        navigationController.setViewControllers([CustomNavigationController(rootViewController: HomeViewController())], animated: true)
    }
}
