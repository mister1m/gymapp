import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth

class WorkoutDetailViewModel: ObservableObject {
    @Published var exercises: [Exercise] = []
    @Published var errorMessage: String?

    private let db = Firestore.firestore()

    // Fetch exercises for a particular workout
    func getExercisesForWorkout(workoutId: String) {
        guard let uid = Auth.auth().currentUser?.uid else {
            self.errorMessage = "User not authenticated"
            return
        }

        let exercisesRef = db.collection("users").document(uid).collection("workouts").document(workoutId).collection("exercises")

        exercisesRef.getDocuments { (snapshot, error) in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = "Error fetching exercises: \(error.localizedDescription)"
                }
                return
            }

            var fetchedExercises: [Exercise] = []

            // Parse each document into Exercise
            snapshot?.documents.forEach { document in
                do {
                    let exercise = try document.data(as: Exercise.self)
                    fetchedExercises.append(exercise)
                } catch {
                    print("Error decoding exercise: \(error)")
                }
            }

            // Update the exercises array
            DispatchQueue.main.async {
                self.exercises = fetchedExercises
            }
        }
    }
}
