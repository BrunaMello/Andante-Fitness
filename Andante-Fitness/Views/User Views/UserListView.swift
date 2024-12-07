//
//  UserListView.swift
//  Andante-Fitness
//
//  Created by Bruna Bianca Crespo Mello on 06/12/2024.
//

import SwiftUI

struct UserListView: View {
    @ObservedObject var userViewModel: UserViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(userViewModel.users) { user in
                    NavigationLink(destination: {
                        UserWorkoutsView(userId: user.id, userName: user.name)
                    }) {
                        UserRowView(user: user)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(.horizontal, 20)
        }
        .padding(.vertical, 20)
        .background(Color.white.opacity(0))
        .cornerRadius(20)
        .padding(.horizontal, 16)
    }
}
