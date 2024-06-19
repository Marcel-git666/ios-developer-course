//
//  ProfileView.swift
//  CourseApp
//
//  Created by Marcel Mravec on 27.05.2024.
//


import SwiftUI

struct ProfileView: View {
    let store: ProfileViewStore
    
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
                store.send(.startOnboarding)
            } label: {
                Text("Onboarding")
            }
            .buttonStyle(OnboardingButtonStyle(color: .purple))
            Button {
                store.send(.logout)
            } label: {
                Text("Logout")
            }
            .buttonStyle(OnboardingButtonStyle(color: .purple))
        }
    }
}

#Preview {
    ProfileView(store: ProfileViewStore())
}
