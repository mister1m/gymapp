//
//  WorkoutService.swift
//  Forgeapp
//
//  Created by Lotte Faber on 23/09/2024.
//

import Firebase
import FirebaseAuth
import FirebaseFirestore

struct WorkoutService {
    static func uploadWorkload( workout: Workout) async throws -> String {
        do {
            let workoutData = try Firestore.Encoder().encode(workout)
            let documentReference = try await Firestore.firestore().collection("workouts").addDocument(data: workoutData)
            return documentReference.documentID
        } catch {
            throw error
        }
    }
}
