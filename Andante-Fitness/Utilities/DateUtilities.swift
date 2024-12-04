//
//  DateUtilities.swift
//  Andante-Fitness
//
//  Created by Bruna Bianca Crespo Mello on 03/12/2024.
//
import Foundation

public class DateUtilities {
    
    
    public static func generateRandomDate() -> Date {
        let calendar = Calendar.current
        let today = Date()
        
        guard let randomDate = calendar.date(
            byAdding: .day,
            value: Int.random(in: -30...0),
            to: today
        ) else {
            return today
        }
        return randomDate
    }
    
    // Helper function to safely format optional dates
    private func formatDate(_ date: String?) -> String {
        guard let date = date else { return "Invalid Date" }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        if let parsedDate = formatter.date(from: date) {
            formatter.dateFormat = "dd/MM/yyyy"
            return formatter.string(from: parsedDate)
        }
        
        return "Invalid Date"
    }
    
    
}
