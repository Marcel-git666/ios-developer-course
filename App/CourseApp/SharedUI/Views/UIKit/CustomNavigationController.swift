//
//  CustomNavigationController.swift
//  CourseApp
//
//  Created by Marcel Mravec on 25.05.2024.
//

import Combine
import os
import UIKit

class CustomNavigationController: UINavigationController {
    let logger = Logger()
    
    private let eventSubject = PassthroughSubject<CustomNavigationControllerEvent, Never>()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarAppearance()
        delegate = self
        interactivePopGestureRecognizer?.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        logger.info("\(self.isBeingDismissed)")
        logger.info("\(self.isMovingFromParent)")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if isBeingDismissed {
            eventSubject.send(.dismiss)
        }
    }
}

extension CustomNavigationController: EventEmitting {
    var eventPublisher: AnyPublisher<CustomNavigationControllerEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
}

extension CustomNavigationController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        logger.info("Gesture recognizer: \(gestureRecognizer)")
        return true
    }
}

extension CustomNavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        logger.info("Will show: \(viewController)")
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        logger.info("Did show: \(viewController)")
    }
}
