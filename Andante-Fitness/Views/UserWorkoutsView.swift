//
//  UserWorkoutsView.swift
//  Andante-Fitness
//
//  Created by Bruna Bianca Crespo Mello on 03/12/2024.
//
import SwiftUI

struct UserWorkoutsView: View {
    
    @StateObject private var workoutViewModel = WorkoutViewModel()
    let userId: Int
    
    var body: some View {
        NavigationView {
            VStack {
                
                ScrollView {
                    LazyVStack(spacing:16) {
                        ForEach(
                            workoutViewModel.filteredWorkoutsByUserId
                        ) { workout in
                            
                            Text("Workout duration: \(workout.duration) Minutes")
                            Text("Workout Date: \(workout.date)")
                            Text("Workout Steps Per Minute:\(workout.stepsPerMinute)")
                      
                        }
                    }
                }
            }
            .onAppear {
                workoutViewModel.loadWorkouts()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    workoutViewModel.filterWorkoutsByUserId(for: userId)
                }
            }
        }
       
    }
}

#Preview {
    UserWorkoutsView(userId: 2)
}
