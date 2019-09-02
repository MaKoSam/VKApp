//
//  ImportantStructures.swift
//  UI-Home Application
//
//  Created by Developer on 22/03/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

import ObjectMapper
import Foundation

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

class FriendList { 
    var disorderedList = [User]()
    var orderedList = [String : [User]]()
    var headers = [String]()
    
    private func orderFriendList(){
        orderedList.removeAll()
        headers.removeAll()
        
        disorderedList = disorderedList.sorted { $0.full_name < $1.full_name }
        
        var currentHeader = String( disorderedList[0].full_name.uppercased().first! )
        var currentSection = [User]()
        
        for elements in disorderedList {
            if currentHeader != String( elements.full_name.uppercased().first! ) {
                orderedList.updateValue(currentSection, forKey: currentHeader)
                headers.append(currentHeader)
                currentSection.removeAll()
                currentHeader = String( elements.full_name.uppercased().first! )
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
            let noUser : User = User()
            disorderedList.append(noUser)
        } else {
            disorderedList = serverList
            self.orderFriendList()
        }
    }
}
