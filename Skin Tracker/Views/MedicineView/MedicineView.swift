//
//  MedicineView.swift
//  Skin Tracker
//
//  Created by Lidiia Diachkovskaia on 4/14/25.
//

import SwiftUI
import SwiftData

struct MedicineView: View {
    @Binding var skinDay: SkinDay
    @State private var showAlert = false

    var body: some View {
        VStack(alignment: .trailing) {
            Button("add", systemImage: "plus.circle") {
                if checkIfMedEmpty() {
                    showAlert = true
                } else {
                    skinDay.medicines.append(MedicineData(name: "", isSelected: false))
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
            .foregroundColor(.white)

            ForEach(Array(skinDay.medicines.enumerated()), id: \.element.id) { index, medicine in
                MedicineRowView(medicineData: Binding(
                    get: { skinDay.medicines[index] },
                    set: { skinDay.medicines[index] = $0 }
                ))
            }
            .onDelete(perform: deleteMedicine)
            .padding(.vertical, -11)
        }
        .alert("Fill out before continuing", isPresented: $showAlert) {
            Button("OK", role: .cancel) { showAlert = false }
        }
    }

    func checkIfMedEmpty() -> Bool {
        skinDay.medicines.contains { $0.name.trimmingCharacters(in: .whitespaces).isEmpty }
    }

    func deleteMedicine(at offsets: IndexSet) {
        skinDay.medicines.remove(atOffsets: offsets)
    }
}



#Preview {
//    struct PreviewWrapper: View {
//           @State private var sampleMeds = SampleData.shared.medicines
//
//           var body: some View {
//               MedicineView(medicines: sampleMeds)
//                   .modelContainer(SampleData.shared.modelContainer)
//           }
//       }
//       
//       return PreviewWrapper()
}

