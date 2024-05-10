//
//  ContentView.swift
//  CourseApp
//
//  Created by Marcel Mravec on 25.04.2024.
//

import os
import SwiftUI

struct ContentView: View {
    private let jokesBaseURL = Configuration.default.apiJokesBaseURL
    var logger = Logger()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                .font(.custom("Poppins-MediumItalic", size: 36))
            Text("test")
        }
        .padding()
        .onAppear {
            logger.info("🐴 Jokes base url \(jokesBaseURL)")
            logger.log("🦈 ContentView has appeared.")
            // Use this identifier to filter out the system fonts in the logs.
            let identifier: String = "[SYSTEM FONTS]"
            // Here's the functionality that prints all the system fonts.
            for family in UIFont.familyNames as [String] {
                debugPrint("\(identifier) FONT FAMILY :  \(family)")
                for name in UIFont.fontNames(forFamilyName: family) {
                    debugPrint("\(identifier) FONT NAME :  \(name)")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
