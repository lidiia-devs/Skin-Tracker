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
    @StateObject private var viewModel = SkinDayViewModel()

    var body: some View {
        VStack {
            SliderView(skinDay: $viewModel.todaySkinDay)
            MedicineView(skinDay: $viewModel.todaySkinDay, isDataFromPast: false)
            SkinImagesView(skinDay: $viewModel.todaySkinDay)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
        .onAppear {
            viewModel.checkOrCreateTodaySkinDay(using: context)
        }
    }
}

#Preview {
    HomePageView()
        .modelContainer(SampleData.shared.modelContainer)
}
