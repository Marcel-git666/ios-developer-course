//
//  FirebaseStoreManager.swift
//  CourseApp
//
//  Created by Marcel Mravec on 11.06.2024.
//

import FirebaseFirestore
import Foundation
import os

final class FirebaseStoreManager: StoreManaging {
    private let database = Firestore.firestore()
    private let logger = Logger()

    func storeLike(jokeId: String, liked: Bool) async throws {
        do {
            try await database.collection("jokesLikes").document(jokeId).setData([
                "liked": liked
            ])
            logger.info("Document successfully written!")
        } catch {
            logger.info("Error writing document: \(error)")
        }
    }

    func fetchLiked(jokeId: String) async throws -> Bool {
        let docRef = database.collection("jokesLikes").document(jokeId)
        do {
            let document = try await docRef.getDocument()
            logger.info("Reading document: \(document.data()?.description ?? "")")
            if let liked = document.data()?["liked"] as? Bool {
                return liked
            }
        } catch {
            logger.info("Error reading document: \(error)")
        }
        return false
    }
}
