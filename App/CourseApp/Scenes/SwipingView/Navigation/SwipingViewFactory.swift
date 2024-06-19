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
    func handleEvent(_ event: SwipingViewEvent)
}

extension SwipingViewFactory where Self: ViewControllerCoordinator & CancellablesContaining {
    func makeSwipingCard() -> UIViewController {
        let store = container.resolve(type: SwipingViewStore.self)
        store.eventPublisher.sink { [weak self] event in
            self?.handleEvent(event)
        }
        .store(in: &cancellables)
        return UIHostingController(rootView: SwipingView(store: store))
    }
}
