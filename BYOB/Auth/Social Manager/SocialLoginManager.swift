//
//  SocialLoginManager.swift
//  DayPlay
//
//  Created by zapbuild on 30/05/19.
//  Copyright © 2019 zapbuild. All rights reserved.
//

import UIKit
import GoogleSignIn
import FirebaseAuth

protocol SocialLoginDelegate: class {
    func onloginSuccess(result: Any, loginType: SocialLoginType)
    func errorInSocialLogin(error:String)
}

enum SocialLoginType{
    case facebook
    case google
}

class SocialLoginManager: NSObject{
 
    //MARK:- Variables
    weak var delegate : SocialLoginDelegate?
    private lazy var facebookLoginManger: FacebookLoginManager = {
        let facebookLoginManger = FacebookLoginManager()
        return facebookLoginManger
    }()
    private lazy var googleLoginManager: GoogleLoginManager = {
        let googleLoginManager = GoogleLoginManager()
        return googleLoginManager
    }()
    
    public override init() {
        super.init()
    }
    
    //MARK: Login
    func login(loginType: SocialLoginType, controller: UIViewController){
        switch loginType {
        case .facebook: //Facebook login
            facebookLogin(controller: controller)
        case .google: //Google login
            googleLogin(controller: controller)
        }
    }
    
    //MARK:- Private functions
    private func facebookLogin(controller: UIViewController){
        facebookLoginManger.delegate = delegate
        facebookLoginManger.loginWithFB(controller: controller, completion: {
            [weak self] (resultDict, token, error) in
            if let err = error {
                self?.delegate?.errorInSocialLogin(error: err.localizedDescription)
            }
            else {
                var imageString = ""
                if let imageURL = ((resultDict!["picture"] as? [String: Any])?["data"] as? [String: Any])?["url"] as? String {
                    let imageUrl = URL(string: imageURL)
                    imageString = imageUrl!.absoluteString
                }
                
                self?.delegate?.onloginSuccess(result: resultDict, loginType: .facebook)
            }
        })
    }
    
    private func googleLogin(controller: UIViewController){
        googleLoginManager.googleLogin(controller: controller, completion: {
            [weak self] (user, error) in
            if let err = error {
                self?.delegate?.errorInSocialLogin(error: err.localizedDescription)
            }
            else {
                let email = user?.profile.email
                let nameArray = user?.profile.name.split(separator: " ")
                let firstName = String(nameArray![0])
                var lastName = String()
                if(nameArray!.count>1){
                    lastName = String(nameArray![1])
                }
                let id =  user?.userID
                var imageString = ""
                if (user?.profile.hasImage)!{
                    // crash here !!!!!!!! cannot get imageUrl here, why?
                    let imageUrl = user?.profile.imageURL(withDimension: 600)
                    imageString = imageUrl!.absoluteString
                }
                self!.socialLogin(webServiceManager: self!.delegate!.getWebServiceManager(),
                                  email:email!, firstName: firstName, lastName: lastName, userId: id!, provider: Constants.SocialProvider.google.rawValue, image: imageString)
            }
        })
    }
    
    
}
