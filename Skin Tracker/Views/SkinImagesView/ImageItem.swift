//
//  ImageItem.swift
//  Skin Tracker
//
//  Created by Lidiia Diachkovskaia on 4/24/25.
//

import SwiftUI

struct ImageItem: View {
    var storedImageData: StoredImage
    var onDelete: () -> Void
    
    @State private var showDeleteAlert = false
    @State private var isFullScreen = false
    
    var body: some View {
        if let skinImage = UIImage(data: storedImageData.imageData) {
            Image(uiImage: skinImage)
                .renderingMode(.original)
                .resizable()
                .scaledToFill()
                .frame(width: 155, height: 155)
                .clipped()
                .cornerRadius(8)
                .onTapGesture(count: 2) {
                    isFullScreen = true
                }
                .onLongPressGesture {
                    showDeleteAlert = true
                }
                .confirmationDialog("Delete this image?", isPresented: $showDeleteAlert, titleVisibility: .visible) {
                    Button("Delete", role: .destructive) {
                        onDelete()
                    }
                    Button("Cancel", role: .cancel) {}
                }
                .fullScreenCover(isPresented: $isFullScreen) {
                    FullScreenImageView(image: skinImage, isPresented: $isFullScreen)
                }
        }
    }
}

struct FullScreenImageView: View {
    var image: UIImage
    @Binding var isPresented: Bool

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.clear)
                .onTapGesture {
                    isPresented = false
                }
        }
    }
}

//#Preview {
//    if let uiImage = UIImage(named: "lake"),
//       let data = uiImage.jpegData(compressionQuality: 1.0) {
//       ImageItem(storedImageData: StoredImage(imageData: data))
//    }
//}
