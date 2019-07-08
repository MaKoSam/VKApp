//
//  ImportantStructures.swift
//  UI-Home Application
//
//  Created by Developer on 22/03/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit

struct User {
    var first_name : String?
    var last_name : String
    var photo : UIImage?
}

class Session {
    static let instance = Session()
    private init(){ }
    var client_id = "6995401"
    
    var app_token: String?
    var user_id: Int?
}

class FriendList {
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
