//
//  FooterSectionView.swift
//  Andante-Fitness
//
//  Created by Bruna Bianca Crespo Mello on 06/12/2024.
//
import SwiftUI

public struct FooterSectionView: View {
    public var body: some View {
        VStack {
            Text("Made by Bruna Mello")
                .font(.footnote)
                .foregroundColor(.gray)
                .accessibilityLabel("Made by Bruna Mello")
        }
    }
}
