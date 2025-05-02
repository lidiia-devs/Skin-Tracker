//
//  SampleData.swift
//  Skin Tracker
//
//  Created by Lidiia Diachkovskaia on 4/21/25.
//

import Foundation

import Foundation
import SwiftData

@MainActor
class SampleData {
    static let shared = SampleData()
    
    let modelContainer: ModelContainer
    
    var context: ModelContext {
        modelContainer.mainContext
    }
    
    var medicine: MedicineData{
        MedicineData.sampleData.first!
    }
    
    var medicines: [MedicineData]{
        MedicineData.sampleData
    }
    
    var skinImage: StoredImage {
        StoredImage.sampleData.first!
    }
    var skinImages: [StoredImage] {
        StoredImage.sampleData
    }
    var skinDay: SkinDay{
        SkinDay.sampleData
    }

    
    private init(){
        let schema = Schema([
            MedicineData.self,
            StoredImage.self,
            SkinDay.self
        ])
        
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        
        do{
//            throw Error()
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            
            insertSampleData()
            
            try context.save()
        } catch {
            fatalError("Could not create ModelContainer \(error)")
        }
    }
    
    private func insertSampleData(){
        for medicine in MedicineData.sampleData {
            context.insert(medicine)
        }
        
        for skinimage in StoredImage.sampleData {
            context.insert(skinimage)
        }
     
//        Friend.sampleData[0].favoriteMovie = Movie.sampleData[1]
//        Friend.sampleData[2].favoriteMovie = Movie.sampleData[0]
//        Friend.sampleData[3].favoriteMovie = Movie.sampleData[4]
//        Friend.sampleData[4].favoriteMovie = Movie.sampleData[0]
        context.insert(SkinDay.sampleData)
    }
}
