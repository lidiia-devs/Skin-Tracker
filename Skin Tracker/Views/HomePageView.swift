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
    @Query var todaySkinDays: [SkinDay]  // Fetch all SkinDays
    
    @State private var todaySkinDay: SkinDay  // Non-optional todaySkinDay

    init() {
        let calendar = Calendar.current
        
        let startOfDay = calendar.startOfDay(for: Date())
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        let predicate = #Predicate<SkinDay> {
            startOfDay <= $0.date && $0.date < endOfDay
        }
        
        let sort = [SortDescriptor(\SkinDay.date, order: .reverse)]
        
        _todaySkinDays = Query(filter: predicate, sort: sort)
        // Initialize todaySkinDay to a default value (we'll assign it later in `onAppear`)
        _todaySkinDay = State(initialValue: SkinDay(skinScale: SkinScale(mood: 3, skinCalmness: 3, sleep: 3), medicines: [], storedImages: []))
    }
    
    var body: some View {
        VStack {
            SliderView()
            // Always has a SkinDay, no need for optional handling
            MedicineView(skinDay: $todaySkinDay)
                .modelContainer(for: [StoredImage.self, MedicineData.self])
            // Pass the SkinDay as Binding to SkinImagesView
            SkinImagesView(skinDay: $todaySkinDay)
                .modelContainer(for: [StoredImage.self, MedicineData.self])
                }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
        .onAppear {
            createTodaySkinDayIfNeeded(using: context)
        }
    }
    
    // Create a SkinDay if none exists for today
    func createTodaySkinDayIfNeeded(using context: ModelContext) {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: Date())
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        let descriptor = FetchDescriptor<SkinDay>(
            predicate: #Predicate {
                $0.date >= startOfDay && $0.date < endOfDay
            }
        )
        
        if let result = try? context.fetch(descriptor), !result.isEmpty {
                   // If a SkinDay already exists, assign it to todaySkinDay
                   todaySkinDay = result.first!
               } else {
                   // If no SkinDay exists, create a new one
                   let newDay = SkinDay(
                       skinScale: SkinScale(mood: 3, skinCalmness: 3, sleep: 3),
                       medicines: [],
                       storedImages: []
                   )
                   context.insert(newDay)
                   try? context.save()
                   print("✅ Created a new SkinDay for today.")
                   // Assign the new SkinDay to todaySkinDay
                   todaySkinDay = newDay
               }
           }
}

#Preview {
    HomePageView()
        .modelContainer(SampleData.shared.modelContainer)
}
