//
//  MedicineView.swift
//  Skin Tracker
//
//  Created by Lidiia Diachkovskaia on 4/14/25.
//

import SwiftUI
import SwiftData

struct MedicineView: View {
    
    //add real swiftData Query
  @Environment(\.modelContext) private var context
    //Sort:
    //@Query(sort: \MedicineData.dateCreated) private var medicines: [MedicineData]
    
    @State var medicines: [MedicineData]
    @State private var showAlert = false
    
    var body: some View {
        VStack (alignment: .trailing) {
            Button("add", systemImage: "plus.circle") {
               
                if checkIfMedEmpty() {
                    //let user know it's empty - alert
                    showAlert = true
                } else {
                    //adding swiftData
                    context.insert(MedicineData(name: "", isSelected: false))
                }
            } .padding(.horizontal)
            
            ForEach (medicines) { medicine in
                MedicineRowView(medicineData:
            Binding(get: { medicine
                }, set: { newValue in
                    medicine.name = newValue.name
                    medicine.isSelected = newValue.isSelected
                    }))
            }
            .padding(.vertical, -4)
            .alert("Fill out before continuing", isPresented: $showAlert) {
                Button("OK", role: .cancel) {
                    showAlert = false
                }
            }
        }
    }
    
    func checkIfMedEmpty() -> Bool {
        medicines.contains{ $0.name.trimmingCharacters(in: .whitespaces).isEmpty}
    }
    
}



#Preview {
    struct PreviewWrapper: View {
           @State private var sampleMeds = SampleData.shared.medicines

           var body: some View {
               MedicineView(medicines: sampleMeds)
                   .modelContainer(SampleData.shared.modelContainer)
           }
       }
       
       return PreviewWrapper()
}

