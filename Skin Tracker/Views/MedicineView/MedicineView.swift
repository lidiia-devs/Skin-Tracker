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
    @FocusState private var focusedFieldIndex: Int?
    
    var isDataFromPast: Bool = false
    
    var body: some View {
        VStack(alignment: .trailing) {
            if !isDataFromPast {
                Button("add", systemImage: "plus.circle.fill") {
                    if checkIfMedEmpty() {
                        showAlert = true
                    } else {
                        let newIndex = skinDay.medicines.count
                        skinDay.medicines.append(MedicineData(name: "", isSelected: false))
                        DispatchQueue.main.async {
                                    focusedFieldIndex = newIndex
                                }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                .foregroundColor(.white)
            }
            
//            ForEach(Array(skinDay.medicines.enumerated()), id: \.element.id) { index, medicine in
//                MedicineRowView(
//                    medicineData: Binding(
//                        get: { skinDay.medicines[index] },
//                        set: { skinDay.medicines[index] = $0 }
//                    ),
//                    isDataFromPast: self.isDataFromPast,
//                    index: index,
//                    focusedIndex: $focusedFieldIndex
//                )
//            }

            ForEach($skinDay.medicines) { $medicine in
                SwipeToDeleteRow(onDelete: {
                    if let index = skinDay.medicines.firstIndex(where: { $0.id == medicine.id }) {
                        skinDay.medicines.remove(at: index)
                    }
                }) {
                    MedicineRowView(
                        medicineData: $medicine,
                        isDataFromPast: self.isDataFromPast,
                        index: skinDay.medicines.firstIndex(where: { $0.id == medicine.id }) ?? 0,
                        focusedIndex: $focusedFieldIndex
                    )
                }
                //.padding(.vertical, 4)
            }            //.onDelete(perform: deleteMedicine)
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


struct SwipeToDeleteRow<Content: View>: View {
    let content: Content
    let onDelete: () -> Void
    
    @State private var offset: CGFloat = 0
    @GestureState private var dragOffset: CGFloat = 0
    
    init(onDelete: @escaping () -> Void, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.onDelete = onDelete
    }
    
    var body: some View {
        ZStack(alignment: .trailing) {
            Color.red
                .frame(maxHeight: .infinity)
                .overlay(
                    Image(systemName: "trash")
                        .foregroundColor(.white)
                        .padding(.trailing, 20),
                    alignment: .trailing
                )
            
            content
                .background(Color(.systemBackground))
                .contentShape(Rectangle())
                .offset(x: offset + dragOffset)
                .gesture(
                    DragGesture()
                        .updating($dragOffset) { value, state, _ in
                            if value.translation.width < 0 {
                                state = value.translation.width
                            }
                        }
                        .onEnded { value in
                            if value.translation.width < -100 {
                                // trigger delete
                                withAnimation {
                                    onDelete()
                                }
                            } else {
                                // snap back
                                withAnimation {
                                    offset = 0
                                }
                            }
                        }
                )
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
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

