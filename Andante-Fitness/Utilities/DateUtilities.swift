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
            print("Today date: \(today)")
            return today
        }
        print(randomDate)
        return randomDate
    }
    
    
}
