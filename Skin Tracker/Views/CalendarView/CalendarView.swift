//
//  CalendarView.swift
//  Skin Tracker
//
//  Created by Lidiia Diachkovskaia on 5/9/25.
//

import SwiftUI

struct CalendarView: View {
    let calendar = Calendar.current
    let days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]

    var currentMonthDates: [Date] {
        guard let range = calendar.range(of: .day, in: .month, for: Date()),
              let firstOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: Date())) else {
            return []
        }

        let weekdayOffset = calendar.component(.weekday, from: firstOfMonth) - 1
        let totalDays = range.count + weekdayOffset

        return (0..<totalDays).map { index in
            if index < weekdayOffset {
                return Date.distantPast // Placeholder for empty cells
            } else {
                return calendar.date(byAdding: .day, value: index - weekdayOffset, to: firstOfMonth)!
            }
        }
    }

    var body: some View {
        VStack {
            Text("📅 \(formattedMonthYear(Date()))")
                .font(.title2)
                .bold()

            // Day labels (Sun, Mon, etc.)
            HStack {
                ForEach(days, id: \.self) { day in
                    Text(day)
                        .frame(maxWidth: .infinity)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }

            // Grid of dates
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
                ForEach(currentMonthDates, id: \.self) { date in
                    if calendar.isDate(date, equalTo: Date.distantPast, toGranularity: .day) {
                        Color.clear.frame(height: 35) // Empty slot
                    } else {
                        Text("\(calendar.component(.day, from: date))")
                            .frame(height: 35)
                            .frame(maxWidth: .infinity)
                            .background(calendar.isDateInToday(date) ? Color.blue.opacity(0.2) : Color.clear)
                            .clipShape(Circle())
                    }
                }
            }
        }
        .padding()
    }

    func formattedMonthYear(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLLL yyyy"
        return formatter.string(from: date)
    }
}

#Preview {
    CalendarView()
}
