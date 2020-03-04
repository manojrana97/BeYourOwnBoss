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
        
        // Do any additional setup after loading the view.
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
            
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                
                if user != nil{
                       let userId = Auth.auth().currentUser?.uid
                       User.shared?.uid = userId!
                       User.shared?.name = self.nameTextField.text!
                       User.shared?.mobile = self.mobileNumberTextField.text!
                       User.shared?.email = self.emailTextField.text!
                    self.db.collection("users").document(userId!).setData(["name":"\(User.shared?.name!)","mobile":"\(User.shared?.mobile!)","email":"\(User.shared?.email!)"], completion: { (error) in
                        if let _error = error{
                            AlertUtility.showAlert(self, title: Constants.AlertTitle.error, message: _error.localizedDescription)
                        }
                    })
                }
            }
        }
    }

}

