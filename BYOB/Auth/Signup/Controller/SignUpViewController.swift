//
//  SignUpViewController.swift
//  BYOB
//
//  Created by apple on 20/02/20.
//  Copyright © 2020 byob. All rights reserved.
//

import UIKit
import Photos
class SignUpViewController: UIViewController {
    //MARK:- IBOutlets
    @IBOutlet weak private var profileImageView:UIImageView!
    @IBOutlet weak var frontView: UIView!
    
    //MARK:- Variables
    private lazy var imagePicker: MKRImagePicker = {
        let imagePicker = MKRImagePicker()
        imagePicker.sourceType = [.camera,.photoLibrary]
        imagePicker.imageDelegate = self
        return imagePicker
    }()
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        self.frontView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    //MARK:- IBActions
    @IBAction func addImageButtonTapped(_ sender: UIButton) {
        
    }

}


//MARK:- ImagePicker Delegate
extension SignUpViewController:MKRImagePickerDelegate{
    func imageSelectionSuccessful(selectedImage: UIImage) {
        profileImageView.image = selectedImage
    }
    
    func imageSelectionCancelled() {
    }
    
    
}
