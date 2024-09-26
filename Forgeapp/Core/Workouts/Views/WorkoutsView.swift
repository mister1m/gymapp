import SwiftUI
import FirebaseAuth

struct WorkoutsView: View {
    @StateObject private var workoutService = WorkoutService()
    @State private var workouts: [Workout] = []
    @State private var errorMessage: String?
    
    var body: some View {
        NavigationView {
            List(workouts) { workout in
                NavigationLink(destination: WorkoutDetailView(workout: workout)) {
                    VStack(alignment: .leading) {
                        Text(workout.title)
                            .font(.headline)
                        Text(workout.muscleGroup.joined(separator: ", "))
                            .font(.subheadline)
                    }
                }
            }

            .navigationTitle("Your Workouts")
            .onAppear {
                fetchWorkouts()
            }
        }
    }
    
    // Function to fetch workouts using the current user's UID
    func fetchWorkouts() {
        
        workoutService.getWorkoutsForUser() { (workouts, error) in
            if let error = error {
                self.errorMessage = "Error fetching workouts: \(error.localizedDescription)"
            } else if let workouts = workouts {
                self.workouts = workouts
            }
        }
    }
}

struct WorkoutDetailView: View {
    let workout: Workout
    @StateObject private var viewModel = WorkoutDetailViewModel()

    var body: some View {
        VStack {
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            } else {
                List(viewModel.exercises) { exercise in
                    VStack(alignment: .leading) {
                        Text(exercise.name)
                            .font(.headline)
                        Text("Sets: \(exercise.sets)")
                        Text("Reps: \(exercise.reps.map { "\($0)" }.joined(separator: ", "))")
                        if !exercise.notes.isEmpty {
                            Text("Notes: \(exercise.notes)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
        .navigationTitle(workout.title)
        .onAppear {
            viewModel.getExercisesForWorkout(workoutId: workout.id ?? "")
        }
    }
}




struct WorkoutsView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutsView()
    }
}
