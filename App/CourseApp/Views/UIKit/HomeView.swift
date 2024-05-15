//
//  HomeView.swift
//  CourseApp
//
//  Created by Marcel Mravec on 15.05.2024.
//

import SwiftUI

// MARK: - HELPER
struct HomeView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> HomeViewController {
        //        let storyboard = UIStoryboard(name: "HomeViewController", bundle: nil)
        //        if let viewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController {
        //            return viewController
        //        }
        HomeViewController()
    }
    
    func updateUIViewController(_ uiViewController: HomeViewController, context: Context) {
    }
}
