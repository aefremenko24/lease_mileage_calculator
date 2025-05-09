//
//  ContentView.swift
//  lease_mileage_calculator
//
//  Created by Arthur Efremenko on 5/9/25.
//

import SwiftUI

struct ContentView: View {
    @State var purchaseDate: Date = Date()
    @State var milesPerYear: String = ""
    
    @AppStorage("purchase_date") var purchaseDateStorage: Date?
    @AppStorage("miles_per_year") var milesPerYearStorage: String?
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            DatePicker("Car purchase date",
                       selection: $purchaseDate,
                       in: ...Date(),
                       displayedComponents: [.date])
                .onSubmit {
                    purchaseDateStorage = purchaseDate
                }
            
            HStack {
                Text("# of miles per year")
                Spacer()
                TextField("", text: $milesPerYear)
                    .keyboardType(.numberPad)
                    .onSubmit {
                        milesPerYear = milesPerYear.filter { "0123456789".contains($0) }
                        milesPerYearStorage = milesPerYear
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 120)
            }
            
            Spacer()
            
            Text("You should be at or under")
            Text("\(getSuggestedMiles())")
                .font(.largeTitle)
                .fontWeight(.bold)
            Text("miles")
                .padding(.top, -10)
            
            Spacer()
                
        }
        .padding()
    }
    
    /**
     Get number of miles the user should be at or under on their car lease.
     */
    func getSuggestedMiles() -> Int {
        let numDaysSincePurchase = Calendar(identifier: .gregorian).numberOfDaysSince(purchaseDate)
        return (Int(milesPerYear) ?? 0) * numDaysSincePurchase / 365
    }
}

#Preview {
    ContentView()
}
