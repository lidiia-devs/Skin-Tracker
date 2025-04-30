//
//  ContentView.swift
//  Skin Tracker
//
//  Created by Lidiia Diachkovskaia on 4/14/25.
//

import SwiftUI

struct HomaPageView: View {
    
    var body: some View {
        VStack {
            Text("Good Morning,")
            Text("Name")
            SkinImagesView()
                .modelContainer(SampleData.shared.modelContainer)

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
    }
}

#Preview {
    HomaPageView()
}
