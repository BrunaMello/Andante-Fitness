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
                
                Text("Welcome to Andante Fitness")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .accessibilityAddTraits(.isHeader)
                    .accessibilityLabel("Welcome to Andante Fitness")
                
                Text("Select a user to view workouts")
                    .font(.title3)
                    .foregroundColor(.gray)
                    .accessibilityLabel("Select a user to view workouts")
                
                Spacer()
                
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(userViewModel.users) { user in
                            NavigationLink(destination: {
                                //workout view
                            }) {
                                HStack {
                                    Image(systemName: "person")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(.blue)
                                        .accessibilityHidden(true)
                                    
                                    Text("\(user.name)")
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                        .accessibilityLabel("User: \(user.name)")
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.forward")
                                        .resizable()
                                        .frame(width: 8, height: 8)
                                        .foregroundColor(.black)
                                        .accessibilityHidden(true)
                                    
                                }
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.white.opacity(0.7))
                                        .shadow(
                                            color: Color.black.opacity(0.1),
                                            radius: 5,
                                            x: 0,
                                            y: 2)
                                )
                                .accessibilityElement()
                                .accessibilityLabel("User: \(user.name)")
                                .accessibilityHint("Tap to view workouts for \(user.name)")
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
                
                Spacer()
                
                VStack {
                    Text("Made by Bruna Mello")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .accessibilityLabel("Made by Bruna Mello")
                }
                
            }
            .onAppear {
                userViewModel.loadUsers()
            }
            .padding()
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.white]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
            )
            .navigationTitle("Login")
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    UsersLoginView()
}
