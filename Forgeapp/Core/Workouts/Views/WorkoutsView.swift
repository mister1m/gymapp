import SwiftUI
import FirebaseAuth


struct WorkoutsView: View {
    @StateObject private var workoutService = WorkoutService()
    @State private var workouts: [Workout] = []
    @State private var errorMessage: String? // Define the errorMessage state
    @State private var selectedWorkout: Workout? = nil // State to track selected workout
    
    var body: some View {
        NavigationStack {
            VStack {
                // Conditionally display error message if it exists
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
                
                List(workouts) { workout in
                    WorkoutCardView(workout: workout)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.clear)
                        .onTapGesture {
                            selectedWorkout = workout
                        }
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
                }
                .listStyle(PlainListStyle())
                .navigationTitle("Your Workouts")
                .onAppear {
                    fetchWorkouts()
                }
            }
            .navigationDestination(isPresented: Binding<Bool>(
                get: { selectedWorkout != nil },
                set: { if !$0 { selectedWorkout = nil } }
            )) {
                if let selectedWorkout = selectedWorkout {
                    WorkoutDetailView(workout: selectedWorkout)
                }
            }
        }
    }
    
    // Function to fetch workouts using the current user's UID
    func fetchWorkouts() {
        workoutService.getWorkoutsForUser { (workouts, error) in
            if let error = error {
                // Assign error message if there's an error
                self.errorMessage = "Error fetching workouts: \(error.localizedDescription)"
            } else if let workouts = workouts {
                // Assign the workouts if fetched successfully
                self.workouts = workouts
                // Clear any previous error message
                self.errorMessage = nil
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
