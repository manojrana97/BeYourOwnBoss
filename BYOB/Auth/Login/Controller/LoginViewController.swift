//
//  LoginViewController.swift
//  BYOB
//
//  Created by manoj on 02/03/20.
//  Copyright © 2020 byob. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore
import ObjectMapper
class LoginViewController: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var frontView: UIView!
    
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
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        if InputValidations.checkLoginValidations(email: emailTextField.text!, password: passwordTextField.text!, presentationController: self){
            loginWebService()
        }
    }
    
    
    
    //MARK:- WebServices Methods
    private func loginWebService(){
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) {[weak self] (user, error) in
            
            if user != nil{
                let userId = Auth.auth().currentUser!.uid
                User.shared.uid = userId
                User.shared.email = Auth.auth().currentUser!.email
                self?.getUserData()
            }else{
                AlertUtility.showAlert(self, title: Constants.AlertTitle.error, message: error?.localizedDescription)            }
        }
    }
    
    private func getUserData(){
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(User.shared.uid!)
        
        docRef.getDocument { (document, error) in
            if let document = document,document.exists{
                if let dataDescription = document.data() {
                    print(dataDescription)
                    self.parseJSON(json: dataDescription)
                }
            }
        }
    }
    
    func parseJSON(json:Any){
        let loggedInUser = Mapper<User>().map(JSON: json as! [String : Any])
        User.shared.name = loggedInUser?.name ?? "-"
        User.shared.mobile = loggedInUser?.mobile ?? "NA"
        UserDefaultManager.shared.saveUser(User.shared ?? User())
        RootScreenUtility.setRootScreen(window: RootScreenUtility.window(for: self.view))
    }
}
