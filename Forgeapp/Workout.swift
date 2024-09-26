//
//  Workout.swift
//  Forgeapp
//
//  Created by Lotte Faber on 23/09/2024.
//

import Firebase
import FirebaseFirestore

// Exercise Model
struct Exercise: Identifiable, Codable {
    @DocumentID var id: String? // Unique ID for each exercise
    var name: String
    var sets: Int
    var reps: [Int]
    var notes: String

    init(name: String, sets: Int, reps: [Int], notes: String, superset: Bool? = false) {
        self.name = name
        self.sets = sets
        self.reps = reps
        self.notes = notes
    }
}

// Workout Model
struct Workout: Identifiable, Codable {
    @DocumentID var id: String? // Unique ID for each workout
    var title: String
    var description: String
    var muscleGroup: [String]
    var exercises: [Exercise]? // Array to hold all exercises in the workout

    init(title: String, description: String, muscleGroup: [String], exercises: [Exercise]? = nil) {
        self.title = title
        self.description = description
        self.muscleGroup = muscleGroup
        self.exercises = exercises
    }
}
