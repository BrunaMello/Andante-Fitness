//
//  Workout.swift
//  Andante-Fitness
//
//  Created by Bruna Bianca Crespo Mello on 03/12/2024.
//
import Foundation

struct Workout: Identifiable, Decodable {
    let id: Int
    let user_id: Int
    let name: String
    let duration: Int
    let calories_burned: Int
    let difficulty: String
    let benefits: String
    
    //Mock Data
    var date: Date?
    var stepsPerMinute: Int?
    
    
    

}
