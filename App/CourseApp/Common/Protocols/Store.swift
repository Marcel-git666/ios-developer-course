//
//  Store.swift
//  CourseApp
//
//  Created by Marcel Mravec on 17.06.2024.
//

import Foundation

protocol Store {
    associatedtype State
    associatedtype Action

    /// Object that fully captures current state of a scene
    @MainActor var state: State { get }

    /// This method should be called whenever any action takes place
    /// Each state update must preceded by an action
    ///
    /// - Parameter action: Action that took place
    @MainActor func send(_ action: Action)
}
