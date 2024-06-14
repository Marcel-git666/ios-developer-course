//
//  ProfileView.swift
//  CourseApp
//
//  Created by Marcel Mravec on 27.05.2024.
//

import Combine
import SwiftUI

struct ProfileView: EventEmittingView {
    typealias Event = ProfileViewEvent
    
    private let eventSubject = PassthroughSubject<ProfileViewEvent, Never>()
    
    var body: some View {
        VStack {
            Text("Profile page")
            Button {
                // code
            } label: {
                Text("Save profile")
            }
            .buttonStyle(OnboardingButtonStyle(color: .purple))
            Button {
                eventSubject.send(.startOnboarding)
            } label: {
                Text("Onboarding")
            }
            .buttonStyle(OnboardingButtonStyle(color: .purple))
            Button {
                eventSubject.send(.logout)
            } label: {
                Text("Logout")
            }
            .buttonStyle(OnboardingButtonStyle(color: .purple))
        }
    }
}

extension ProfileView {
    var eventPublisher: AnyPublisher<Event, Never> {
        eventSubject.eraseToAnyPublisher()
    }
}

#Preview {
    ProfileView()
}
