//
//  SwipingViewState.swift
//  CourseApp
//
//  Created by Marcel Mravec on 16.06.2024.
//

import Foundation

struct SwipingViewState {
    enum Status {
        case initial
        case loading
        case ready
    }
    var jokes: [Joke] = []
    var status: Status = .initial

    static let initial = SwipingViewState()
}
