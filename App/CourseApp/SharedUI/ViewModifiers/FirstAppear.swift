//
//  FirstAppear.swift
//  CourseApp
//
//  Created by Marcel Mravec on 09.06.2024.
//

import SwiftUI

private struct FirstAppear: ViewModifier {
    let action: VoidAction

    @State private var isFirstAppear = true

    func body(content: Content) -> some View {
        content.onAppear {
            if isFirstAppear {
                isFirstAppear = false
                action()
            }
        }
    }
}

extension View {
    func onFirstAppear(_ action: @escaping () -> Void) -> some View {
        modifier(FirstAppear(action: action))
    }
}
