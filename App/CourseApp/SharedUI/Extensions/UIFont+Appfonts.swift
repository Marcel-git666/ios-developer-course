//
//  UIFont+Ext.swift
//  CourseApp
//
//  Created by Marcel Mravec on 22.05.2024.
//

import UIKit

// swiftlint:disable force_unwrapping
extension UIFont {
    static func regular(with size: FontSize) -> UIFont {
        UIFont(name: FontType.regular.rawValue, size: size.rawValue)!
    }
    static func bold(with size: FontSize) -> UIFont {
        UIFont(name: FontType.bold.rawValue, size: size.rawValue)!
    }
    static func mediumItalic(with size: FontSize) -> UIFont {
        UIFont(name: FontType.mediumItalic.rawValue, size: size.rawValue)!
    }
}
// swiftlint:enable force_unwrapping
