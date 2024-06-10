//
//  Image+ResizableBordered.swift
//  CourseApp
//
//  Created by Marcel Mravec on 16.05.2024.
//

import SwiftUI

extension Image {
    func resizableBordered(cornerRadius: CGFloat = 10) -> some View {
        self
            .resizable()
            .scaledToFill()
            .bordered(cornerRadius: cornerRadius)
    }
}
