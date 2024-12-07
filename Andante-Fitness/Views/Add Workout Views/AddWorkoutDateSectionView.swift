//
//  AddWorkoutDateSectionView.swift
//  Andante-Fitness
//
//  Created by Bruna Bianca Crespo Mello on 07/12/2024.
//
import SwiftUI

public struct AddWorkoutDateSectionView: View {
    @Binding var date: Date
    
    public var body: some View {
        Section(header: Text("Date")) {
            DatePicker("Workout Date", selection: $date, displayedComponents: [.date])
                .datePickerStyle(GraphicalDatePickerStyle())
        }
    }
}
