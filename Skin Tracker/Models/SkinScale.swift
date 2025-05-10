//
//  SkinScale.swift
//  Skin Tracker
//
//  Created by Lidiia Diachkovskaia on 4/18/25.
//

import SwiftData

@Model
class SkinScale {
    var mood: Double
    var skinCalmness: Double
    var sleep: Double
    
    init(mood: Double = 3, skinCalmness: Double = 3, sleep: Double = 3) {
        self.mood = mood
        self.skinCalmness = skinCalmness
        self.sleep = sleep
    }
}
