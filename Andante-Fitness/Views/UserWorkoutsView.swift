//
//  UserWorkoutsView.swift
//  Andante-Fitness
//
//  Created by Bruna Bianca Crespo Mello on 03/12/2024.
//
import SwiftUI

struct UserWorkoutsView: View {
    
    @StateObject private var workoutViewModel = WorkoutViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("User Workouts")
                
                ScrollView {
                    LazyVStack(spacing:16) {
                        ForEach(workoutViewModel.workouts) { workout in
                            
                            Text("Workout ID: \(workout.id)")
                            Text("Workout User id: \(workout.user_id)")
                            Text("Workout Name: \(workout.name)")
                            Text("Workout Calories Burned: \(workout.calories_burned)")
                            Text("Workout Difficulty: \(workout.difficulty)")
                            Text("Workout Benefits: \(workout.benefits)")
                      
                        }
                    }
                }
            }
            .onAppear {
                workoutViewModel.loadWorkouts()
            }
        }
       
    }
}

#Preview {
    UserWorkoutsView()
}
