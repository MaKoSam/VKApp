//
//  GroupsByIdClassStructure.swift
//  UI-Home Application
//
//  Created by Sam Mazniker on 15/09/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

import ObjectMapper

class ServerGroupByIdResponse: Mappable{
    var response: [GroupById] = []
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        response <- map["response"]
    }
}

class GroupById: Mappable{
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
