//
//  SkinScale.swift
//  Skin Tracker
//
//  Created by Lidiia Diachkovskaia on 4/18/25.
//

import SwiftData

@Model
class SkinSlider {
    var mood: Double
    var skinCalmness: Double
    var sleep: Double
    
    init(mood: Double = 1, skinCalmness: Double = 1, sleep: Double = 1) {
        self.mood = mood
        self.skinCalmness = skinCalmness
        self.sleep = sleep
    }
}
