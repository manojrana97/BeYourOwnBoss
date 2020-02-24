//
//  User.swift
//  CP67
//
//  Created by apple on 24/09/19.
//  Copyright © 2019 zapbuild. All rights reserved.
//

import Foundation
import ObjectMapper
import SwiftyJSON
class User: NSObject {
    
    override init() {}
    required init?(map: Map) {}
    var name           : String?
    var email          : String?
    var phone          : String?
    var token          : String?
    var userId         : Int?
    var previousLeads  : String?
    var upcomingLeads  : String?
    var todayLeads     : String?
    var totalLeads     : String?
    var firstName      : String?
    var lastName       : String?
    var userImage      : String?
    var firstTimeLogin : String?
    var rewards        : Int?
    
    func mapping(map: Map) {
        name            <- map["name"]
        email           <- map["email"]
        phone           <- map["phone"]
        token           <- map["token"]
        userId          <- map["user_id"]
        previousLeads   <- map["previous_leads"]
        upcomingLeads   <- map["upcoming_leads"]
        todayLeads      <- map["today_leads"]
        totalLeads      <- map["total_leads"]
        firstName       <- map["first_name"]
        lastName        <- map["last_name"]
        userImage       <- map["image"]
        firstTimeLogin  <- map["first_time_login"]
        rewards         <- map["rewards"]
    }
    
}

