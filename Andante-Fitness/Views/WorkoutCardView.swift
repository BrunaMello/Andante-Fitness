    //
    //  WorkoutCardView.swift
    //  Andante-Fitness
    //
    //  Created by Bruna Bianca Crespo Mello on 04/12/2024.
    //
import SwiftUI

struct WorkoutCardView: View {
    let workout: Workout
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "flame.fill")
                    .foregroundColor(.orange)
                Text(workout.name)
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Text("\(workout.date!, style: .date)")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            
            Divider()
            
            HStack {
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    HStack {
                        Image(systemName: "flame")
                            .foregroundColor(.red)
                        Text("\(workout.calories_burned) cal")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                    }
                    
                    
                    HStack {
                        Image(systemName: "figure.walk")
                            .foregroundColor(.green)
                        Text("\(workout.stepsPerMinute ?? 0) spm")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                    }
                    
                    
                    
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    HStack {
                        Image(systemName: "clock")
                            .foregroundColor(.blue)
                        Text("\(workout.duration) mins")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                    }
                    
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text("\(workout.difficulty)")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                    }
                }
            }
                    
            
            Text("\(workout.benefits)")
                .font(.footnote)
                .italic()
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
            
            
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white.opacity(0.9))
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        )
    }
}

