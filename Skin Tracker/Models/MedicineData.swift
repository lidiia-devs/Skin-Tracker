//
//  MedicineData.swift
//  Skin Tracker
//
//  Created by Lidiia Diachkovskaia on 4/18/25.
//

import SwiftData
import Foundation

@Model
class MedicineData {
    var name: String
    var isSelected: Bool
    var dateCreated: Date
    
    init(name: String = "", isSelected: Bool = false) {
        self.name = name
        self.isSelected = isSelected
        self.dateCreated = Date()
    }
    
    static let sampleData = [
        MedicineData(name: "Vit D", isSelected: true),
        MedicineData(name: "Vit D", isSelected: true),
        MedicineData(name: "Vit D", isSelected: true),
    ]
}
