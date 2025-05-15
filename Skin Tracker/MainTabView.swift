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
        TabView(selection: $selectedTab) {
            HomePageView()
                .tabItem {
                    Image(systemName: "house")
                }
                .tag(0)

            CalendarView()
                .tabItem {
                    Image(systemName: "calendar")
            }
                .tag(1)
        }
        .accentColor(.white) // icon/text color
        .onAppear {
            UITabBar.appearance().barTintColor = UIColor.white
            UITabBar.appearance().unselectedItemTintColor = UIColor.white.withAlphaComponent(0.5)
        }
    }
}

#Preview {
    MainTabView()
}
