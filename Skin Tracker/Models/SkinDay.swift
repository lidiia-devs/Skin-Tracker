//
//  SkinDay.swift
//  Skin Tracker
//
//  Created by Lidiia Diachkovskaia on 4/18/25.
//

import SwiftData
import SwiftUI

@Model
class SkinDay {
    var date: Date
    var skinSlider: SkinSlider
    var medicines: [MedicineData]
    var storedSkinImages: [StoredImage]
   //TODO: var image
    
    init(skinSlider: SkinSlider, medicines: [MedicineData], storedImages: [StoredImage]) {
        self.date = Date()
        self.skinSlider = skinSlider
        self.medicines = medicines
        self.storedSkinImages = storedImages
    }
    
    static let sampleData: SkinDay = {
        let defaultImage = UIImage(named: "lake")!
        let data = defaultImage.jpegData(compressionQuality: 1.0)!
        
        return SkinDay(
            skinSlider: SkinSlider(mood: 1, skinCalmness: 1, sleep: 1),
            medicines: [
                MedicineData(name: "Vitamin D", isSelected: true),
                MedicineData(name: "Steroid cream", isSelected: true)
            ],
            storedImages: [
                StoredImage(imageData: data),
                StoredImage(imageData: data)
            ]
            )
    } ()
    
}


