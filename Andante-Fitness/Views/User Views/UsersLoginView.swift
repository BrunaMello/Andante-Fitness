    //
    //  UsersLoginView.swift
    //  Andante-Fitness
    //
    //  Created by Bruna Bianca Crespo Mello on 03/12/2024.
    //
import SwiftUI

struct UsersLoginView: View {
    
    @StateObject private var userViewModel = UserViewModel()
    @State private var selectedUserId: Int?
    
    
    var body: some View {
        NavigationView {
            VStack {
                HeaderSectionView()
                
                UserListView(userViewModel: userViewModel)
                
                FooterSectionView()
                
            }
            .onAppear {
                userViewModel.loadUsers()
            }
            .padding()
            .background(backgroundGradient().ignoresSafeArea())
            .navigationTitle("Login")
            .navigationBarHidden(true)
        }
    }
}
