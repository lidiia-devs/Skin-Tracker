//
//  CalendarView.swift
//  Skin Tracker
//
//  Created by Lidiia Diachkovskaia on 5/9/25.
//

import SwiftUI
import SwiftData

struct CalendarView: View {
    
    @Environment(\.modelContext) private var context
    @Environment(\.colorScheme) private var colorScheme

    @StateObject private var viewModel = SkinDayViewModel()
    
    @State var pastSkinDay: SkinDay?
    
    @State private var selectedDate: Date? = Date()
    @State private var displayedMonth: Date = Date()
    
    @State private var showPastSkinDay = false

    private let calendar = Calendar.current
    private let daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Month and Navigation
                HStack {
                    Button(action: { changeMonth(by: -1) }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.softGreen)
                    }
                    
                    Spacer()
                    
                    Text(monthYearString(from: displayedMonth))
                        .font(.headline)
                        .foregroundColor(colorScheme == .light ? .white : .primary)
                    
                    Spacer()
                    
                    Button(action: { changeMonth(by: 1) }) {
                        Image(systemName: "chevron.right")
                            .foregroundColor(.softGreen)
                    }
                }
                .padding(.horizontal)
                
                // Weekday Headers
                HStack {
                    ForEach(daysOfWeek, id: \.self) { day in
                        Text(day)
                            .font(.caption)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(colorScheme == .light ? .white.opacity(0.7) : .white)
                    }
                }
                
                // Calendar Grid
                let days = generateCalendarDays(for: displayedMonth)
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 10) {
                    ForEach(days, id: \.self) { date in
                        if calendar.isDateInToday(date) {
                            dayView(for: date)
                                .background(
                                    Circle().fill(Color.white.opacity(0.2))
                                )
                        } else {
                            dayView(for: date)
                        }
                    }
                }
                
                Spacer()
            }
            .padding()
            .background(Color.background)
            .onChange(of: selectedDate) { oldValue, newValue in
                if let newValue = newValue,
                   let pastSkinDate = viewModel.fetchSkinDay(for: newValue, using: context) {
                    pastSkinDay = pastSkinDate
                    showPastSkinDay = true
                } else {
                    pastSkinDay = nil
                    showPastSkinDay = false
                }
            }
            
            if showPastSkinDay {
                if let unwrappedPastSkinDay = pastSkinDay {
                    let binding = Binding<SkinDay>(
                        get: { unwrappedPastSkinDay },
                        set: { pastSkinDay = $0 }
                    )
                    
                    SliderView(skinDay: binding, isDataFromPast: true)
                    Spacer().frame(height: 25)
                    MedicineView(skinDay: binding, isDataFromPast: true)
                    SkinImagesView(skinDay: binding, isDataFromPast: true)
                    Spacer().frame(height: 60) //extra padding under images
                }
            }
        }
        .background(Color.background)
    }

    // MARK: - Helpers

    func monthYearString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLLL yyyy"
        return formatter.string(from: date)
    }

    func changeMonth(by value: Int) {
        if let newDate = calendar.date(byAdding: .month, value: value, to: displayedMonth) {
            displayedMonth = newDate
        }
    }

    func dayView(for date: Date) -> some View {
        Group {
            if calendar.isDate(date, equalTo: displayedMonth, toGranularity: .month) {
                Button(action: {
                    if date <= Date() {
                        selectedDate = date
                    }
                }) {
                    Text("\(calendar.component(.day, from: date))")
                        .frame(width: 32, height: 32)
                        .foregroundColor(textColor(for: date))
                        .background(
                            Circle()
                                .fill(Color.mintGreen)
                                .opacity(selectedDate == date ? 0.7 : 0)
                        )
                }
                .disabled(date > Date()) // Disable future days
            } else {
                Text("") // Empty space for days outside current month
                    .frame(width: 32, height: 32)
            }
        }
    }

    func textColor(for date: Date) -> Color {
        if date > Date() {
            return .white.opacity(0.3)
        } else if calendar.isDate(date, equalTo: selectedDate ?? Date(), toGranularity: .day) {
            return .white
        } else {
            return colorScheme == .light ? .white : .primary
        }
    }

    func generateCalendarDays(for date: Date) -> [Date] {
        guard
            let monthInterval = calendar.dateInterval(of: .month, for: date),
            let firstWeekday = calendar.date(from: calendar.dateComponents([.year, .month], from: monthInterval.start))
        else { return [] }

        let weekdayOffset = calendar.component(.weekday, from: firstWeekday) - calendar.firstWeekday
        let startOffset = (weekdayOffset + 7) % 7

        var days: [Date] = []

        for offset in -startOffset..<calendar.range(of: .day, in: .month, for: date)!.count {
            if let day = calendar.date(byAdding: .day, value: offset, to: firstWeekday) {
                days.append(day)
            }
        }

        return days
    }
}
    


#Preview {
    CalendarView()
        .modelContainer(SampleData.shared.modelContainer)
}
