//
//  UserDefaultManager.swift
//  Tokr
//
//  Created by parvinderjit on 24/10/16.
//  Copyright © 2016 Zapbuild. All rights reserved.
//

import UIKit

public class UserDefaultManager {
	
	static let sharedManager = UserDefaultManager()
	private var userDefault:UserDefaults = UserDefaults.standard
	
    func addValue(object:Any,key:String,updateIfCan:Bool = false){
        if updateIfCan {
            userDefault.removeObject(forKey: key)
        }
        userDefault.set(object, forKey: key)
		userDefault.synchronize()
	}
	
	func objectForKey(key:String) -> Any? {
		return userDefault.object(forKey: key) as AnyObject?
	}
    
    func addBoolValue(boolObject:Bool, key:String) {
          userDefault.set(boolObject, forKey: key)
    }
    
    func getBoolValue(key:String) -> Bool {
        return userDefault.bool(forKey:key)
    }
    
	func removeValue(key:String){
		userDefault.removeObject(forKey: key)
		userDefault.synchronize()
	}
	
}
