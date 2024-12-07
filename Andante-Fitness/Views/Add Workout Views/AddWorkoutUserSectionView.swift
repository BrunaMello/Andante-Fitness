//
//  AddWorkoutUserSectionView.swift
//  Andante-Fitness
//
//  Created by Bruna Bianca Crespo Mello on 07/12/2024.
//
import SwiftUI

public struct AddWorkoutUserSectionView: View {
    let userName: String
    
    public var body: some View {
        Section(header: Text("User")) {
            Text("\(userName)")
                .font(.headline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
        }
    }
}
