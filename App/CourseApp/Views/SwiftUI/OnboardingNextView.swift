//
//  OnboardingNextView.swift
//  CourseApp
//
//  Created by Marcel Mravec on 27.05.2024.
//

import SwiftUI

struct OnboardingNextView: View {
    let coordinator: OnboardingNavigationCoordinator
    
    var body: some View {
        VStack {
            Text("Onboarding page 1")
            Button {
                coordinator.handleDeeplink(deeplink: .onboarding(page: 2))
            } label: {
                Text("Move to last screen")
            }
            .buttonStyle(OnboardingButtonStyle(color: .purple))
        }
    }
}

#Preview {
    OnboardingNextView(coordinator: OnboardingNavigationCoordinator(currentPage: 1))
}
