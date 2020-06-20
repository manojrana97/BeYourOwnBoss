//
//  FacebookLoginManager.swift
//  DayPlay
//
//  Created by zapbuild on 30/05/19.
//  Copyright © 2019 zapbuild. All rights reserved.
//

import Foundation
import FBSDKLoginKit
import GoogleSignIn

class FacebookLoginManager: NSObject{

    
    
    //MARK:- Variables
    var delegate : SocialLoginDelegate?
    typealias fbLoginResponse = ([String: Any]?, String?, Error?) -> ()
    
    func loginWithFB(controller:UIViewController, completion: @escaping fbLoginResponse) {
        let login = LoginManager()
        login.logOut()

        login.logIn(permissions: ["public_profile", "email"], from: controller, handler: {(result, error) in
            if error != nil {
                completion(nil, nil, error)
                self.delegate?.errorInSocialLogin(error: error!.localizedDescription)
            }
            else if (result?.isCancelled)! {
                Logger.log("gncghfghf")
                // if the facebook popup actioned with cancel button
            }
            else {
                let token = result?.token!.tokenString
                GraphRequest(graphPath: "me", parameters: ["fields": "first_name, last_name, email, name, id, picture.width(2000).height(2000)"]).start(completionHandler: {(connection, result, error) -> Void in
                    if error != nil{
                        completion(nil, nil, error)
                    }else{
                        guard let resultDictionary = result as? [String:Any] else {
                            fatalError("result is not a dictionary")
                        }
                        completion(resultDictionary, token, nil)
                    }
                })
            }
        })
    }
}
