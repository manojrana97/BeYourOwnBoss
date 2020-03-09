//
//  Expenses.swift
//  BYOB
//
//  Created by manoj on 09/03/20.
//  Copyright © 2020 byob. All rights reserved.
//

import Foundation
import ObjectMapper

class Expense: NSObject, Mappable {
    
    static var shared: User?
    var name       : String?
    var category   : Category?
    var amount     : String?
    var date       : String?
    required init?(map: Map) {}
    override init() {}
    
    func mapping(map: Map) {
        name      <- map["name"]
        category  <- map["category"]
        amount    <- map["amount"]
        date      <- map["date"]
    }
    
}

class Category: NSObject, Mappable {
    
    static var shared: User?
    var name    : String?
    var id      : Int?
    
    required init?(map: Map) {}
    override init() {}
    
    func mapping(map: Map) {
        id     <- map["id"]
        name   <- map["name"]
    }
    
}
