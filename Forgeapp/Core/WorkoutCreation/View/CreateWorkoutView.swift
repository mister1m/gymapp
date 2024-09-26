import SwiftUI

struct CreateWorkoutView: View {
    @StateObject private var viewModel = CreateWorkoutViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    let muscleGroups = ["Chest", "Back", "Legs", "Shoulders", "Arms", "Core"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Workout Details")) {
                    TextField("Workout Title", text: $viewModel.title)
                }
                
                Section(header: Text("Muscle Groups")) {
                    ForEach(muscleGroups, id: \.self) { group in
                        MultipleSelectionRow(title: group, isSelected: viewModel.selectedMuscleGroups.contains(group)) {
                            if viewModel.selectedMuscleGroups.contains(group) {
                                viewModel.selectedMuscleGroups.removeAll { $0 == group }
                            } else {
                                viewModel.selectedMuscleGroups.append(group)
                            }
                        }
                    }
                }
                
                Section {
                    Button(action: {
                        viewModel.uploadWorkout()
                    }) {
                        Text("Create Workout")
                    }
                    .disabled(viewModel.title.isEmpty || viewModel.isLoading)
                }
            }
            .navigationTitle("Create Workout")
            .navigationBarItems(leading: cancelButton)
            .alert(isPresented: $viewModel.isWorkoutCreated) {
                Alert(title: Text("Success"),
                      message: Text("Workout created successfully!"),
                      dismissButton: .default(Text("OK")) {
                          presentationMode.wrappedValue.dismiss()
                      })
            }
            .overlay(
                Group {
                    if viewModel.isLoading {
                        ProgressView("Creating workout...")
                            .padding()
                            .background(Color.secondary.colorInvert())
                            .cornerRadius(10)
                            .shadow(radius: 10)
                    }
                }
            )
            .alert(item: Binding<ErrorWrapper?>(
                get: { viewModel.errorMessage.map { ErrorWrapper($0) } },
                set: { viewModel.errorMessage = $0?.error }
            )) { wrapper in
                Alert(title: Text("Error"), message: Text(wrapper.error), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    private var cancelButton: some View {
        Button("Cancel") {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

struct MultipleSelectionRow: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: self.action) {
            HStack {
                Text(self.title)
                if self.isSelected {
                    Spacer()
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}

struct ErrorWrapper: Identifiable {
    let id = UUID()
    let error: String
    
    init(_ error: String) {
        self.error = error
    }
}

struct CreateWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        CreateWorkoutView()
    }
}
