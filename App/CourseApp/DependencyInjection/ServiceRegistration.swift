//
//  ServiceRegistration.swift
//  CourseApp
//
//  Created by Marcel Mravec on 17.06.2024.
//

import DependencyInjection

enum ServiceRegistration {
    static func registerDependencies(to container: Container) {
        container.autoregister(
            type: KeychainServicing.self,
            in: .shared,
            initializer: KeychainService.init
            )
        container.autoregister(
            type: JokeServicing.self,
            in: .shared,
            initializer: MockJokeService.init
            )
    }
}
