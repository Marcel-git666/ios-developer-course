//
//  MainTabBarCoordinator.swift
//  CourseApp
//
//  Created by Marcel Mravec on 24.05.2024.
//

import SwiftUI
import UIKit

final class MainTabBarCoordinator: NSObject, TabBarControllerCoordinator {
    var childCoordinators = [Coordinator]()
    private(set) lazy var tabBarController = makeTabBarController()
}

extension MainTabBarCoordinator {
    func start() {
        tabBarController.viewControllers = [
            setupCategoriesView(),
            setupSwipingCardView()
        ]
    }
}

private extension MainTabBarCoordinator {
    func makeTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.delegate = self
        return tabBarController
    }
    
    func setupCategoriesView() -> UIViewController {
        let categoriesNavigationController = CustomNavigationController(rootViewController: HomeViewController())
        categoriesNavigationController.tabBarItem = UITabBarItem(
            title: "Categories",
            image: UIImage(systemName: "list.bullet.rectangle.portrait"),
            tag: 0
        )
        
        return categoriesNavigationController
    }
    
    func setupSwipingCardView() -> UIViewController {
        let swipingNavigationController = CustomNavigationController(rootViewController: UIHostingController(rootView: SwipingView()))
        swipingNavigationController.tabBarItem = UITabBarItem(title: "Random", image: UIImage(systemName: "switch.2"), tag: 1)
        
        return swipingNavigationController
    }
}

extension MainTabBarCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("VC \(viewController.description) was selected.")
        if viewController === tabBarController.viewControllers?.last {
//            rootViewController.showInfoAlert(title: "Last view controller alert.")
        }
    }
}

extension UIViewController {
    func showInfoAlert(title: String, message: String? = nil, handler: (() -> Void)? = nil) {
        guard presentedViewController == nil else {
            return
        }

        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let okAction = UIAlertAction(
            title: "OK",
            style: .default
        ) { _ in
            handler?()
        }
        alertController.addAction(okAction)

        present(alertController, animated: true)
    }
}
