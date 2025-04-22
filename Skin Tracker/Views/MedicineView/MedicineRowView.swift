//
//  Untitled.swift
//  Skin Tracker
//
//  Created by Lidiia Diachkovskaia on 4/17/25.
//
import SwiftUI

struct MedicineRowView: View {
    
    @State var isSelected: Bool = false
    @State var label: String
    @State private var placeholderColor: Color = .white
    
    var body: some View {
        HStack {
            Button(action: {
                isSelected.toggle()
            }) {
                    Image(isSelected ? "buttonImageWithTick" : "buttonImage")
                        .resizable()
                        .frame(width: 43, height: 43)
            }
            .padding(.leading, 20)
            .padding(.trailing, 10)
            .padding(.vertical, 12)
            TextField("Medicine", text: $label)
                .foregroundColor(placeholderColor)
                .font(.system(size: 23, weight: .bold))
                .lineLimit(1)
                .onChange(of: label) { newValue in
                                    if newValue.count > 29 {
                                        label = String(newValue.prefix(29))
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

struct Medicine: Hashable, Identifiable {
    var id: UUID = UUID()
    var isSelected: Bool = false
    var name: String
    
}

#Preview {
  MedicineRowView(isSelected: true, label: "Test")
}
