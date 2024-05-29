//
//  OnboardingNextView.swift
//  CourseApp
//
//  Created by Marcel Mravec on 27.05.2024.
//

import Combine
import SwiftUI

struct OnboardingNextView: EventEmittingView {
    typealias Event = OnboardingViewEvent
    
    private let eventSubject = PassthroughSubject<OnboardingViewEvent, Never>()
    var body: some View {
        VStack {
            Text("Onboarding page 1")
            Button { // swiftlint:disable:next no_magic_numbers
                eventSubject.send(.nextPage(from: 1))
            } label: {
                Text("Move to last screen")
            }
            .buttonStyle(OnboardingButtonStyle(color: .purple))
        }
    }
}

extension OnboardingNextView {
    var eventPublisher: AnyPublisher<Event, Never> {
        eventSubject.eraseToAnyPublisher()
    }
}

#Preview {
    OnboardingNextView()
}
