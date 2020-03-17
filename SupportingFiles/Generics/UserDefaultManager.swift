//
//  UserDefaultManager.swift
//  Tokr
//
//  Created by parvinderjit on 24/10/16.
//  Copyright © 2016 Zapbuild. All rights reserved.
//

import UIKit

public class UserDefaultManager {
    
    static let shared = UserDefaultManager()
    private init(){}
    
    private var userDefault:UserDefaults = UserDefaults.standard
    
    private struct Keys {
        let guideScreenShown    : String = "guideScreenShown"
        let loggedInUser        : String = "loggedInUser"
    }
    private let keys = Keys()
    
    // MARK: Generic Functions
    func saveValue(object:Any,key:String) {
        userDefault.set(object, forKey: key)
        userDefault.synchronize()
    }
    
    func objectForKey(key:String) -> Any? {
        return userDefault.object(forKey: key) as Any?
    }
    
    func removeValue(key:String) {
        userDefault.removeObject(forKey: key)
        userDefault.synchronize()
    }
    
    func saveBoolValue(boolObject:Bool, key:String) {
        userDefault.set(boolObject, forKey: key)
    }
    
    func getBoolValue(key:String) -> Bool {
        return userDefault.bool(forKey:key)
    }
    
    // MARK: Utilty Functions
    func saveUser(_ user: User) {
        if let data = try? NSKeyedArchiver.archivedData(withRootObject: user, requiringSecureCoding: false) {
            saveValue(object: data, key: keys.loggedInUser)
            userDefault.synchronize()
        }
        User.shared = user
    }
    
    @discardableResult func getUser() -> Bool {
        if let data = objectForKey(key: keys.loggedInUser) as? Data ,
            let user = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? User {
            User.shared = user
            return true
        }
        return false
    }
    
    func resetUser() {
        User.shared = User()
        removeValue(key: keys.loggedInUser)
    }
    
    func showGuideScreen() -> Bool {
        if getBoolValue(key: keys.guideScreenShown) == false {
            return true
        }
        return false
    }
    
    func setGuideScreen(_ value: Bool) {
        saveBoolValue(boolObject: value, key: keys.guideScreenShown)
    }
    
}

