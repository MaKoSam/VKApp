//
//  UserClassStructure.swift
//  UI-Home Application
//
//  Created by Sam Mazniker on 08/07/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit
import ObjectMapper

class ServerUserResponse: Mappable {
    var response: [User] = []
    
    required init?(map: Map) { }
    func mapping(map: Map) {
        response <- map["response"]
    }
}

class User: Mappable{
    var id: Int = 0
//    var isOnline
    var full_name: String = ""
    var first_name: String = ""
    var last_name: String = ""
    var status: String? = ""
    var avatar_small: String? = ""
    var avatar_profile: String? = ""
    var last_seen: String = ""
    var followers_count: String = ""
    
    
    init() {
        first_name = "NOUSER"
        last_name = "NOUSER"
    }
    
    required init?(map: Map) { }
    func mapping(map: Map) {
        id <- map["id"]
        first_name <- map["first_name"]
        last_name <- map["last_name"]
        status <- map["status"]
        avatar_small <- map["photo_50"]
        avatar_profile <- map["photo_200_orig"]
        followers_count <- map["followers_count"]
    }
}
