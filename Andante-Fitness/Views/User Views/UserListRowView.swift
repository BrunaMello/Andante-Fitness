//
//  UserListRowView.swift
//  Andante-Fitness
//
//  Created by Bruna Bianca Crespo Mello on 06/12/2024.
//
import SwiftUI

struct UserRowView: View {
    let user: User
    
    var body: some View {
        HStack {
            Image(systemName: "person")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(.blue)
                .accessibilityHidden(true)
            
            Text(user.name)
                .font(.headline)
                .foregroundColor(.primary)
                .accessibilityLabel("User: \(user.name)")
            
            Spacer()
            
            Image(systemName: "chevron.forward")
                .resizable()
                .frame(width: 8, height: 8)
                .foregroundColor(.black)
                .accessibilityHidden(true)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white.opacity(0.7))
                .shadow(
                    color: Color.black.opacity(0.1),
                    radius: 5,
                    x: 0,
                    y: 2
                )
        )
        .accessibilityElement()
        .accessibilityLabel("User: \(user.name)")
        .accessibilityHint("Tap to view workouts for \(user.name)")
    }
}
