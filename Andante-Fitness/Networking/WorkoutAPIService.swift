//
//  WorkoutAPIService.swift
//  Andante-Fitness
//
//  Created by Bruna Bianca Crespo Mello on 03/12/2024.
//
import Foundation
import Combine

struct WorkoutAPIService {
    
    static let shared = WorkoutAPIService()
    
    func fetchWorkouts() -> AnyPublisher<[Workout], Error> {
         
        let url = URL(string: "https://tinyurl.com/yzs5dc7k/workouts.json")!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Workout].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
    }
        
}
