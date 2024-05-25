//
//  UINavigationController+Ext.swift
//  CourseApp
//
//  Created by Marcel Mravec on 25.05.2024.
//

import UIKit

extension UINavigationController {
    func setupNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemBrown
        appearance.shadowImage = UIImage()
        appearance.shadowColor = .clear
        appearance.titleTextAttributes = [
            NSAttributedString.Key.font: TextType.navigationTitle.uiFont,
            NSAttributedString.Key.foregroundColor: TextType.navigationTitle.uiColor
        ]

        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
}
