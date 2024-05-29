//
//  OnboardingLastView.swift
//  CourseApp
//
//  Created by Marcel Mravec on 27.05.2024.
//

import Combine
import SwiftUI

struct OnboardingLastView: EventEmittingView {
    typealias Event = OnboardingViewEvent
    
    private let eventSubject = PassthroughSubject<OnboardingViewEvent, Never>()
    
    var body: some View {
        VStack {
            Text("Onboarding page 2")
            Button { // swiftlint:disable:next no_magic_numbers
                eventSubject.send(.nextPage(from: 2))
            } label: {
                Text("Back to first page")
            }
            .buttonStyle(OnboardingButtonStyle(color: .purple))
            Button {
                eventSubject.send(.close)
            } label: {
                Text("Dismiss onboarding")
            }
            .buttonStyle(OnboardingButtonStyle(color: .purple))
        }
    }
}

extension OnboardingLastView {
    var eventPublisher: AnyPublisher<Event, Never> {
        eventSubject.eraseToAnyPublisher()
    }
}

#Preview {
    OnboardingLastView()
}
