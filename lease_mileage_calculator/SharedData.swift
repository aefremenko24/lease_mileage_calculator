//
//  SharedData.swift
//  lease_mileage_calculator
//
//  Created by Arthur Efremenko on 6/29/25.
//

import Foundation

class SharedData {
    static let defaultsGroup: UserDefaults? = UserDefaults(suiteName: "group.lease-mileage-calculator.container")
    
    enum Keys: String {
        case purchaseDate = "purchaseDate"
        case milesPerYear = "milesPerYear"
        
        var key: String {
            switch self {
                default: self.rawValue
            }
        }
    }
    
    static var purchaseDate: String {
        get {
            defaultsGroup?.string(forKey: Keys.purchaseDate.key) ?? ""
        } set {
            defaultsGroup?.set(newValue, forKey: Keys.purchaseDate.key)
        }
    }
    
    static var milesPerYear: String {
        get {
            defaultsGroup?.string(forKey: Keys.milesPerYear.key) ?? ""
        } set {
            defaultsGroup?.set(newValue, forKey: Keys.milesPerYear.key)
        }
    }
}
