//
//  Extensions.swift
//  lease_mileage_calculator
//
//  Created by Arthur Efremenko on 5/9/25.
//

import Foundation

extension Calendar {
    /**
     Get number of day since the given date.
     If the number of days cannot be calculated, returns 0.
     */
    func numberOfDaysSince(_ from: Date) -> Int {
        let fromDate = startOfDay(for: from)
        let toDate = startOfDay(for: Date())
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate)
        
        return numberOfDays.day ?? 0
    }
}

func stringToDate(_ input: String) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.date(from: input)
}

func dateToString(_ input: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.string(from: input)
}
