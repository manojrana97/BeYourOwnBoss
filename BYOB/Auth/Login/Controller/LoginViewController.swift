//
//  LoginViewController.swift
//  BYOB
//
//  Created by manoj on 02/03/20.
//  Copyright © 2020 byob. All rights reserved.
//

import UIKit

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
    }
    
    @IBAction func signupButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
