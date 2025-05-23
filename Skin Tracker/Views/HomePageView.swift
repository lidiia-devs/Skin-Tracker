//
//  ContentView.swift
//  Skin Tracker
//
//  Created by Lidiia Diachkovskaia on 4/14/25.
//

import SwiftUI
import SwiftData

extension View {
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct HomePageView: View {
    
    @Environment(\.modelContext) private var context
    @StateObject private var viewModel = SkinDayViewModel()
    
    var body: some View {
        NavigationView{
            VStack(spacing: 0) { // Remove spacing between HStack and ScrollView
                HStack {
                    Image("SHT")
                        .resizable() // Allows the image to scale
                        .frame(width: 110, height: 55)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(formattedToday)
                        .padding(.top, 39)
                        .font(.headline)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .opacity(0.5)
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 25)
                .background(Color.background)
                Divider()
                    .background(Color.white.opacity(0.6))
                    .padding(.top, 5)
                
                ScrollView {
                    VStack {
                        Spacer().frame(height: 20)
                        SliderView(skinDay: $viewModel.todaySkinDay)
                        MedicineView(skinDay: $viewModel.todaySkinDay, isDataFromPast: false)
                        SkinImagesView(skinDay: $viewModel.todaySkinDay)
                        Spacer().frame(height: 60)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.background)
                    .onAppear {
                        viewModel.checkOrCreateTodaySkinDay(using: context)
                    }
                }
            }
            .background(Color.background) // Ensures full screen background
        }
        .onTapGesture {
            self.dismissKeyboard()
        }
    }
    
    var formattedToday: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d"
        return formatter.string(from: Date())
    }
}

#Preview {
    HomePageView()
        .modelContainer(SampleData.shared.modelContainer)
}
