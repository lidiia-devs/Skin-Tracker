//
//  MedicineData.swift
//  Skin Tracker
//
//  Created by Lidiia Diachkovskaia on 4/18/25.
//

import SwiftData

@Model
class MedicineData {
    var name: String
    var isSelected: Bool
    
    init(name: String = "", isSelected: Bool = false) {
        self.name = name
        self.isSelected = isSelected
    }
}
