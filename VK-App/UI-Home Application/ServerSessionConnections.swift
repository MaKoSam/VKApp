//
//  ServerSessionConnections.swift
//  UI-Home Application
//
//  Created by Sam Mazniker on 08/07/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

class Session {
    static let instance = Session()
    private init(){ }
    var client_id = "6995401"
    
    var app_token: String?
    var user_id: Int?
}


private final class NetworkSession {
    static let custom: Alamofire.Session = {
        let configuration = URLSessionConfiguration.default
        let sessionManager = Alamofire.Session(configuration: configuration)
        return sessionManager
    }()
}


final class ServerTusks {
    static let instance = ServerTusks()
    private init(){ }
    
    func downloadOwnerData(completionHeandler: @escaping (Owner) -> Void ){
        let parameters: Parameters = [
            "access_token": Session.instance.app_token!,
            "v": "5.101"
        ]
        NetworkSession.custom.request("https://api.vk.com/method/account.getProfileInfo", parameters: parameters)
            .responseObject { (VKResponse: DataResponse<ServerOwnerResponse>) in
                let result = VKResponse.result
                switch result{
                case .failure(let error):
                    print(error)
                case .success(let response):
                    DispatchQueue.main.async {
                        completionHeandler(response.response)
                    }
                }
        }
    }
    
    func downloadFriendData(completionHeandler: @escaping ([User]) -> Void){
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
                        [weak self] friendList in
                        DispatchQueue.main.async {
                            completionHeandler(friendList)
                        }
                    }
                }
        }
    }
    
    func downloadUsersData(_ users: String, completion: @escaping ([User]) -> Void ){
        let parameters: Parameters = [
            "user_ids": users,
            "fields": "status,photo_50,photo_200_orig",
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
                    DispatchQueue.main.async {
                        completion(response.response)
                    }
                }
        }
    }
    
    func downloadGroupData(completionHeandler: @escaping ([Group]) -> Void){
        let parameters: Parameters = [
            "access_token": Session.instance.app_token!,
            "extended": "1",
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
                    DispatchQueue.main.async {
                        completionHeandler(response.response!.items)
                    }
                }
        }
    }
    
    func downloadGroupById(_ ids: String, completionHeandler: @escaping ([GroupById]) -> Void){
        let parameters: Parameters = [
            "access_token": Session.instance.app_token!,
            "group_id" : ids,
            "v": "5.101"
        ]
        NetworkSession.custom.request("https://api.vk.com/method/groups.getById", parameters: parameters)
            .responseObject { (VKResponse: DataResponse<ServerGroupByIdResponse>) in
                let result = VKResponse.result
                switch result{
                case .failure(let error):
                    print(error)
                case .success(let response):
                    DispatchQueue.main.async {
                        completionHeandler(response.response)
                    }
                }
        }
    }
    
    func downloadNewsFeed(completionHeandler: @escaping ([NewsFeedPost]) -> Void){
        let parameters: Parameters = [
            "access_token": Session.instance.app_token!,
            "filters": "post",
            "source_ids": "friends,groups",
            "count": "10",
            "v": "5.101"
        ]
        NetworkSession.custom.request("https://api.vk.com/method/newsfeed.get", parameters: parameters)
            .responseObject { (VKResponse: DataResponse<ServerNewsFeedResponse>) in
                let result = VKResponse.result
                switch result{
                case .failure(let error):
                    print(error)
                case .success(let response):
                    DispatchQueue.main.async {
                        completionHeandler(response.response!.items)
                    }
                }
        }
    }
    
}
