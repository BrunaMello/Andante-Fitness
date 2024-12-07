//
//  AddWorkoutDetailsView.swift
//  Andante-Fitness
//
//  Created by Bruna Bianca Crespo Mello on 07/12/2024.
//
import SwiftUI

struct AddWorkoutDetailsSectionView: View {
    @Binding var duration: String
    @Binding var caloriesBurned: String
    @Binding var stepsPerMinute: String
    @Binding var benefits: String
    @Binding var fieldErrors: [String: Bool]
    
    var body: some View {
        Section(header: Text("Workout Details")) {
            TextField("Duration (mins)", text: $duration)
                .keyboardType(.numberPad)
                .validationBorder(isError: fieldErrors["duration"] == true)
                .onChange(of: duration) { newValue in
                    fieldErrors["duration"] = newValue.isEmpty
                }
            
            TextField("Calories Burned", text: $caloriesBurned)
                .keyboardType(.numberPad)
                .validationBorder(isError: fieldErrors["calories_burned"] == true)
                .onChange(of: caloriesBurned) { newValue in
                    fieldErrors["calories_burned"] = newValue.isEmpty
                }
            
            TextField("Steps Per Minute", text: $stepsPerMinute)
                .keyboardType(.numberPad)
                .validationBorder(isError: fieldErrors["stepsPerMinute"] == true)
                .onChange(of: stepsPerMinute) { newValue in
                    fieldErrors["stepsPerMinute"] = newValue.isEmpty
                }
            
            TextField("Benefits (optional)", text: $benefits)
        }
    }
}
