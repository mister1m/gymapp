//
//  Workout.swift
//  Forgeapp
//
//  Created by Lotte Faber on 23/09/2024.
//

import Firebase
import FirebaseFirestore

struct Workout: Identifiable, Codable {
    @DocumentID var workoutId: String?
    let ownerUid: String
    let timestamp: Timestamp
    let title: String
    let description: String?
    let muscleGroups: [String]?
    let exercises: [Exercise]?
    
    var id: String {
        return workoutId ?? NSUUID().uuidString
    }
}

struct Exercise: Identifiable, Codable {
    let id: String
    let name: String
    let sets: Int
    let reps: [Int]
    let notes: String
    
    // This could be used to store the ID from the external API
    let externalApiId: String?
}
