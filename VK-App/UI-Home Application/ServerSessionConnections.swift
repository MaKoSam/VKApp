//
//  ServerSessionConnections.swift
//  UI-Home Application
//
//  Created by Sam Mazniker on 08/07/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit
import Alamofire


private class NetworkSession {
    static let custom: Alamofire.Session = {
        let configuration = URLSessionConfiguration.default
        let sessionManager = Alamofire.Session(configuration: configuration)
        return sessionManager
    }()
}

class ServerTusks {
    static let instance = ServerTusks()
    private init(){ }
    
    func downloadFriendList(){
        let parameters: Parameters = [
            "access_token": Session.instance.app_token!,
            "v": "5.101"
        ]
        NetworkSession.custom.request("https://api.vk.com/method/friends.get", parameters: parameters).responseJSON {
            response in
            print(response.value)
        }
    }
    
    func downloadUserData(){
        let parameters: Parameters = [
            "fields": "status,city,photo_50",
            "access_token": Session.instance.app_token!,
            "v": "5.101"
        ]
        NetworkSession.custom.request("https://api.vk.com/method/users.get", parameters: parameters).responseJSON {
            response in
            print(response.value)
        }
    }
    
    
}
