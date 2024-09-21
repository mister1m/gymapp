import SwiftUI

struct WorkoutsView: View {
    @State private var showMyRoutines = true
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Buttons
                HStack(spacing: 15) {
                    Button("Create Routine") {
                        // Action for Create Routine
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Button("Explore") {
                        // Action for Explore
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding(.horizontal)
                
                // My Routines Section
                VStack {
                    Button(action: {
                        withAnimation {
                            showMyRoutines.toggle()
                        }
                    }) {
                        HStack {
                            Text("My Routines")
                                .font(.headline)
                            Spacer()
                            Image(systemName: showMyRoutines ? "chevron.up" : "chevron.down")
                        }
                    }
                    .padding(.horizontal)
                    
                    if showMyRoutines {
                        WorkoutCard(title: "Full body workout", type: "Strength", exerciseCount: 8)
                    }
                }
                
                Spacer()
            }
            .navigationTitle("Workouts")
        }
    }
}

struct WorkoutCard: View {
    let title: String
    let type: String
    let exerciseCount: Int
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.headline)
                Text(type)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text("\(exerciseCount) exercises")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            VStack(spacing: 10) {
                Button("Start") {
                    // Start workout action
                }
                .buttonStyle(.borderedProminent)
                
                Button("Edit") {
                    // Edit workout action
                }
                .buttonStyle(.bordered)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 2)
        .padding(.horizontal)
    }
}

struct WorkoutsView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutsView()
    }
}
