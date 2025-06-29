//
//  MileageCalculatorWidgets.swift
//  MileageCalculatorWidgets
//
//  Created by Arthur Efremenko on 6/29/25.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> MileageCalculatorEntry {
        MileageCalculatorEntry(date: Date(), purchaseDate: Date(), mileagePerYear: "0")
    }

    func getSnapshot(in context: Context, completion: @escaping (MileageCalculatorEntry) -> ()) {
        let entry = MileageCalculatorEntry(date: Date(), purchaseDate: Date(), mileagePerYear: "0")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [MileageCalculatorEntry] = []

        let entry = MileageCalculatorEntry(date: Date(), purchaseDate: stringToDate( SharedData.purchaseDate) ?? Date(), mileagePerYear: SharedData.milesPerYear)
        entries.append(entry)

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct MileageCalculatorEntry: TimelineEntry {
    let date: Date
    
    let purchaseDate: Date
    let mileagePerYear: String
}

struct MileageCalculatorWidgetsEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text("\(getSuggestedMiles(purchaseDate: entry.purchaseDate, milesPerYear: entry.mileagePerYear))")
                .scaledToFit()
                .font(.system(size: 100, weight: .bold))
                .minimumScaleFactor(0.01)
            Text("miles")
                .font(.caption)
        }
    }
    
    /**
     Get the approximate number of miles the user's lease allows for as of
     the current date.
     
     Returns: number of miles rounded down to the closest integer.
     */
    func getSuggestedMiles(purchaseDate: Date, milesPerYear: String) -> Int {
        let calendar: Calendar = Calendar(identifier: .gregorian)
        let daysSincePurchase: Int = calendar.numberOfDaysSince(purchaseDate)
        
        if daysSincePurchase < 0 {
            return 0
        }
        
        let numMiles: Int = Int(milesPerYear) ?? 0
        return numMiles * daysSincePurchase / 365
    }
}

struct MileageCalculatorWidgets: Widget {
    let kind: String = "MileageCalculatorWidgets"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            MileageCalculatorWidgetsEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

#Preview(as: .systemSmall) {
    MileageCalculatorWidgets()
} timeline: {
    MileageCalculatorEntry(date: .now, purchaseDate: .distantPast, mileagePerYear: "15000")
}
