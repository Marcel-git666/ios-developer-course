//
//  OnboardingViewEvent.swift
//  CourseApp
//
//  Created by Marcel Mravec on 29.05.2024.
//

import Foundation

protocol OnboardingEvent {}

enum OnboardingViewEvent: OnboardingEvent {
    case nextPage(from: Int)
    case close
}
