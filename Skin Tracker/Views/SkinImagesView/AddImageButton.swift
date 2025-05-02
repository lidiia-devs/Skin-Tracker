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
                
                //            if ifSettingsChanged {
                //                //button that launches to settings
                //                //cancels
                //            } else {
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
            .onAppear {
                //getting settings preference
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
        .onChange(of: selectedImage) { oldValue, newValue in
            if let image = newValue {
                saveImageToSwiftData(image)
                selectedImage = nil
            }
        }
    }
    
    func saveImageToSwiftData(_ image: UIImage) {
        if let imageData = image.jpegData(compressionQuality: 0.8) {
            let newStoredImage = StoredImage(imageData: imageData)
            context.insert(newStoredImage)
            try? context.save()
        }
    }
}
        
    //upload image to swiftData


#Preview {
    AddImageButton()
}
