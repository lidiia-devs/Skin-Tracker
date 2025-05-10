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
    @Binding var skinDay: SkinDay  // Bind directly to SkinDay

    var body: some View {
        VStack(alignment: .leading) {
            Text("Images")
                .font(.headline)
                .fontWeight(.heavy)
                .padding(.leading, 15)
                .padding(.top, 10)
                .padding(.bottom, -12)
                .foregroundColor(.white)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 10) {
                    AddImageButton(skinDay: $skinDay)
                        .padding(.vertical, 60)
                        .padding(.horizontal, 12)
                    
                    ForEach(skinDay.storedSkinImages) { skinImage in
                        ImageItem(storedImageData: skinImage) {
                            // Delete logic
                            if let index = skinDay.storedSkinImages.firstIndex(where: { $0.id == skinImage.id }) {
                                skinDay.storedSkinImages.remove(at: index)
                                context.delete(skinImage)
                                try? context.save()
                            }
                        }
                    }
                }
                .padding(.leading, 12)
            }
            .frame(height: 185)
        }
        .background(Color.background)
    }
}



//#Preview {
//    SkinImagesView()
//        .modelContainer(SampleData.shared.modelContainer)
//}
