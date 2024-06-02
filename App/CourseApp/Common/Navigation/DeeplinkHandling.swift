//
//  DeeplinkHandling.swift
//  CourseApp
//
//  Created by Marcel Mravec on 01.06.2024.
//

import Foundation

protocol DeeplinkHandling: AnyObject {
    func handleDeeplink(_ deeplink: Deeplink)
}
