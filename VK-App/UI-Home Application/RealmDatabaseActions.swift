//
//  RealmDatabaseActions.swift
//  UI-Home Application
//
//  Created by Sam Mazniker on 10/09/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

import RealmSwift

class RealmDatabaseActions {
    static let instance = RealmDatabaseActions()
    private init(){ }
    
    func saveOwner(_ user: Owner){
        do {
            let realm = try Realm()
            print(realm.configuration.fileURL)
            let oldOwner = realm.objects(Owner.self)
            realm.beginWrite()
            realm.delete(oldOwner)
            realm.add(user)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
    func saveOwnerFriends(_ friendList: [User]){
        do {
            let realm = try Realm()
            let owner = realm.objects(Owner.self)
            if let user = Array(owner).first {
                let oldFriends = realm.objects(User.self)
                realm.beginWrite()
                realm.delete(oldFriends)
                try realm.commitWrite()
                
                try realm.write {
                    for elements in friendList {
                        user.friends.append(elements)
                    }
                }
            }
        } catch {
            print(error)
        }
    }
    
    func saveOwnerGroups(_ groupList: [Group]){
        do {
            let realm = try Realm()
            let owner = realm.objects(Owner.self)
            if let user = Array(owner).first {
                let oldGroups = realm.objects(Group.self)
                realm.beginWrite()
                realm.delete(oldGroups)
                try realm.commitWrite()
                
                try realm.write {
                    for elements in groupList {
                        user.communities.append(elements)
                    }
                }
            }
        } catch {
            print(error)
        }
    }
    

}
