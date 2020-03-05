//
//  User.swift
//  CP67
//
//  Created by apple on 24/09/19.
//  Copyright © 2019 zapbuild. All rights reserved.
//

import Foundation
import UIKit
class User: NSObject,DataModel, NSCoding {
    static var shared: User?
    var name         : String?
    var email        : String?
    var mobile       : String?
    var uid          : String?
    var userImage    : String?
    
    override init() {}
    
    required init(coder decoder: NSCoder) {
        self.uid = decoder.decodeObject(forKey: "uid") as? String ?? ""
        self.name = decoder.decodeObject(forKey: "name") as? String ?? ""
        self.email = decoder.decodeObject(forKey: "email") as? String ?? ""
        self.mobile = decoder.decodeObject(forKey: "mobile") as? String ?? ""
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(uid, forKey: "uid")
        coder.encode(name, forKey: "name")
        coder.encode(email, forKey: "email")
        coder.encode(mobile, forKey: "mobile")
    }
    
    func logout(view: UIView) {
        UserDefaultManager.shared.resetUser()
        RootScreenUtility.setRootScreen(window: RootScreenUtility.window(for: view))
    }
    
}


protocol DataModel{}
extension String:DataModel {}
extension Int:DataModel {}
extension Array:DataModel{}
extension Dictionary:DataModel{}

extension DataModel
{
    var toString:String?{
        return self as? String
    }
    var toArray:Array<Any>?{
        return self as? Array
    }
    
    var toDictionary:Dictionary<String, Any>?{
        return self as? Dictionary<String, Any>
    }
}
