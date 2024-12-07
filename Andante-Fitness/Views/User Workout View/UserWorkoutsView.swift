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
    let userName: String
    
    @State private var showAddWorkoutView = false
    
    @State private var sortOption: SortOption = .date
    
    
    enum SortOption: String, CaseIterable {
        case date = "Date"
        case duration = "Duration"
        case stepsPerMinute = "Cadence"
    }
    
        // Filter by Workout Type
    @State private var selectedWorkoutType: String? = nil
    
        // Filter by Min Duration
    @State private var minDuration: String = ""
    
    
    
    var body: some View {
        NavigationView {
            ZStack {
                
                backgroundGradient()
                    .ignoresSafeArea()
                
                VStack {
                    Text("Workouts")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top)
                    
                    Text("View and filter your exercises")
                        .font(.title3)
                        .foregroundColor(.gray)
                    
                    Spacer(minLength: 20)
                    
                    HStack {
                        
                        Picker("Workout Type", selection: $selectedWorkoutType) {
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
                        
                        Spacer(minLength: 90)
                        
                        
                        TextField("Min Duration (mins)", text: $minDuration)
                            .keyboardType(.numberPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.leading)
                            .onChange(of: minDuration) { newValue in
                                withAnimation {
                                    if let duration = Int(newValue), duration > 0 {
                                        workoutViewModel.filterWorkoutsByMinDuration(minDuration: duration)
                                    } else {
                                        workoutViewModel.filterWorkoutsByMinDuration(minDuration: nil)
                                    }
                                }
                            }
                    }
                    .padding()
                    
                    Picker("Sort by", selection: $sortOption) {
                        ForEach(SortOption.allCases, id: \.self) { option in
                            Text(option.rawValue).tag(option)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                    
                    
                    Spacer()
                    
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(
                                workoutViewModel.filteredWorkoutsByUserId
                            ) { workout in
                                WorkoutCardView(workout: workout)
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    Spacer()
                    
                    FooterSectionView()
                    
                }
                .onTapGesture {
                    hideKeyboard()
                }
                .onAppear {
                    workoutViewModel.loadWorkoutsFromStorage()
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
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(
            trailing: Button(action: {
                showAddWorkoutView = true
            }) {
                Image(systemName: "plus")
                    .font(.subheadline)
            }
        )
        .background(
            NavigationLink(
                destination: AddWorkoutView(workoutViewModel: workoutViewModel,
                    userId: userId, userName: userName),
                isActive: $showAddWorkoutView,
                label: { EmptyView() })
        )
    }
}
