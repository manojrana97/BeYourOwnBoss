//
//  SignUpViewController.swift
//  BYOB
//
//  Created by apple on 20/02/20.
//  Copyright © 2020 byob. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore
class SignUpViewController: UIViewController {
    //MARK:- IBOutlets
    @IBOutlet weak var nameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var mobileNumberTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var frontView: UIView!
    
    
    //MARK:- Variables
    let db = Firestore.firestore()
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        self.frontView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    //MARK:- IBActions
    @IBAction func passwordShowHideTapped(_ sender: UIButton) {
        CommonUtilities.showHidePasswordCharacters(textField: passwordTextField, button: sender)
    }
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        if InputValidations.checkSignupValidations(name: nameTextField.text ?? "", email: emailTextField.text ?? "", mobileNumber: mobileNumberTextField.text ?? "", password: passwordTextField.text ?? "", presentationController: self) {
            signupWebservice()
        }
    }
    
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func signupWebservice(){
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { [weak self] (user, error) in
            
            if user != nil{
                let userId = Auth.auth().currentUser?.uid
                User.shared?.uid = userId!
                User.shared?.name = self?.nameTextField.text!
                User.shared?.mobile = self?.mobileNumberTextField.text!
                User.shared?.email = self?.emailTextField.text!
                self?.setNewUserDataBase(userId: userId!)
            }
        }
    }
    
    private func setNewUserDataBase(userId:String){
        self.db.collection("users").document(userId).setData(["name":self.nameTextField.text!,"mobile":self.mobileNumberTextField.text!], completion: { (error) in
            if let _error = error{
                AlertUtility.showAlert(self, title: Constants.AlertTitle.error, message: _error.localizedDescription)
            }else{
                UserDefaultManager.shared.saveUser(User.shared ?? User())
                RootScreenUtility.setRootScreen(window: RootScreenUtility.window(for: self.view))
            }
        })
        
    }
    
    
}

