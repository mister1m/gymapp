//
//  WorkoutService.swift
//  Forgeapp
//
//  Created by Lotte Faber on 23/09/2024.
//

import Firebase
import FirebaseAuth
import FirebaseFirestore

class WorkoutService: ObservableObject {
    private var db = Firestore.firestore()
    
    // Function to fetch all workouts for a user
    func getWorkoutsForUser(completion: @escaping ([Workout]?, Error?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let userWorkoutsRef = db.collection("users").document(uid).collection("workouts")
        
        userWorkoutsRef.getDocuments { (snapshot, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            var workouts: [Workout] = []
            
            // Parse each document into Workout
            snapshot?.documents.forEach { document in
                do {
                    let workout = try document.data(as: Workout.self)
                    workouts.append(workout)
                } catch {
                    print("Error decoding workout: \(error)")
                }
            }
            print("Error decoding workout: \(workouts)")
            completion(workouts, nil)
        }
    }
    
    // Fetch exercises for a particular workout
    func getExercisesForWorkout( workoutId: String, completion: @escaping ([Exercise]?, Error?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let exercisesRef = db.collection("users").document(uid).collection("workouts").document(workoutId).collection("exercises")
        
        exercisesRef.getDocuments { (snapshot, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            var exercises: [Exercise] = []
            
            // Parse each document into Exercise
            snapshot?.documents.forEach { document in
                do {
                    let exercise = try document.data(as: Exercise.self)
                    exercises.append(exercise)
                } catch {
                    print("Error decoding exercise: \(error)")
                }
            }

            completion(exercises, nil)
        }
    }
}
