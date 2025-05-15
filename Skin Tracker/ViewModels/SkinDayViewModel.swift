//
//  SkinDayViewModel.swift
//  Skin Tracker
//
//  Created by Lidiia Diachkovskaia on 5/9/25.
//

import SwiftData
import SwiftUI

class SkinDayViewModel: ObservableObject {
    
    @Published var todaySkinDay: SkinDay = SkinDay(skinSlider: SkinSlider(), medicines: [], storedImages: [])

    func checkOrCreateTodaySkinDay(using context: ModelContext) {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: Date())
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!

        let descriptor = FetchDescriptor<SkinDay>(
            predicate: #Predicate {
                $0.date >= startOfDay && $0.date < endOfDay
            }
        )

        if let result = try? context.fetch(descriptor), !result.isEmpty {
            todaySkinDay = result.first!
        } else {
            let newDay = SkinDay(skinSlider: SkinSlider(), medicines: [], storedImages: [])
            context.insert(newDay)
            try? context.save()
            todaySkinDay = newDay
        }
    }
    
    func fetchSkinDay(for date: Date, using context: ModelContext) -> SkinDay? {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!

        let descriptor = FetchDescriptor<SkinDay>(
            predicate: #Predicate {
                $0.date >= startOfDay && $0.date < endOfDay
            }
        )

        if let result = try? context.fetch(descriptor), let firstMatch = result.first {
            return firstMatch
        }
        
        return nil
    }

}
