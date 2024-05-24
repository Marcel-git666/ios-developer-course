//
//  EmbedInScrollView.swift
//  CourseApp
//
//  Created by Marcel Mravec on 24.05.2024.
//

import SwiftUI

struct EmbedInScrollView: ViewModifier {
    func body(content: Content) -> some View {
        ViewThatFits {
            content
            
            ScrollView {
                content
            }
        }
    }
}

extension View {
    func embedInScrollViewIfNeeded() -> some View {
        modifier(EmbedInScrollView())
    }
}
