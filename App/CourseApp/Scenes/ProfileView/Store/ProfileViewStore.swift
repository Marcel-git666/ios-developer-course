//
//  ProfileViewStore.swift
//  CourseApp
//
//  Created by Marcel Mravec on 18.06.2024.
//

import Combine
import Foundation
import os

final class ProfileViewStore: ObservableObject, Store {

    private let logger = Logger()
    private let eventSubject = PassthroughSubject<ProfileViewEvent, Never>()
    var eventPublisher: AnyPublisher<ProfileViewEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
    @Published var state: ProfileViewState = .initial
}

extension ProfileViewStore {
    func send(_ action: ProfileViewAction) {
        switch action {
        case .logout:
            eventSubject.send(.logout)
        case .startOnboarding:
            eventSubject.send(.startOnboarding)
        }
    }
}
