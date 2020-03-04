//
//  Identifiers.swift
//  BYOB
//
//  Created by manoj on 03/03/20.
//  Copyright © 2020 byob. All rights reserved.
//

import Foundation

typealias StoryboardTuple = (name: String, identifier: String)
struct Storyboard {
    
    static let login          : StoryboardTuple = ("Login",   "")
    static let signUp         : StoryboardTuple = ("Signup",  "")
    static let guide          : StoryboardTuple = ("GuideScreen",   "")
    static let changePassword : StoryboardTuple = ("ChangePassword", "")
    static let home           : StoryboardTuple = ("Home", "")
}

struct Segue {
    
}
