//
//  ContentView.swift
//  Skin Tracker
//
//  Created by Lidiia Diachkovskaia on 4/14/25.
//

import SwiftUI
import SwiftData

struct HomePageView: View {
    
    @Environment(\.modelContext) private var context
    @Query var todaySkinDays: [SkinDay]
    
    init() {
        let calendar = Calendar.current
        
        let startOfDay = calendar.startOfDay(for: Date())
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        let predicate = #Predicate<SkinDay> {
            startOfDay <= $0.date && $0.date < endOfDay
        }
        
        let sort = [SortDescriptor(\SkinDay.date, order: .reverse)]
        
        _todaySkinDays = Query(filter: predicate, sort: sort)
    }
    
    var body: some View {
        VStack {
            Text("Good Morning,")
            Text("Name")

            if let todaySkinDay = todaySkinDays.first {
                MedicineView(medicines: todaySkinDay.medicines)
                    .modelContainer(for: [StoredImage.self, MedicineData.self])
                SkinImagesView(skinDay: todaySkinDay)
                    .modelContainer(for: [StoredImage.self, MedicineData.self])
            } else {
                Text("No entry for today.")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
        .onAppear {
            createTodaySkinDayIfNeeded(using: context)
        }
    }
    
    func createTodaySkinDayIfNeeded(using context: ModelContext) {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: Date())
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        let descriptor = FetchDescriptor<SkinDay>(
            predicate: #Predicate {
                $0.date >= startOfDay && $0.date < endOfDay
            }
        )
        
        if let result = try? context.fetch(descriptor), result.isEmpty {
            // Create a basic SkinDay
            let newDay = SkinDay(
                skinScale: SkinScale(mood: 3, itch: 3, sleep: 3),
                medicines: [],
                storedImages: []
            )
            context.insert(newDay)
            try? context.save()
            print("✅ Created a new SkinDay for today.")
        }
    }
}

#Preview {
    HomePageView()
        .modelContainer(SampleData.shared.modelContainer)
}
