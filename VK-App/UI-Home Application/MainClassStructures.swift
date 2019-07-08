//
//  ImportantStructures.swift
//  UI-Home Application
//
//  Created by Developer on 22/03/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit
import ObjectMapper

class Session {
    static let instance = Session()
    private init(){ }
    var client_id = "6995401"
    
    var app_token: String?
    var user_id: Int?
}

class FriendList {
    static var instance = FriendList()
    private init(){ }
    
    var disorderedList = [User]()
    var orderedList = [String : [User]]()
    var headers = [String]()
    
    private func orderFriendList(){
        orderedList.removeAll()
        headers.removeAll()
        disorderedList = disorderedList.sorted { $0.last_name < $1.last_name }
        
        var currentHeader = String( disorderedList[0].last_name.uppercased().first! )
        var currentSection = [User]()
        headers.append(currentHeader)
        
        for elements in disorderedList {
            if currentHeader != String( elements.last_name.uppercased().first! ) {
                orderedList.updateValue(currentSection, forKey: currentHeader)
                headers.append(currentHeader)
                currentSection.removeAll()
                currentHeader = String( elements.last_name.uppercased().first! )
            }
            currentSection.append(elements)
        }
        
        if !currentSection.isEmpty {
            headers.append(currentHeader)
            orderedList.updateValue(currentSection, forKey: currentHeader)
        }
    }
        
    func updateList(){
        self.orderFriendList()
    }

    init(_ serverList: [User]){
        if serverList.isEmpty {
            print("Error downloading frineds list from server.")
        } else {
            disorderedList = serverList
            self.orderFriendList()
        }
    }
}



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


class ServerFriendResponse: Mappable{
    var response: FriendResonseInternal? = nil
    
    required init?(map: Map) { }
    func mapping(map: Map) {
        response <- map["response"]
    }
}

class FriendResonseInternal: Mappable {
    var count: Int = 0
    var items: [Int] = []
    
    required init?(map: Map) { }
    func mapping(map: Map) {
        count <- map["count"]
        items <- map["items"]
    }
}
