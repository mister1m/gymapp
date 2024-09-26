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
    
    // Fetch workouts for a user with exercise count
    func getWorkoutsForUser(completion: @escaping ([Workout]?, Error?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let userWorkoutsRef = db.collection("users").document(uid).collection("workouts")
        
        userWorkoutsRef.getDocuments { (snapshot, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            var workouts: [Workout] = []
            let dispatchGroup = DispatchGroup()
            
            snapshot?.documents.forEach { document in
                do {
                    var workout = try document.data(as: Workout.self)
                    guard let workoutId = workout.id else { return }
                    
                    // Fetch exercise count for each workout
                    dispatchGroup.enter()
                    self.getExercisesCountForWorkout(workoutId: workoutId) { count in
                        workout.exerciseCount = count
                        workouts.append(workout)
                        dispatchGroup.leave()
                    }
                } catch {
                    print("Error decoding workout: \(error)")
                }
            }
            
            dispatchGroup.notify(queue: .main) {
                completion(workouts, nil)
            }
        }
    }
    
    // Fetch exercise count for a workout
    func getExercisesCountForWorkout(workoutId: String, completion: @escaping (Int) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let exercisesRef = db.collection("users").document(uid).collection("workouts").document(workoutId).collection("exercises")
        
        exercisesRef.getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching exercises count: \(error)")
                completion(0)
                return
            }
            
            let count = snapshot?.documents.count ?? 0
            completion(count)
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
