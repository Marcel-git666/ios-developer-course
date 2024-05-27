//
//  EventEmitter.swift
//  CourseApp
//
//  Created by Marcel Mravec on 27.05.2024.
//

import Combine

protocol EventEmitting {
    associatedtype Event
    
    var eventPublisher: AnyPublisher<Event, Never> { get }
}
