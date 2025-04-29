//
//  AddImageButton.swift
//  Skin Tracker
//
//  Created by Lidiia Diachkovskaia on 4/24/25.
//

import SwiftUI

struct AddImageButton: View {
    

    //TODO: 1 create alert that has photo library and camera
    //add variable to check if settings permission granted
    var ifSettingsChanged: Bool = false
//    @State private var showImagePicker = false
//    @State private var useCamera = false
//    @State private var selectedImage: UIImage?
    
    @Environment(\.modelContext) private var context
//@Query var savedImages: [StoredImage]

    
    @State var alertIsPresented: Bool = false
    
    var body: some View {
        Button {
            alertIsPresented.toggle()
        } label: {
            Image(systemName: "plus.circle.fill")
                .resizable()
                .frame(width: 25, height: 25)
                .cornerRadius(8)
                .foregroundColor(.white)
                .background(Color.background)
        }
        .alert("Add Image", isPresented: $alertIsPresented) {
            
            if ifSettingsChanged {
                //button that launches to settings
                //cancels
           } else {
               Button("Open Camera", role: .none) {
                //TODO: launch the imagepicker
//                   PermissionManager.checkPermission(for: .camera) { granted in
//                       if granted {
//                           useCamera = true
//                           showImagePicker = true
//                       } else {
//                           alertMessage = "Camera access is required to take photos"
//                           showSettingsutton = true
//                           showPermissionAlert = true
//                       }
//                   }
            }
            Button("Upload from Library", role: .none) {
                //TODO: launch the imagepicker
            
            }
            Button("Cancel", role: .cancel) {}
        }
    }
        .onAppear {
            //getting settings preference
        }
}
           //upload image to swiftData
}

#Preview {
    AddImageButton()
}
