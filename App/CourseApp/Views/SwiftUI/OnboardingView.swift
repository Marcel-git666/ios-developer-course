//
//  OnboardingView.swift
//  CourseApp
//
//  Created by Marcel Mravec on 26.05.2024.
//

import SwiftUI

struct OnboardingView: View {
    let coordinator: OnboardingNavigationCoordinator
    
    var body: some View {
        VStack {
            Text("Onboarding page 0")
            Button {
                coordinator.handleDeeplink(deeplink: .onboarding(page: 1))
            } label: {
                Text("Move to next screen")
            }
            .buttonStyle(OnboardingButtonStyle(color: .purple))
        }
    }
}

#Preview {
    OnboardingView(coordinator: OnboardingNavigationCoordinator(currentPage: 0))
}
