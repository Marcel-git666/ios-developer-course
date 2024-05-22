//
//  TextType.swift
//  CourseApp
//
//  Created by Marcel Mravec on 17.05.2024.
//

import SwiftUI
import UIKit

enum FontSize: CGFloat {
    case size36 = 36
    case size28 = 28
    case size20 = 20
    case size12 = 12
}

enum FontType: String {
    case regular = "Poppins-Regular"
    case bold = "Poppins-Bold"
    case mediumItalic = "Poppins-MediumItalic"
}

struct TextTypeModifier: ViewModifier {
    let textType: TextType
    func body(content: Content) -> some View {
        content
            .font(textType.font)
            .foregroundColor(textType.color)
    }
}

enum TextType {
    case h1Title
    case h2Title
    
    var font: Font {
        switch self {
        case .h1Title:
            .bold(with: .size36)
        default:
            .regular(with: .size20)
        }
    }
    
    var color: Color {
        switch self {
        case .h1Title:
            .white
        default:
            .gray
        }
    }
}

extension View {
    func textTypeModifier(textType: TextType) -> some View {
        self.modifier(TextTypeModifier(textType: textType))
    }
}
