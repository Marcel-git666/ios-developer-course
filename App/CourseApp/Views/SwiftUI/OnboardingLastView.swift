//
//  OnboardingLastView.swift
//  CourseApp
//
//  Created by Marcel Mravec on 27.05.2024.
//

import SwiftUI

struct OnboardingLastView: View {
    let coordinator: OnboardingNavigationCoordinator
    
    var body: some View {
        VStack {
            Text("Onboarding page 2")
            Button {
                coordinator.handleDeeplink(deeplink: .onboarding(page: 0))
            } label: {
                Text("Back to first page")
            }
            .buttonStyle(OnboardingButtonStyle(color: .purple))
            Button {
                coordinator.handleDeeplink(deeplink: .closeOnboarding)
            } label: {
                Text("Dismiss onboarding")
            }
            .buttonStyle(OnboardingButtonStyle(color: .purple))
        }
    }
}

#Preview { // swiftlint:disable:next no_magic_numbers
    OnboardingLastView(coordinator: OnboardingNavigationCoordinator(currentPage: 2))
}
