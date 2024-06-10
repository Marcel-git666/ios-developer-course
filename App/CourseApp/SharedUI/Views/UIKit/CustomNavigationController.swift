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
    private let logger = Logger()
    private let eventSubject = PassthroughSubject<CustomNavigationControllerEvent, Never>()
    private var isSwipingBack = false
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarAppearance()
        delegate = self
        interactivePopGestureRecognizer?.delegate = self
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if isBeingDismissed {
            eventSubject.send(.dismiss)
        }
    }
}

// MARK: - EventEmitting
extension CustomNavigationController: EventEmitting {
    var eventPublisher: AnyPublisher<CustomNavigationControllerEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
}

// MARK: - UIGestureRecognizerDelegate
extension CustomNavigationController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        logger.info("Gesture recognizer: \(gestureRecognizer)")
        isSwipingBack = gestureRecognizer == interactivePopGestureRecognizer
        return true
    }
}

// MARK: - UINavigationControllerDelegate
extension CustomNavigationController: UINavigationControllerDelegate {
    func navigationController(
        _ navigationController: UINavigationController,
        didShow viewController: UIViewController,
        animated _: Bool
    ) {
        if isSwipingBack {
            logger.info("Swiped back to \(viewController)")
            eventSubject.send(.swipeback)
            isSwipingBack.toggle()
        }
    }
}
