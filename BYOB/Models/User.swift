//
//  User.swift
//  CP67
//
//  Created by apple on 24/09/19.
//  Copyright © 2019 zapbuild. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper
class User: NSObject,DataModel, NSCoding, Mappable {
    
    static var shared: User = User()
    var name                 : String?
    var email                : String?
    var mobile               : String?
    var uid                  : String!
    var userImage            : String?
    var expenseDataBaseSetup :Bool? = false
    
    static var categoriesAvailable :[Category] = [Category(name: "Entertainment", id: 0,image: #imageLiteral(resourceName: "Entertainment")),Category(name: "Food", id: 1, image: #imageLiteral(resourceName: "Food")), Category(name: "Utility Bills", id: 2,image: #imageLiteral(resourceName: "Utility Bills")), Category(name: "Travel", id: 3,image: #imageLiteral(resourceName: "Travel")), Category(name: "Shopping", id: 4, image: #imageLiteral(resourceName: "Shopping")), Category(name: "Health and Wellness", id: 5, image: #imageLiteral(resourceName: "Health and Wellness")), Category(name: "Charity", id: 6, image: #imageLiteral(resourceName: "Charity")), Category(name: "Savings", id: 7,image: #imageLiteral(resourceName: "Savings"))]
    
    required init?(map: Map) {}
    override init() {}
    
    func mapping(map: Map) {
        uid                   <- map["uid"]
        name                  <- map["name"]
        email                 <- map["email"]
        mobile                <- map["mobile"]
        expenseDataBaseSetup  <- map["isExpenseSeted"]
        //expenses   <- map["expenses"]
    }
    

    
    
    
    required init(coder decoder: NSCoder) {
        self.uid = decoder.decodeObject(forKey: "uid") as? String ?? ""
        self.name = decoder.decodeObject(forKey: "name") as? String ?? ""
        self.email = decoder.decodeObject(forKey: "email") as? String ?? ""
        self.mobile = decoder.decodeObject(forKey: "mobile") as? String ?? ""
        self.expenseDataBaseSetup = decoder.decodeObject(forKey: "isExpenseSeted") as? Bool ?? false
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(uid, forKey: "uid")
        coder.encode(name, forKey: "name")
        coder.encode(email, forKey: "email")
        coder.encode(mobile, forKey: "mobile")
        coder.encode(expenseDataBaseSetup, forKey: "isExpenseSeted")
        
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
