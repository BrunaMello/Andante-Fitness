//
//  UserViewModel.swift
//  Andante-Fitness
//
//  Created by Bruna Bianca Crespo Mello on 03/12/2024.
//
import Foundation
import Combine
import os

class UserViewModel: ObservableObject {
    
    //Logger
    private let logger = Logger(subsystem: "com.andantefitness.app", category: "UserViewModel")
    
    @Published var users: [User] = []
    @Published var selectedUser: User?
    
    private var cancellables: Set<AnyCancellable> = []
    
    
    // Function to load the users
    func loadUsers() {
        UserAPIService.shared.fetchUsers()
            .sink(
                receiveCompletion: { [weak self] completion in
                    switch completion {
                        case .finished:
                            self?.logger.info("Successfully loaded users.")
                        case .failure(let error):
                            self?.logger.error("Failed to load users: \(error.localizedDescription)")
                    }
                },
                receiveValue: { [weak self] users in
                    self?.users = users
                }
            )
            .store(in: &cancellables)
    }
    
    // Function to select a user
    func selectUser(user: User) {
        selectedUser = user
    }
    
}
