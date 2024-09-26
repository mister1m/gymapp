//
//  CreateWorkoutViewModel.swift
//  Forgeapp
//
//  Created by Lotte Faber on 23/09/2024.
//

import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

class CreateWorkoutViewModel: ObservableObject {
    @Published var title = ""
    @Published var selectedMuscleGroups: [String] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isWorkoutCreated = false

    func uploadWorkout() {
        guard !title.isEmpty else {
            errorMessage = "Please enter a workout title."
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                guard let uid = Auth.auth().currentUser?.uid else {
                    throw NSError(domain: "AuthError", code: 0, userInfo: [NSLocalizedDescriptionKey: "User not authenticated"])
                }
                
                let workout = Workout(
                    ownerUid: uid,
                    timestamp: Timestamp(),
                    title: title,
                    description: nil,
                    muscleGroups: selectedMuscleGroups.isEmpty ? nil : selectedMuscleGroups,
                    exercises: nil
                )
                
                let newWorkoutId = try await WorkoutService.uploadWorkload(workout: workout)
                
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.isWorkoutCreated = true
                    print("Workout uploaded successfully with ID: \(newWorkoutId)")
                }
            } catch {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.errorMessage = error.localizedDescription
                    print("Error uploading workout: \(error.localizedDescription)")
                }
            }
        }
    }
}
