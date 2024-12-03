//
//  User.swift
//  Andante-Fitness
//
//  Created by Bruna Bianca Crespo Mello on 03/12/2024.
//
import Foundation

struct User: Identifiable, Decodable {
    let id: Int
    let name: String
    let email: String
    
}
