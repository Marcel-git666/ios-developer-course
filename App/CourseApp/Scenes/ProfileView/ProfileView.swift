//
//  ProfileView.swift
//  CourseApp
//
//  Created by Marcel Mravec on 27.05.2024.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack {
            Text("Profile page")
            Button {
                // code
            } label: {
                Text("Save profile")
            }
            .buttonStyle(OnboardingButtonStyle(color: .purple))
        }
    }
}

#Preview {
    ProfileView()
}
