    //
    //  AddWorkoutView.swift
    //  Andante-Fitness
    //
    //  Created by Bruna Bianca Crespo Mello on 05/12/2024.
    //

import SwiftUI

struct AddWorkoutView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var workoutViewModel: WorkoutViewModel
    
    let userId: Int
    let userName: String
    
    @State private var duration: String = ""
    @State private var calories_burned: String = ""
    @State private var difficulty: String = "Easy"
    @State private var benefits: String = ""
    @State private var stepsPerMinute: String = ""
    @State private var selectedWorkoutType: String = "Select"
    @State private var date = Date()
    
        //Error message
    @State private var errorMessage: String?
    @State private var fieldErrors: [String: Bool] = [:]
    
        //Workout type validate
    var isWorkoutTypeInvalid: Bool {
        selectedWorkoutType == "Select"
    }
        
    
    var body: some View {
        NavigationView {
            Form {
                AddWorkoutUserSectionView(userName: userName)
              
                AddWorkoutTypeSectionView(
                    selectedWorkoutType: $selectedWorkoutType,
                    fieldErrors: $fieldErrors,
                    workoutTypes: workoutViewModel.workoutTypes
                )
                
                AddWorkoutDifficultySectionView(difficulty: $difficulty)
                
                AddWorkoutDetailsSectionView(duration: $duration,
                                      caloriesBurned: $calories_burned,
                                      stepsPerMinute: $stepsPerMinute,
                                      benefits: $benefits,
                                      fieldErrors: $fieldErrors)
                
                if let errorMessage = errorMessage {
                    Section {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                }
            }
        }
        .onAppear {
            workoutViewModel.loadWorkouts()
            workoutViewModel.loadWorkoutsFromStorage()
        }
        .navigationTitle("Add Workout")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    saveWorkout()
                }
            }
        }
    }
    func saveWorkout() {
            // Validate inputs
        guard !duration.isEmpty, !calories_burned.isEmpty, !stepsPerMinute.isEmpty, selectedWorkoutType != "Select" else {
            errorMessage = "Please fill in all required fields."
            return
        }
        
            // Convert String to Int
        guard let durationInt = Int(duration),
              let caloriesBurnedInt = Int(calories_burned),
              let stepsPerMinuteInt = Int(stepsPerMinute) else {
            errorMessage = "Please enter valid numeric values for duration, calories burned, and steps per minute."
            return
        }
        
        let newWorkout = Workout(
            id: Int(Date().timeIntervalSince1970),
            user_id: userId,
            name: selectedWorkoutType,
            duration: durationInt,
            calories_burned: caloriesBurnedInt,
            difficulty: difficulty,
            benefits: benefits,
            date: date,
            stepsPerMinute: stepsPerMinuteInt
            
        )
        
        workoutViewModel.addWorkout(newWorkout)
        
        errorMessage = nil
        dismiss()
    }
    
}
