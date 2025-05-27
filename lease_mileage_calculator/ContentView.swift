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
    
    @AppStorage("purchase_date") var purchaseDateStorage: Date = Date()
    @AppStorage("miles_per_year") var milesPerYearStorage: String = ""
    
    @FocusState private var showKeyboard: Bool
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            DatePicker("Car purchase date",
                       selection: $purchaseDate,
                       in: ...Date(),
                       displayedComponents: [.date])
            .onAppear() {
                purchaseDate = purchaseDateStorage
            }
            .onChange(of: purchaseDate) {
                purchaseDateStorage = purchaseDate
            }
            .onTapGesture {
                showKeyboard = false
            }
            
            HStack {
                Text("# of miles per year")
                Spacer()
                TextField("", text: $milesPerYear) {
                    showKeyboard = false
                }
                    .keyboardType(.numberPad)
                    .onAppear() {
                        milesPerYear = milesPerYearStorage
                    }
                    .onChange(of: milesPerYear) {
                        milesPerYear = milesPerYear.filter { "0123456789".contains($0) }
                        milesPerYearStorage = milesPerYear
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 120)
                    .focused($showKeyboard)
            }
            
            Spacer()
            
            VStack {
                Text("You should be at or under")
                Text("\(getSuggestedMiles())")
                    .scaledToFit()
                    .padding(.horizontal, 40)
                    .font(.system(size: 100, weight: .bold))
                    .minimumScaleFactor(0.01)
                Text("miles")
            }
            .frame(width: UIScreen.main.bounds.size.width - 40)
            .onTapGesture {
                showKeyboard = false
            }
            .sensoryFeedback(.selection, trigger: showKeyboard)
            .sensoryFeedback(.selection, trigger: purchaseDate)
            
            Spacer()
                
        }
        .padding()
    }
    
    /**
     Get the approximate number of miles the user's lease allows for as of
     the current date.

     Returns: number of miles rounded down to the closest integer.
     */
    func getSuggestedMiles() -> Int {
        let calendar: Calendar = Calendar(identifier: .gregorian)
        let daysSincePurchase: Int = calendar.numberOfDaysSince(self
        .purchaseDate)
        let numMiles: Int = Int(milesPerYear) ?? 0
        return numMiles * daysSincePurchase / 365
    }
}

#Preview {
    ContentView()
}
