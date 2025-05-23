//
//  MainTabView.swift
//  Skin Tracker
//
//  Created by Lidiia Diachkovskaia on 5/14/25.
//

import SwiftUI
import SwiftData

struct MainTabView: View {
    @State private var selectedTab = 0

    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                switch selectedTab {
                case 0:
                    HomePageView()
                case 1:
                    CalendarView()
                default:
                    HomePageView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white.ignoresSafeArea())

            // Custom Tab Bar
            HStack(spacing: 50) {
                Image(systemName: "house.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 28)
                    .foregroundColor(selectedTab == 0 ? .white : .white.opacity(0.5))
                    .onTapGesture {
                        selectedTab = 0
                    }

                Image(systemName: "calendar")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 23)
                    .foregroundColor(selectedTab == 1 ? .white : .white.opacity(0.5))
                    .onTapGesture {
                        selectedTab = 1
                    }
            }
            .padding(.horizontal, 50)
            .padding(.vertical, 12)
            .background(
                Capsule()
                    .fill(Color.mintGreen)
                    .frame(maxWidth: .infinity)
                    .shadow(radius: 5)// Expand to full width
            )
        }
        .ignoresSafeArea(.keyboard)
    }
}


#Preview {
    MainTabView()
}
