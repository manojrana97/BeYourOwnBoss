//
//  RootScreenUtility.swift
//  BYOB
//
//  Created by manoj on 03/03/20.
//  Copyright © 2020 byob. All rights reserved.
//

import UIKit
// MARK: - Root Screen Utility
class RootScreenUtility {
    
    class func window(for view: UIView) -> UIWindow? {
        if #available(iOS 13, *) {
            return (view.window?.windowScene?.delegate as! SceneDelegate).window
        }
        else {
            return (UIApplication.shared.delegate as! AppDelegate).window
        }
    }
    
    
    class func setRootScreen(window: UIWindow?) {
        if UserDefaultManager.shared.getUser() {
            let homeStoryboard = UIStoryboard(name: Storyboard.home.name, bundle: nil).instantiateInitialViewController()

            window?.rootViewController = homeStoryboard
    }else {
            let login = UIStoryboard(name: Storyboard.login.name, bundle: nil).instantiateInitialViewController()
            window?.rootViewController = login!
        }
        
        window?.makeKeyAndVisible()
    }
}
