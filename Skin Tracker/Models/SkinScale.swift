//
//  SkinScale.swift
//  Skin Tracker
//
//  Created by Lidiia Diachkovskaia on 4/18/25.
//

import SwiftData

@Model
class SkinScale {
    var mood: Int
    var itch: Int
    var sleep: Int
    
    init(mood: Int = 3, itch: Int = 3, sleep: Int = 3) {
        self.mood = mood
        self.itch = itch
        self.sleep = sleep
    }
}
