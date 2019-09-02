//
//  RealmDataBaseStructure.swift AKA OWNER CLASS STRUCTURE
//  UI-Home Application
//
//  Created by Sam Mazniker on 26/07/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

//OWNER STRUCTURE FOR REALM

import ObjectMapper
import RealmSwift



class ServerOwnerResponse: Mappable {
    var response = Owner()
    
    required init?(map: Map) { }
    func mapping(map: Map) {
        response <- map["response"]
    }
}


class Owner: Object, Mappable {
    @objc dynamic var full_name: String = ""
    @objc dynamic var first_name: String = ""
    @objc dynamic var last_name: String = ""
    @objc dynamic var sex: Int = 0
    @objc dynamic var bdate: String = ""
    @objc dynamic var bdate_visibility: Int = 0
    @objc dynamic var home_town: String? = nil
    @objc dynamic var status: String? = nil
    @objc dynamic var phone: String? = nil
        
    let friends = List<User>()
    let communities = List<Group>()
    
    
    
    required convenience init(map: Map) {
        self.init()
        self.mapping(map: map)
    }
    
    func mapping(map: Map) {
        first_name <- map["first_name"]
        last_name <- map["last_name"]
        sex <- map["sex"]
        bdate <- map["bdate"]
        bdate_visibility <- map["bdate_visibility"]
        home_town <- map["home_town"]
        status <- map["status"]
        phone <- map["phone"]
        
        full_name = "\(first_name.lowercased()) \(last_name.lowercased())"
    }
}
