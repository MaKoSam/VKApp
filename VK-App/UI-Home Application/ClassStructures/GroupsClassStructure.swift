//
//  GroupsClassStructure.swift
//  UI-Home Application
//
//  Created by Sam Mazniker on 08/07/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit
import ObjectMapper


class ServerGroupResponse: Mappable{
    var response: GroupsResonseInternal? = nil
    
    required init?(map: Map) { }
    func mapping(map: Map) {
        response <- map["response"]
    }
}

class GroupsResonseInternal: Mappable{
    var count: Int = 0
    var items: [Group] = []
    
    required init?(map: Map) { }
    func mapping(map: Map) {
        count <- map["count"]
        items <- map["items"]
    }
}

class Group: Mappable{
    var id: Int = 0
    var name: String = ""
    var avatar: String = ""
    
    required init?(map: Map) { }
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        avatar <- map["photo_50"]
    }
}
