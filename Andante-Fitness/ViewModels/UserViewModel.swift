//
//  UserViewModel.swift
//  Andante-Fitness
//
//  Created by Bruna Bianca Crespo Mello on 03/12/2024.
//
import Foundation
import Combine

class UserViewModel: ObservableObject {
    
    @Published var users: [User] = []
    @Published var selectedUser: User?
    
    private var cancellables: Set<AnyCancellable> = []
    
    
    // Function to load the users
    func loadUsers() {
        UserAPIService.shared.fetchUsers()
            .sink(receiveCompletion: { print($0)}, receiveValue: { self.users = $0 })
            .store(in: &cancellables)
    }
    
}
