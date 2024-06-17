//
//  ManagerRegistration.swift
//  CourseApp
//
//  Created by Marcel Mravec on 17.06.2024.
//

import DependencyInjection

enum ManagerRegistration {
    static func registerDependencies(to container: Container) {
        container.autoregister(
            type: StoreManaging.self,
            in: .shared,
            initializer: FirebaseStoreManager.init
            )
        container.autoregister(
            type: KeychainManaging.self,
            in: .shared,
            initializer: KeychainManager.init
            )
    }
}
