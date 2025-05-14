//
//  CalendarView.swift
//  Skin Tracker
//
//  Created by Lidiia Diachkovskaia on 5/9/25.
//

import SwiftUI

struct CalendarView: View {
    @State private var selectedDate: Date? = Date()
    @State private var displayedMonth: Date = Date()

    private let calendar = Calendar.current
    private let daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]

    var body: some View {
        VStack(spacing: 16) {
            // Month and Navigation
            HStack {
                Button(action: { changeMonth(by: -1) }) {
                    Image(systemName: "chevron.left")
                }

                Spacer()

                Text(monthYearString(from: displayedMonth))
                    .font(.headline)

                Spacer()

                Button(action: { changeMonth(by: 1) }) {
                    Image(systemName: "chevron.right")
                }
            }
            .padding(.horizontal)

            // Weekday Headers
            HStack {
                ForEach(daysOfWeek, id: \.self) { day in
                    Text(day)
                        .font(.caption)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.gray)
                }
            }

            // Calendar Grid
            let days = generateCalendarDays(for: displayedMonth)
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 10) {
                ForEach(days, id: \.self) { date in
                    if calendar.isDateInToday(date) {
                        dayView(for: date)
                            .background(
                                Circle().fill(Color.blue.opacity(0.2))
                            )
                    } else {
                        dayView(for: date)
                    }
                }
            }

            Spacer()
        }
        .padding()
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
                                .fill(Color.blue)
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
            return .gray.opacity(0.3)
        } else if calendar.isDate(date, equalTo: selectedDate ?? Date(), toGranularity: .day) {
            return .white
        } else {
            return .primary
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
}
