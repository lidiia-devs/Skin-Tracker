//
//  AddImageButton.swift
//  Skin Tracker
//
//  Created by Lidiia Diachkovskaia on 4/24/25.
//

import SwiftUI
import SwiftData

struct AddImageButton: View {

    //TODO: 1 create alert that has photo library and camera
    //add variable to check if settings permission granted
    var ifSettingsChanged: Bool = false
    @State private var showImagePicker = false
    @State private var useCamera = false
    @State private var selectedImage: UIImage?
    
    @Environment(\.modelContext) private var context
    @Query var savedImages: [StoredImage]
    
    //Alert management
    @State private var showPermissionAlert = false
    @State private var alertMessage = ""
    @State private var showSettingsButton = false
    @State var alertIsPresented: Bool = false
    
    var body: some View {
        VStack {
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
                    PermissionManager.checkPermission(for: .camera) { granted in
                        if granted {
                            useCamera = true
                            showImagePicker = true
                        } else {
                            alertMessage = "Camera access is required to take photos"
                            showSettingsButton = true
                            showPermissionAlert = true
                        }
                    }
                }
                Button("Upload from Library", role: .none) {
                    //TODO: launch the imagepicker
                    PermissionManager.checkPermission(for: .photoLibrary) { granted in
                        if granted {
                            useCamera = false
                            showImagePicker = true
                        } else {
                            alertMessage = "Photo library access is required to upload photos"
                            showSettingsButton = true
                            showPermissionAlert = true
                        }
                    }
                    
                }
                Button("Cancel", role: .cancel) {}
            }
        }
        .onAppear {
            //getting settings preference
        }
        
        if selectedImage != nil {
            Button("Save to SwiftData") { //Important: when storing photos to swift data, must turn image into data first
                if let imageData = selectedImage?.jpegData(compressionQuality: 0.8) {
                    let newImage = StoredImage(imageData: imageData)
                    context.insert(newImage)
                    try? context.save()
                }
            }
        }
    }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(sourceType: useCamera ? .camera : .photoLibrary, selectedImage: $selectedImage)
        }
        .alert("Permission Required", isPresented: $showPermissionAlert) {
            if showSettingsButton {
                Button("Open Settings") {
                    PermissionManager.openAppSettings()
                }
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text(alertMessage)
        }
    }
        
    //upload image to swiftData
}

#Preview {
    AddImageButton()
}
