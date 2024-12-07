//
//  AddWorkoutDifficultySectionView.swift
//  Andante-Fitness
//
//  Created by Bruna Bianca Crespo Mello on 07/12/2024.
//
import SwiftUI

public struct AddWorkoutDifficultySectionView: View {
    
    @Binding var difficulty: String
    
    let difficulties = ["Easy", "Medium", "Hard"]
    
    
    public var body: some View {
        Section(header: Text("Dificulty Level")) {
            Picker("Difficult Level", selection: $difficulty) {
                ForEach(difficulties, id: \.self) { level in
                    Text(level).tag(String(level))
                }
            }
        }
    }
}
