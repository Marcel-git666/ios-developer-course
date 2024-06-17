//
//  SwipingViewFactory.swift
//  CourseApp
//
//  Created by Marcel Mravec on 13.06.2024.
//

import SwiftUI
import UIKit

protocol SwipingViewFactory {
    func makeSwipingCard(_ joke: Joke?) -> UIViewController
}

extension SwipingViewFactory {
    func makeSwipingCard(_ joke: Joke?) -> UIViewController {
        UIHostingController(rootView: SwipingView(store: SwipingViewStore(joke: joke)))
    }
}
