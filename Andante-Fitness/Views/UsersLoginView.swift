//
//  UsersLoginView.swift
//  Andante-Fitness
//
//  Created by Bruna Bianca Crespo Mello on 03/12/2024.
//
import SwiftUI

struct UsersLoginView: View {
    
    @StateObject private var userViewModel = UserViewModel()
    
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Text("Login")
                
                Spacer()
                
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(userViewModel.users) { user in
                            HStack {
                                Text("User Name: \(user.name)")
                                
                                Text("User Email: \(user.email)")
                            }
                        }
                    }
                }
        
            }
            
        }
        .onAppear {
            userViewModel.loadUsers()
        }
    }
}

#Preview {
    UsersLoginView()
}
