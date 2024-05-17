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
    }
    
    func setupGlobalTabBarUI() {
        UITabBar.appearance().backgroundColor = .brown
        UITabBar.appearance().tintColor = .white
    }
}
