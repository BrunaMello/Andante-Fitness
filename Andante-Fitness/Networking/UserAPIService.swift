//
//  UserAPIService.swift
//  Andante-Fitness
//
//  Created by Bruna Bianca Crespo Mello on 03/12/2024.
//
import Foundation
import Combine

class UserAPIService {
    
    static let shared = UserAPIService()
    
    func fetchUsers() -> AnyPublisher<[User], Error> {
        
        let url = URL(string: "https://tinyurl.com/yzs5dc7k/users.json")!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [User].self,decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
    }
    
}
