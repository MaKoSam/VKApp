//
//  UserClassStructure.swift
//  UI-Home Application
//
//  Created by Sam Mazniker on 08/07/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift


class ServerUserResponse: Mappable {
    var response: [User] = []
    
    required init?(map: Map) { }
    func mapping(map: Map) {
        response <- map["response"]
    }
}

class User: Object, Mappable{
    @objc dynamic var id: Int = 0
    @objc dynamic var full_name: String = ""
    @objc dynamic var first_name: String = ""
    @objc dynamic var last_name: String = ""
    @objc dynamic var status: String? = nil
    @objc dynamic var avatar_small: String? = nil
    @objc dynamic var avatar_profile: String? = nil
    
    
    required convenience init(map: Map) {
        self.init()
        self.mapping(map: map)
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        first_name <- map["first_name"]
        last_name <- map["last_name"]
        status <- map["status"]
        avatar_small <- map["photo_50"]
        avatar_profile <- map["photo_200_orig"]
        full_name = "\(last_name.lowercased()) \(first_name.lowercased())"
    }

}
