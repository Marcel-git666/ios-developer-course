//
//  MainTabBarController.swift
//  CourseApp
//
//  Created by Marcel Mravec on 17.05.2024.
//

import SwiftUI
import UIKit

struct MainTabView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> MainTabBarController {
        MainTabBarController()
    }
    
    func updateUIViewController(_ uiViewController: MainTabBarController, context: Context) {}
}

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGlobalTabBarUI()
        setupTabBarControllers()
    }
    
    func setupGlobalTabBarUI() {
        UITabBar.appearance().backgroundColor = .brown
        UITabBar.appearance().tintColor = .white
    }
    
    func setupTabBarControllers() {
        viewControllers = [setupCategoriesView(), setupSwipingCardView()]
    }
    
    func setupCategoriesView() -> UIViewController {
        let categoriesNavigationController = UINavigationController(rootViewController: HomeViewController())
        categoriesNavigationController.tabBarItem = UITabBarItem(
            title: "Categories",
            image: UIImage(systemName: "list.bullet.rectangle.portrait"),
            tag: 0
        )
        setupAppearance(navigationController: categoriesNavigationController)
        
        return categoriesNavigationController
    }
    
    func setupSwipingCardView() -> UIViewController {
        let swipingNavigationController = UINavigationController(rootViewController: UIHostingController(rootView: SwipingView()))
        swipingNavigationController.tabBarItem = UITabBarItem(title: "Random", image: UIImage(systemName: "switch.2"), tag: 1)
        setupAppearance(navigationController: swipingNavigationController)
        
        return swipingNavigationController
    }
    
    func setupAppearance(navigationController: UINavigationController) {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemBrown
        appearance.shadowImage = UIImage()
        
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.compactAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
    }
}
