    //
    //  WorkoutViewModel.swift
    //  Andante-Fitness
    //
    //  Created by Bruna Bianca Crespo Mello on 03/12/2024.
    //
import Foundation
import Combine
import os


class WorkoutViewModel: ObservableObject {
    
    //Logger
    private let logger = Logger(subsystem: "com.andantefitness.app", category: "WorkoutViewModel")
    
    @Published var apiWorkouts: [Workout] = [] // Workouts from API
    @Published var localWorkouts: [Workout] = [] // Locals workouts
    @Published var mergedWorkouts: [Workout] = [] // Workouts merged
    @Published var filteredWorkoutsByUserId: [Workout] = [] // Filtered Results
    @Published var filteredWorkoutsByUserIdBase: [Workout] = [] // Base to use the filter
    
    private let workoutsKey = "savedWorkouts"
    private var cancellables: Set<AnyCancellable> = []
    
        // Filter by workout type
    @Published var workoutTypes: [String] = []
    var selectedWorkoutType: String? = nil
    
    @Published var minDuration: Int? = nil
    
    func saveWorkouts() {
        do {
            let encodedData = try JSONEncoder().encode(localWorkouts)
            UserDefaults.standard.set(encodedData, forKey: workoutsKey)
            logger.info("Successfully saved local workouts.")
        } catch {
            logger.error("Error on saveWorkouts: \(error.localizedDescription)")
        }
    }
    
    func loadWorkoutsFromStorage() {
        guard let data = UserDefaults.standard.data(forKey: workoutsKey) else {
            return
        }
        
        do {
            let decodedWorkouts = try JSONDecoder().decode([Workout].self, from: data)
            self.localWorkouts = decodedWorkouts
            mergeWorkouts()
            logger.info("Successfully loaded workouts from stored data.")
        } catch {
            logger.error("Error on loadWorkouts: \(error.localizedDescription)")
        }
    }
    
    func addWorkout(_ workout: Workout) {
        localWorkouts.append(workout)
        saveWorkouts()
        mergeWorkouts()
    }
    
        // MARK: - API and Merge Logic
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
            .sink(
receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    self.logger
                        .error(
                            "Error on loadWorkouts from API: \(error.localizedDescription)"
                        )
                }
            },
 receiveValue: { [weak self] updatedWorkouts in
                self?.apiWorkouts = updatedWorkouts
                self?.mergeWorkouts()
                self?.workoutTypes = Array(Set(updatedWorkouts.map { $0.name })).sorted()
                self?.logger.info("Successfully loaded workouts from API.")
            })
            .store(in: &cancellables)
    }
    
    func mergeWorkouts() {
        mergedWorkouts = (apiWorkouts + localWorkouts).sorted {
            ($0.date ?? Date()) > ($1.date ?? Date()) 
        }
    }
    
        // MARK: - Filters and Sorting
    func filterWorkoutsByUserId(for userId: Int) {
        filteredWorkoutsByUserIdBase = mergedWorkouts.filter { $0.user_id == userId }
        applyFilters()
    }
    
    func filterWorkoutsByType(selectedType: String?) {
        selectedWorkoutType = selectedType
        applyFilters()
    }
    
    func filterWorkoutsByMinDuration(minDuration: Int?) {
        self.minDuration = minDuration
        applyFilters()
    }
    
    func applyFilters() {
        filteredWorkoutsByUserId = filteredWorkoutsByUserIdBase.filter { workout in
            let matchesType = selectedWorkoutType == nil || selectedWorkoutType == workout.name
            let matchesMinDuration = (minDuration != nil && workout.duration >= minDuration!) || minDuration == nil
            return matchesType && matchesMinDuration
        }
    }
    
        // MARK: - Sorting
    func sortFilteredWorkouts<T: Comparable>(by keyPath: KeyPath<Workout, T>, ascending: Bool = true) {
        filteredWorkoutsByUserId = filteredWorkoutsByUserId.sorted {
            let first = $0[keyPath: keyPath]
            let second = $1[keyPath: keyPath]
            return ascending ? first < second : first > second
        }
    }
    
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
