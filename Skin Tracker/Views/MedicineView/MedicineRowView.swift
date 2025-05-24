//
//  Untitled.swift
//  Skin Tracker
//
//  Created by Lidiia Diachkovskaia on 4/17/25.
//
import SwiftUI

struct MedicineRowView: View {
    @Binding var medicineData: MedicineData
    var isDataFromPast: Bool
    var index: Int
   
    @State private var placeholderColor: Color = .white
    @FocusState.Binding var focusedIndex: Int?

    var body: some View {
        HStack {
            Button(action: {
                if !isDataFromPast {
                    medicineData.isSelected.toggle()
                }
            }) {
                Image(medicineData.isSelected ? "buttonImageWithTick" : "buttonImageWithTick")
                    .resizable()
                    .frame(width: 43, height: 43)
            }
            .padding(.leading, 20)
            .padding(.trailing, 10)
            .padding(.vertical, 12)
            
            TextField("Medicine", text: $medicineData.name)
                .foregroundColor(.white)
                .font(.system(size: 23, weight: .medium))
                .lineLimit(1)
                .focused($focusedIndex, equals: index)
                .onChange(of: medicineData.name) { newValue in
                    if newValue.count > 29 {
                        medicineData.name = String(newValue.prefix(29))
                    }
                }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.background)
        .overlay(isDataFromPast ? Color.black.opacity(0.001).allowsHitTesting(true) : nil)
    }
    
    func alertEmptyText () {
        placeholderColor = .red
                // Then back to gray after 2 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    placeholderColor = .white
                }
    }
}

#Preview {
 //   let testMedData = MedicineData()
 // MedicineRowView(medicineData)
}
