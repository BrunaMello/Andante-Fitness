//
//  WorkoutViewModel.swift
//  Andante-Fitness
//
//  Created by Bruna Bianca Crespo Mello on 03/12/2024.
//
import Foundation
import Combine

class WorkoutViewModel: ObservableObject {
    
    @Published var workouts: [Workout] = []
    @Published var filteredWorkoutsByUserId: [Workout] = []
    
    private var cancellables: Set<AnyCancellable> = []
    
    func loadWorkouts() {
        WorkoutAPIService.shared.fetchWorkouts()
            .map { workouts in
                workouts.map { workout in
                    var updatedWorkout = workout
                    updatedWorkout.date = DateUtilities.generateRandomDate()
                    updatedWorkout.stepsPerMinute = Int.random(in: 1...150)
                    return updatedWorkout
                }
            }
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error loading workouts: \(error)")
                }
            }, receiveValue: { [weak self] updatedWorkouts in
                self?.workouts = updatedWorkouts
                print("Workouts loaded with additional data: \(updatedWorkouts)")
            })
            .store(in: &cancellables)
    }
    
    func filterWorkoutsByUserId(for userId: Int) {
        filteredWorkoutsByUserId = workouts.filter { $0.user_id == userId }
    }
    
    // Not Optionals
    func sortFilteredWorkouts<T: Comparable>(by keyPath: KeyPath<Workout, T>, ascending: Bool = true) {
        filteredWorkoutsByUserId = filteredWorkoutsByUserId.sorted {
            let first = $0[keyPath: keyPath]
            let second = $1[keyPath: keyPath]
            
            return ascending ? first < second : first > second
        }
    }
    
    // Optionals
    func sortFilteredWorkouts<T: Comparable>(by keyPath: KeyPath<Workout, T?>, ascending: Bool = true) {
        filteredWorkoutsByUserId = filteredWorkoutsByUserId.sorted {
            let first = $0[keyPath: keyPath]
            let second = $1[keyPath: keyPath]
            
            switch (first, second) {
                case let (first?, second?):
                    return ascending ? first < second : first > second
                case (nil, _):
                    return !ascending
                case (_, nil):
                    return ascending
            }
        }
    }
    
}
