//
//  Skin_TrackerApp.swift
//  Skin Tracker
//
//  Created by Lidiia Diachkovskaia on 4/14/25.
//

import SwiftUI

@main
struct Skin_TrackerApp: App {
    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
        .modelContainer(for: [SkinDay.self, MedicineData.self, StoredImage.self])
    }
}
