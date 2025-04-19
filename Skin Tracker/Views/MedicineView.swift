//
//  MedicineView.swift
//  Skin Tracker
//
//  Created by Lidiia Diachkovskaia on 4/14/25.
//

import SwiftUI

struct MedicineView: View {
    @State var medicines: [Medicine] = [Medicine(name: "Vitamin C"), Medicine(name: "Vitamin D"), Medicine(name: "Steroids")]
    
    var body: some View {
        VStack (alignment: .trailing) {
            Button("add", systemImage: "plus.circle") {
                if checkIfMedEmpty() {
                    
                    //let user know it's empty
                    
                } else {
                  
                    medicines.append(Medicine(name: ""))
                }
               
            } .padding(.horizontal)
            
            ForEach (medicines, id: \.self) { medicineView in
                MedicineRowView(label: medicineView.name)
            }
            .padding(.vertical, -4)
        }
    }
    
    func checkIfMedEmpty() -> Bool {
        for medicine in medicines {
            if medicine.name == "" {
                return true
            }
        }
        return false
    }
    
}



#Preview {
    MedicineView()
}
//
//for medicine in medicines {
//        if medicine.name == "" {
//            break
//    }
//    }
//   let medicine = Medicine(name: "")
//    medicines.append(medicine)
//}
//ForEach (medicines, id: \.self) { medicineView in
//    MedicineRowView(label: medicineView.name)
//}
//.padding(.vertical, -4)
