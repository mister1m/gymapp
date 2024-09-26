import SwiftUI

struct WorkoutsView: View {
    @State private var showCreateWorkout = false
    
    var body: some View {
        NavigationView {
            Button("Create Workout") {
                showCreateWorkout = true
            }
            .sheet(isPresented: $showCreateWorkout) {
                CreateWorkoutView()
            }
        }
    }
}

struct WorkoutsView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutsView()
    }
}
