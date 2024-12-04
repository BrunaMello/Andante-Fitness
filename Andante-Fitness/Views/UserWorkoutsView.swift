//
//  UserWorkoutsView.swift
//  Andante-Fitness
//
//  Created by Bruna Bianca Crespo Mello on 03/12/2024.
//
import SwiftUI

struct UserWorkoutsView: View {
    
    @StateObject private var workoutViewModel = WorkoutViewModel()
    let userId: Int
    
    @State private var sortOption: SortOption = .date
    
    
    enum SortOption: String, CaseIterable {
        case date = "Date"
        case duration = "Duration"
        case stepsPerMinute = "Cadence"
    }
    
    // Filter by Workout Type
    @State private var selectedWorkoutType: String? = nil
    
    
    
    var body: some View {
        NavigationView {
            VStack {
                
                Picker("Select Workout Type", selection: $selectedWorkoutType) {
                    Text("All").tag(String?.none) // Opção para todos os tipos
                    ForEach(workoutViewModel.workoutTypes, id: \.self) { type in
                        Text(type).tag(String?(type))
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .padding()
                .onChange(of: selectedWorkoutType) { newValue in
                    workoutViewModel.filterWorkoutsByType(selectedType: newValue)
                }
                
                
                
                Picker("Sort by", selection: $sortOption) {
                    ForEach(SortOption.allCases, id: \.self) { option in
                        Text(option.rawValue).tag(option)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                Spacer()
                
                ScrollView {
                    LazyVStack(spacing:16) {
                        ForEach(
                            workoutViewModel.filteredWorkoutsByUserId
                        ) { workout in
                            Text("Workout User: \(workout.user_id)")
                            Text("Workout type: \(workout.name)")
                            Text("Workout duration: \(workout.duration) Minutes")
                            Text("Workout Date: \(workout.date!, style: .date)")
                            Text("Steps: \(workout.stepsPerMinute ?? 0)")
                            
                        }
                    }
                }
            }
            .onAppear {
                workoutViewModel.loadWorkouts()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    workoutViewModel.filterWorkoutsByUserId(for: userId)
                    
                }
            }
            .onChange(of: sortOption) { newValue in
                switch newValue {
                    case .date:
                        workoutViewModel.sortFilteredWorkouts(by: \.date, ascending: true)
                    case .stepsPerMinute:
                        workoutViewModel.sortFilteredWorkouts(by: \.stepsPerMinute, ascending: true)
                    case .duration:
                        workoutViewModel.sortFilteredWorkouts(by: \.duration, ascending: true)
                }
            }
        }
        
    }

    
}

#Preview {
    UserWorkoutsView(userId: 2)
}
