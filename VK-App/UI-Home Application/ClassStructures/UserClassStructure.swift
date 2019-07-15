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
    var first_name: String = ""
    var last_name: String = ""
    var avatar: String? = ""
    
    required init?(map: Map) { }
    func mapping(map: Map) {
        id <- map["id"]
        first_name <- map["first_name"]
        last_name <- map["last_name"]
        avatar <- map["photo_50"]
    }
}
