//
//  SwipingNavigationCoordinator.swift
//  CourseApp
//
//  Created by Marcel Mravec on 26.05.2024.
//

import Combine
import os
import SwiftUI
import UIKit

final class SwipingNavigationCoordinator: NSObject, NavigationControllerCoordinator {
    private(set) var navigationController: UINavigationController = CustomNavigationController()
    
    var childCoordinators = [Coordinator]()
    private lazy var logger = Logger()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: Lifecycle
    deinit {
        logger.info("Deinit SwipingViewNavigationCoordinator")
    }
}

extension SwipingNavigationCoordinator {
    func start() {
        navigationController.setViewControllers([makeSwipingCard(nil)], animated: true)
    }
}

extension SwipingNavigationCoordinator {
    func makeSwipingCard(_ joke: Joke?) -> UIViewController {
        let store = SwipingViewStore(joke: joke)
        store.eventPublisher.sink { event in
            self.handleEvent(event)
        }
        .store(in: &cancellables)
        return UIHostingController(rootView: SwipingView(store: store))
    }
    
    func handleEvent(_ event: SwipingViewEvent) {
        switch event {
        case .dismiss:
            navigationController.popToRootViewController(animated: true)
        }
    }
}
