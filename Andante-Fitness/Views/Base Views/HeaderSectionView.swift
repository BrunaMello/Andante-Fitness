//
//  HeaderSectionView.swift
//  Andante-Fitness
//
//  Created by Bruna Bianca Crespo Mello on 06/12/2024.
//
import SwiftUI

public struct HeaderSectionView: View {
    public var body: some View {
        VStack {
            
            Text("Welcome to Andante Fitness")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .accessibilityAddTraits(.isHeader)
                .accessibilityLabel("Welcome to Andante Fitness")
            
            Text("Select a user to view workouts")
                .font(.title3)
                .foregroundColor(.gray)
                .accessibilityLabel("Select a user to view workouts")
            
        }
        
    }
}
