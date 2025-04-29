//
//  StoredImage.swift
//  Skin Tracker
//
//  Created by Lidiia Diachkovskaia on 4/24/25.
//

import SwiftUI
import SwiftData

@Model
class StoredImage: Identifiable {
    var imageData: Data //image must be stored as data not UIImage ot Image
    var dateCreated: Date
    
    init(imageData: Data, dateCreated: Date = Date()) {
        self.imageData = imageData
        self.dateCreated = Date() //or dateCreated
    }
    
    static let sampleData: [StoredImage] = {
        if let uiImage = UIImage(named: "lake"),
           let data = uiImage.jpegData(compressionQuality: 1.0) {
            return [StoredImage(imageData: data), StoredImage(imageData: data)]
        } else {
            return []
        }
    } ()
}
