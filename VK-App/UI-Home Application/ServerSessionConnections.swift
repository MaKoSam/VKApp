//
//  ServerSessionConnections.swift
//  UI-Home Application
//
//  Created by Sam Mazniker on 08/07/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

import RealmSwift
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
    
    func downloadFriendData(completionHeandler: @escaping () -> Void){
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
                    
                    DispatchQueue.main.async {
                        self.downloadUsersData(user_ids){
                            [weak self] in
                            completionHeandler()
                        }
                    }
                }
        }
    }
    
    
    func downloadUsersData(_ users: String, completion: @escaping () -> Void ){
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
                    self.saveFriendsData(response.response)
                    completion()
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
                    DispatchQueue.main.async {
                        completionHeandler(response.response!.items)
                    }
                }
        }
    }
    
    func saveFriendsData(_ users: [User]){
        do {
            let realm = try Realm()
            let oldData = realm.objects(User.self)
            realm.beginWrite()
            realm.delete(oldData)
            realm.add(users)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
}
