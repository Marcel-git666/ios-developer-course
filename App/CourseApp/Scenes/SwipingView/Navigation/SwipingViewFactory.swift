//
//  SwipingViewFactory.swift
//  CourseApp
//
//  Created by Marcel Mravec on 13.06.2024.
//

import SwiftUI
import UIKit

protocol SwipingViewFactory {
    func makeSwipingCard() -> UIViewController
}

extension SwipingViewFactory {
    func makeSwipingCard() -> UIViewController {
        UIHostingController(rootView: SwipingView(store: SwipingViewStore()))
    }
}
