//
//  WorkoutCardView.swift
//  Forgeapp
//
//  Created by Lotte Faber on 26/09/2024.
//

import SwiftUI

struct WorkoutCardView: View {
    let workout: Workout // Assuming you have a Workout model defined
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 10) {
                Text(workout.title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.red)
                
                // Muscle Groups with MusclegroupView for each muscle group
                HStack(spacing: 10) {
                    ForEach(workout.muscleGroup, id: \.self) { muscleGroup in
                        MusclegroupView(text: muscleGroup)
                    }
                }
                
                // Number of exercises
                HStack {
                    Text("Exercises")
                        .font(.caption)
                        .fontWeight(.regular)
                        .foregroundColor(.black)

                    if let exerciseCount = workout.exerciseCount {
                        Text("\(exerciseCount)")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .frame(width: 20, height: 20)
                            .background(Color.white)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.red, lineWidth: 1))
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: .red.opacity(0.2), radius: 5, x: 0, y: 5)
        }
    }
}
