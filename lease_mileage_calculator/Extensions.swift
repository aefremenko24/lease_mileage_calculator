//
//  Extensions.swift
//  lease_mileage_calculator
//
//  Created by Arthur Efremenko on 5/9/25.
//

import Foundation

/**
 Get number of day since the given date.
 */
extension Calendar {
    func numberOfDaysSince(_ from: Date) -> Int {
        let fromDate = startOfDay(for: from)
        let toDate = startOfDay(for: Date())
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate)
        
        return numberOfDays.day!
    }
}
