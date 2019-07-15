//
//  ServerSessionConnections.swift
//  UI-Home Application
//
//  Created by Sam Mazniker on 08/07/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper


class Session {
    static let instance = Session()
    private init(){ }
    var client_id = "6995401"
    
    var app_token: String?
    var user_id: Int?
}


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
    
    func downloadFriendData(completionHeandler: @escaping (FriendList) -> Void){
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
                    
                    self.downloadUsersData(user_ids){
                        [weak self] Users in
                        let downloadedFriendList = FriendList(Users)
                        completionHeandler(downloadedFriendList)
                    }
                }
        }
    }
    
    
    func downloadUsersData(_ users: String, completion: @escaping ([User]) -> Void ){
        let parameters: Parameters = [
            "user_ids": users,
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
                    completion(response.response)
                }
        }
    }
    
    
    func downloadGroupData(completionHeandler: @escaping ([Group]) -> Void){
        let parameters: Parameters = [
            "access_token": Session.instance.app_token!,
            "fields": "photo_50",
            "v": "5.101"
        ]
        NetworkSession.custom.request("https://api.vk.com/method/groups.get", parameters: parameters)
            .responseObject { (VKResponse: DataResponse<ServerGroupResponse>) in
                let result = VKResponse.result
                switch result{
                case .failure(let error):
                    print(error)
                case .success(let response):
                    completionHeandler(response.response!.items)
                }
        }
    }
}
