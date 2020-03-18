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
    var amount     : Int?
    var date       : String?
    required init?(map: Map) {}
    
    init(name:String,category:Category,amount:Int,date:String) {
        self.name = name
        self.category = category
        self.amount = amount
        self.date = date
    }
    
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
    var isSelected : Bool?
    var categoryImage :UIImage?
    
    required init?(map: Map) {}
    init(name:String, id:Int, image:UIImage) {
        self.name = name
        self.id = id
        self.categoryImage = image
    }
    
    func mapping(map: Map) {
        id     <- map["id"]
        name   <- map["name"]
    }
    
}
