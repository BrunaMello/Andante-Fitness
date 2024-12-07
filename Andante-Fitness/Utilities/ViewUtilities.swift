//
//  ViewUtilities.swift
//  Andante-Fitness
//
//  Created by Bruna Bianca Crespo Mello on 05/12/2024.
//
import SwiftUI

struct FieldValidationModifier: ViewModifier {
    var isError: Bool
    
    func body(content: Content) -> some View {
        content
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(isError ? Color.red : Color.clear, lineWidth: 1)
            )
    }
}

func backgroundGradient() -> LinearGradient {
    return LinearGradient(
        colors: [Color.blue.opacity(0.2), Color.white],
        startPoint: .top,
        endPoint: .bottom
    )
}

extension View {
    func hideKeyboard() {
        UIApplication.shared
            .sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func validationBorder(isError: Bool) -> some View {
        self.modifier(FieldValidationModifier(isError: isError))
    }
    
}
