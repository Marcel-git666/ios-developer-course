//
//  HomeViewController.swift
//  CourseApp
//
//  Created by Marcel Mravec on 10.05.2024.
//

import UIKit
import SwiftUI

final class HomeViewController: UIViewController {

    @IBOutlet var categoriesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
    }


}

// MARK: - UISetup

private extension HomeViewController {
    func setup() {
        
//        readData()
    }

    
}

// MARK: - HELPER
struct HomeView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> HomeViewController {
//        let storyboard = UIStoryboard(name: "HomeViewController", bundle: nil)
//        if let viewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController {
//            return viewController
//        }
        return HomeViewController()
    }

    func updateUIViewController(_ uiViewController: HomeViewController, context: Context) {

    }
}
