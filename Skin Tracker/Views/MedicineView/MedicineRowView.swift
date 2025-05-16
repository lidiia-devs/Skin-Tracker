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
    @State private var placeholderColor: Color = .white
    
    var body: some View {
        HStack {
            Button(action: {
                if !isDataFromPast { // used for static viewing past dayViews
                    medicineData.isSelected.toggle()
                }
            }) {
                Image(medicineData.isSelected ? "buttonImageWithTick" : "buttonImage")
                    .resizable()
                    .frame(width: 43, height: 43)
            }
            .padding(.leading, 20)
            .padding(.trailing, 10)
            .padding(.vertical, 12)
            TextField("Medicine", text: $medicineData.name)
                .foregroundColor(placeholderColor)
                .font(.system(size: 23, weight: .bold))
                .lineLimit(1)
                .onChange(of: medicineData.name) { newValue in
                                    if newValue.count > 29 {
                                        medicineData.name = String(newValue.prefix(29))
                                    }
                                }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.background)
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
