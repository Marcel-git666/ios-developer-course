//
//  CancellablesContaining.swift
//  CourseApp
//
//  Created by Marcel Mravec on 17.06.2024.
//

import Combine

/// Protocol used to enable `cancellables` to be used in default implementation of methods in protocols Coordinating
protocol CancellablesContaining: AnyObject {
    var cancellables: Set<AnyCancellable> { get set }
}
