//
//  StoreManaging.swift
//  CourseApp
//
//  Created by Marcel Mravec on 13.06.2024.
//

import Foundation

protocol StoreManaging {
    func storeLike(jokeId: String, liked: Bool) async throws
    func fetchLiked(jokeId: String) async throws -> Bool
}
