//
//  MKRImagePicker.swift
//  CP67
//
//  Created by Manoj on 06/01/20.
//  Copyright © 2020 zapbuild. All rights reserved.
//

import Foundation
import UIKit
import Photos
protocol MKRImagePickerDelegate:class {
    func imageSelectionSuccessful(selectedImage:UIImage)
    func imageSelectionCancelled()
}
class MKRImagePicker:NSObject{
    //MARK:- Properties
    var imageDelegate:MKRImagePickerDelegate?
    var imagePicker:UIImagePickerController = UIImagePickerController()
    
    //MARK:- Permissions Methods
    private func openImagePickerHandler(sourceType:UIImagePickerController.SourceType,controller:UIViewController){
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        imagePicker.allowsEditing = true
        controller.present(imagePicker, animated: true, completion: {
            self.imagePicker.navigationBar.topItem?.rightBarButtonItem?.isEnabled = true
        })
    }
    
    private func openAppSettings(){
        if let url = URL(string:UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    private func showAlert(title:String,message:String,controller:UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Open Settings", style: .default, handler: { action in
            self.openAppSettings()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { action in
            controller.dismiss(animated: false, completion: nil)
        }))
        controller.present(alert, animated: true)
    }
    
    //Checking PhotoLibraryPermission
    func checkPhotoLibraryPermission(controller:UIViewController) {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            openImagePickerHandler(sourceType: .photoLibrary, controller: controller)
        case .denied, .restricted :
            self.showAlert(title: "Permission Denied", message: "Please grant photo library permissions in Settings to continue using this service", controller: controller)
            
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { (status) in
                if status.rawValue == 3{
                    self.openImagePickerHandler(sourceType: .photoLibrary, controller: controller)
                }else{
                    self.showAlert(title: "Permission Denied", message: "Please grant photo library permissions in Settings to continue using this service", controller: controller)
                }
            }
        default:
            break
        }
    }
    
    //Checking Camera Permission
    func checkCameraPermission(controller:UIViewController) {
        if AVCaptureDevice.authorizationStatus(for: .video) ==  .authorized {
            openImagePickerHandler(sourceType: .camera, controller: controller)
        }else {
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted) in
                if granted {
                    self.openImagePickerHandler(sourceType: .camera, controller: controller)
                }else {
                    self.showAlert(title: "Permission Denied", message: "Please grant camera permissions in Settings to continue using this service", controller: controller)
                }
            })
        }
    }
    
    func presentImagePickerSourceActionSheet(controller: UIViewController, iPadActionsourceView:UIView = UIView()) {
        //Action Sheet Setup
        let optionMenu = UIAlertController(title: "Select Image", message: "From one of the options", preferredStyle: .actionSheet)
        if UIDevice.current.userInterfaceIdiom == .pad {
            optionMenu.popoverPresentationController?.sourceView = iPadActionsourceView
            optionMenu.popoverPresentationController?.sourceRect = CGRect(x: iPadActionsourceView.bounds.midX, y: iPadActionsourceView.bounds.midY, width: 0, height: 0)
        }
        //Adding Custom Actions
        let cameraAction = UIAlertAction(title: Constants.ButtonTitle.cameraButton, style: .default) { (_) in
            
            self.checkCameraPermission(controller: controller)
        }
        
        let galleryAction = UIAlertAction(title: Constants.ButtonTitle.photoLibraryButton, style: .default) { (_) in
            self.checkPhotoLibraryPermission(controller: controller)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        optionMenu.addAction(cameraAction)
        optionMenu.addAction(galleryAction)
        optionMenu.addAction(cancelAction)
        controller.present(optionMenu, animated: true, completion: nil)
    }
}
extension MKRImagePicker:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imageDelegate?.imageSelectionCancelled()
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            imageDelegate?.imageSelectionSuccessful(selectedImage: image)
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
}
