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
    
    private var cancellables: Set<AnyCancellable> = []
    
    func loadWorkouts() {
        WorkoutAPIService.shared.fetchWorkouts()
            .sink(
                receiveCompletion: { print($0)
                },
                receiveValue: { self.workouts = $0 })
            .store(in: &cancellables)
    }
    
    
}
