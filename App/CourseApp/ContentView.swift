//
//  ContentView.swift
//  CourseApp
//
//  Created by Marcel Mravec on 25.04.2024.
//

import os
import SwiftUI

struct ContentView: View {
    var logger = Logger()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Text("test")
        }
        .padding()
        .onAppear {
            logger.log("🦈 ContentView has appeared.")
        }
    }
}

#Preview {
    ContentView()
}
