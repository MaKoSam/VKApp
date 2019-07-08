//
//  ServerSessionConnections.swift
//  UI-Home Application
//
//  Created by Sam Mazniker on 08/07/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireObjectMapper


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
    
    func downloadFriendList(completion: (FriendList) -> Void){
        let parameters: Parameters = [
            "access_token": Session.instance.app_token!,
            "v": "5.101"
        ]
        NetworkSession.custom.request("https://api.vk.com/method/friends.get", parameters: parameters)
            .responseObject { (VKResponse: DataResponse<ServerFriendResponse>) in
                let result = VKResponse.result
                switch result{
                case .failure(let error):
                    print(error)
                case .success(let response):
                    var user_ids: String = ""
                    for elements in response.response!.items { user_ids += "\(elements)," }
                    print(user_ids)
                    self.downloadUsersData(for: user_ids)
                }
        }
    }
    
    
    func downloadUsersData(for users: String, completion: ([User]) -> Void ){
        let parameters: Parameters = [
            "users_ids": users,
            "fields": "photo_50",
            "access_token": Session.instance.app_token!,
            "v": "5.101"
        ]
        NetworkSession.custom.request("https://api.vk.com/method/users.get", parameters: parameters)
            .responseObject { (VKResponse: DataResponse<ServerUserResponse>) in
                let result = VKResponse.result
                switch result{
                case .failure(let error):
                    print(error)
                case .success(let response):
                    return response.response
                }
        }
    }
    
    
}
