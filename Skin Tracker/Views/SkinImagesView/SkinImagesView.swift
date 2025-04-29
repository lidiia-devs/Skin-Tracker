//
//  SkinImagesView.swift
//  Skin Tracker
//
//  Created by Lidiia Diachkovskaia on 4/24/25.
//

import SwiftUI
import SwiftData

struct SkinImagesView: View {
    
    @Environment(\.modelContext) private var context
    @Query var storedImages: [StoredImage]
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("Images")
                .font(.headline)
                .fontWeight(.heavy)
                .padding(.leading, 15)
                .padding(.top, 10)
                .padding(.bottom, -12)
                .foregroundColor(.white)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 10) {
                    AddImageButton()
                        .padding(.vertical, 60)
                        .padding(.horizontal, 12)
                    ForEach(storedImages) { skinImage in
                        ImageItem(storedImageData: skinImage)
                    }
                }
                .padding(.leading, 12)
            }
            .frame(height: 185)
        }
        .background(Color.background)
    }
}

#Preview {
    SkinImagesView()
        .modelContainer(SampleData.shared.modelContainer)
}
