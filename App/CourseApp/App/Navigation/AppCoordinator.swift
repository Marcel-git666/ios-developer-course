//
//  AppCoordinator.swift
//  CourseApp
//
//  Created by Marcel Mravec on 25.05.2024.
//

import Combine
import DependencyInjection
import os
import UIKit

protocol AppCoordinating: ViewControllerCoordinator {}

final class AppCoordinator: AppCoordinating, ObservableObject {
    private(set) lazy var rootViewController: UIViewController = {
        if isAuthorized {
            makeTabBarFlow().rootViewController
        } else {
            makeLoginFlow().rootViewController
        }
    }()
    var childCoordinators = [Coordinator]()
    var container = Container()
    private lazy var cancellables = Set<AnyCancellable>()
    private lazy var keychainService = KeychainService(keychainManager: KeychainManager())
    private lazy var logger = Logger()
    @Published var isAuthorized = false
    
    // MARK: Lifecycle
    init() {
        isAuthorized = (try? keychainService.fetchAuthData()) != nil
    }
}

extension AppCoordinator {
    func start() {
        setupAppUI()
        assembleDependencyInjectionContainer()
    }
    
    func assembleDependencyInjectionContainer() {
        ManagerRegistration.registerDependencies(to: container)
        ServiceRegistration.registerDependencies(to: container)
        StoreRegistration.registerDependencies(to: container)
    }
    
    func setupAppUI() {
        UITabBar.appearance().backgroundColor = .systemBrown
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().tintColor = .white
        UITabBarItem.appearance().setTitleTextAttributes(
            [
                NSAttributedString.Key.font: TextType.caption.uiFont
            ], for: .normal
        )
        UINavigationBar.appearance().tintColor = .white
    }
    
    func makeLoginFlow() -> ViewControllerCoordinator {
        let loginCoordinator = LoginNavigationCoordinator(container: container)
        startChildCoordinator(loginCoordinator)
        loginCoordinator.eventPublisher.sink { [weak self] event in
            self?.handleEvent(event)
        }
        .store(in: &cancellables)
        return loginCoordinator
    }
    
    func makeTabBarFlow() -> ViewControllerCoordinator {
        let mainTabBarCoordinator = MainTabBarCoordinator(container: container)
        startChildCoordinator(mainTabBarCoordinator)
        mainTabBarCoordinator.eventPublisher.sink { [weak self] event in
            self?.handleEvent(event)
        }
        .store(in: &cancellables)
        return mainTabBarCoordinator
    }
    
    func handleDeeplink(deeplink: Deeplink) {
        childCoordinators.forEach { $0.handleDeeplink(deeplink) }
    }
}

extension AppCoordinator {
    func handleEvent(_ event: LoginNavigationEvent) {
        switch event {
        case let .signedIn(coordinator):
            rootViewController = makeTabBarFlow().rootViewController
            release(coordinator: coordinator)
            isAuthorized = true
        }
    }
    
    func handleEvent(_ event: MainTabBarEvent) {
        switch event {
        case let .logout(coordinator):
            rootViewController = makeLoginFlow().rootViewController
            release(coordinator: coordinator)
            do {
                try keychainService.removeAuthData()
            } catch {
                logger.error("❌ AuthData not removed!")
            }
            isAuthorized = false
        }
    }
}
