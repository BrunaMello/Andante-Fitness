//
//  AddWorkoutTypeSectionView.swift
//  Andante-Fitness
//
//  Created by Bruna Bianca Crespo Mello on 07/12/2024.
//
import SwiftUI

public struct AddWorkoutTypeSectionView: View {
    
    @Binding var selectedWorkoutType: String
    @Binding var fieldErrors: [String: Bool]
    var workoutTypes: [String]
    
    private var isWorkoutTypeInvalid: Bool {
        selectedWorkoutType == "Select"
    }

    
    public var body: some View {
        Section(header: Text("Workout Type")) {
            Picker("Workout Type", selection: $selectedWorkoutType) {
                Text("Select").tag("Select")
                ForEach(workoutTypes, id: \.self) { type in
                    Text(type).tag(String(type))
                }
            }
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(fieldErrors["workoutType"] == true ? Color.red : Color.clear, lineWidth: 1)
            )
            .onChange(of: selectedWorkoutType) { newValue in
                fieldErrors["workoutType"] = isWorkoutTypeInvalid
            }
        }
    }
}
