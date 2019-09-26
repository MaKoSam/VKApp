//
//  PersonalPageModule.swift
//  UI-Home Application
//
//  Created by Sam Mazniker on 26/09/2019.
//  Copyright © 2019 Developer. All rights reserved.
//
import Foundation
import UIKit

class StartModule {
    static let instance = StartModule()
    private init() { }
    
    func getStarted(token: String?) -> Bool{
        if let AccessToken = token {
            Session.instance.app_token = AccessToken
            print(AccessToken)
            DispatchQueue.global(qos: .utility).async {
                self.ownerDownload()
                self.friendsDownload()
                self.groupsDownload()
            }
            return true //Successful Login
        } else {
            print("Error getting token from VK Server. Access_Token = nil.")
            return false //Error
        }
    }
     
    private func ownerDownload(){
        ServerTusks.instance.downloadOwnerData(){
            [weak self] downloadedOwner in
            DispatchQueue.global(qos: .background).async {
                RealmDatabaseActions.instance.saveOwner(downloadedOwner)
            }
        }
    }
    
    func friendsDownload() {
        ServerTusks.instance.downloadFriendData(){
            [weak self] friendList in
            DispatchQueue.global(qos: .background).async {
                RealmDatabaseActions.instance.saveOwnerFriends(friendList)
            }
        }
    }
    
    func groupsDownload() {
        ServerTusks.instance.downloadGroupData(){
            [weak self] groupList in
            DispatchQueue.global(qos: .background).async {
                RealmDatabaseActions.instance.saveOwnerGroups(groupList)
            }
        }
    }
    
}
