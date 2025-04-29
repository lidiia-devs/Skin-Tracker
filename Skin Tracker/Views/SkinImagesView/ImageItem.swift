//
//  ImageItem.swift
//  Skin Tracker
//
//  Created by Lidiia Diachkovskaia on 4/24/25.
//

import SwiftUI

struct ImageItem: View {
    var storedImageData: StoredImage
    
    var body: some View {
        if let skinImage = UIImage(data: storedImageData.imageData) {
            Image(uiImage: skinImage)
                .renderingMode(.original)
                .resizable()
                .frame(width: 155, height: 155)
                .cornerRadius(8)
        }
    }
    
}

#Preview {
    if let uiImage = UIImage(named: "lake"),
       let data = uiImage.jpegData(compressionQuality: 1.0) {
       ImageItem(storedImageData: StoredImage(imageData: data))
    }
}
