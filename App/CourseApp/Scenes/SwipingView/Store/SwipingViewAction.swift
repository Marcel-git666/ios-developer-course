//
//  SwipingViewAction.swift
//  CourseApp
//
//  Created by Marcel Mravec on 16.06.2024.
//

import Foundation

enum SwipingViewAction {
    case viewDidLoad
    case dataFetched([Joke])
    case didLike(String, Bool)
    case noMoreJokes
}
