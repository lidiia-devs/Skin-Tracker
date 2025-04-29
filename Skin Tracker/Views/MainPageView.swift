//
//  mainPageView.swift
//  Skin Tracker
//
//  Created by Lidiia Diachkovskaia on 4/21/25.
//

import SwiftUI

struct MainPageView: View {
    
    var body: some View {
        VStack {
            MedicineView()
            SkinImagesView()
        }
    }
}

#Preview{
    MainPageView()
        .modelContainer(SampleData.shared.modelContainer)
}
