//
//  GoogleLoginManager.swift
//  DayPlay
//
//  Created by zapbuild on 30/05/19.
//  Copyright © 2019 zapbuild. All rights reserved.
//

import Foundation
import FirebaseAuth

class GoogleLoginManager : NSObject,GIDSignInDelegate,GIDSignInUIDelegate{
 
    typealias googleLoginResponse = (GIDGoogleUser?, Error?) -> ()
    private var responseCallback: googleLoginResponse?
    
    public override init() {
        super.init()
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.uiDelegate = self 
    }
    
    func googleLogin(controller:UIViewController, completion: @escaping googleLoginResponse) {
        responseCallback = completion
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            Logger.log(error)
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,accessToken: authentication.accessToken)
        
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                Logger.log(error)
                self.responseCallback?(nil, error)
                return
            } else if let user = user {
                // Perform any operations on signed in user here.
                self.responseCallback?(user, nil)
            }
            
        }
    }
    
    
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
//        self.dismiss(animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
//        self.present(viewController, animated: true, completion: nil)
         // GIDSignIn.sharedInstance()?.presentingViewController = self
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        
    }
}

