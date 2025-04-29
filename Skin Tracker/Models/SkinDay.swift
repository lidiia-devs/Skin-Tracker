//
//  SkinDay.swift
//  Skin Tracker
//
//  Created by Lidiia Diachkovskaia on 4/18/25.
//

import SwiftData
import Foundation

@Model
class SkinDay {
    var date: Date
    var skinScale: SkinScale
    var medicines: [MedicineData]
    var storedSkinImages: [StoredImage]
   //TODO: var image
    
    init(skinScale: SkinScale, medicines: [MedicineData], storedImages: [StoredImage]) {
        self.date = Date()
        self.skinScale = skinScale
        self.medicines = medicines
        self.storedSkinImages = storedImages
    }
    
}


