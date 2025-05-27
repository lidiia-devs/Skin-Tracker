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
                        focusedFieldIndex = newIndex
                               
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                .padding(.bottom, 15)
                .foregroundColor(.white)
            }

            ForEach($skinDay.medicines) { $medicine in
                SwipeToDeleteRow(isSwipeEnabled: !isDataFromPast, onDelete: {
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
            }
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
    let isSwipeEnabled: Bool

    @State private var offset: CGFloat = 0
    @GestureState private var dragOffset: CGFloat = 0

    init(isSwipeEnabled: Bool = true, onDelete: @escaping () -> Void, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.onDelete = onDelete
        self.isSwipeEnabled = isSwipeEnabled
    }

    var body: some View {
        ZStack(alignment: .trailing) {
            if isSwipeEnabled {
                Color.red
                    .frame(maxHeight: .infinity)
                    .overlay(
                        Image(systemName: "trash.fill")
                            .foregroundColor(.white)
                            .padding(.trailing, 20),
                        alignment: .trailing
                    )
            }

            content
                .background(Color(.systemBackground))
                .contentShape(Rectangle())
                .offset(x: isSwipeEnabled ? (offset + dragOffset) : 0)
                .gesture(
                    isSwipeEnabled ?
                    DragGesture()
                        .updating($dragOffset) { value, state, _ in
                            if value.translation.width < 0 {
                                state = value.translation.width
                            }
                        }
                        .onEnded { value in
                            if value.translation.width < -100 {
                                withAnimation {
                                    onDelete()
                                }
                            } else {
                                withAnimation {
                                    offset = 0
                                }
                            }
                        }
                    : nil
                )
        }
        .padding(.vertical, 7)
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

