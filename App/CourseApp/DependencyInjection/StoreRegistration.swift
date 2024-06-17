//
//  StoreRegistration.swift
//  CourseApp
//
//  Created by Marcel Mravec on 17.06.2024.
//

import DependencyInjection

enum StoreRegistration {
    static func registerDependencies(to container: Container) {
        container.autoregister(
            type: SwipingViewStore.self,
            in: .new,
            initializer: SwipingViewStore.init
            )
    }
}
