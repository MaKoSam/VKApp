//
//  RealmDatabaseActions.swift
//  UI-Home Application
//
//  Created by Sam Mazniker on 10/09/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

import RealmSwift

class RealmDatabaseUpload {
    static let instance = RealmDatabaseUpload()
    private init(){ }
    
    func saveOwner(_ user: Owner){
        do {
            let realm = try Realm()
            print(realm.configuration.fileURL)
            let oldOwner = realm.objects(Owner.self)
            if let exictingOwner = Array(oldOwner).first{
                if !self.equalOwner(user, exictingOwner) {
                    try realm.write {
                        exictingOwner.first_name = user.first_name
                        exictingOwner.last_name = user.last_name
                        exictingOwner.full_name = user.full_name
                        exictingOwner.home_town = user.home_town
                        exictingOwner.phone = user.phone
                        exictingOwner.bdate = user.bdate
                        exictingOwner.sex = user.sex
                        exictingOwner.status = user.status
                        exictingOwner.bdate_visibility = user.bdate_visibility
                    }
                }
            } else {
                realm.beginWrite()
                realm.add(user)
                try realm.commitWrite()
            }
        } catch {
            print(error)
        }
    }
    
    func saveOwnerFriends(_ friendList: [User]){
        do {
            let realm = try Realm()
            let owner = realm.objects(Owner.self)
            
            if let user = Array(owner).first {
                for elements in friendList {
                    let search = realm.objects(User.self).filter("id == %@", elements.id)
                    if let found = Array(search).first {
                        if !self.equalFriends(found, elements){
                            
                            print("editing ", found)
                            
                            try realm.write {
                                found.first_name = elements.first_name
                                found.last_name = elements.last_name
                                found.full_name = elements.full_name
                                found.avatar_profile = elements.avatar_profile
                                found.avatar_small = elements.avatar_small
                                found.status = elements.status
                            }
                        }
                    } else {
                        try realm.write {
                            user.friends.append(elements)
                        }
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
                for elements in groupList {
                    let search = realm.objects(Group.self).filter("id == %@", elements.id)
                    if let found = Array(search).first {
                        if !self.equalGroups(found, elements) {
                            try realm.write {
                                found.name = elements.name
                                found.avatar = elements.avatar
                            }
                        }
                    } else {
                        try realm.write {
                            user.communities.append(elements)
                        }
                    }
                }
            }
        } catch {
            print(error)
        }
    }
    
    func equalOwner(_ first: Owner, _ second: Owner) -> Bool{
        if first.first_name == second.first_name {
            if first.last_name == second.last_name {
                if first.bdate == second.bdate {
                    return true
                }
            }
        }
        return false
    }
    
    func equalFriends(_ first: User, _ second: User) -> Bool{
        if first.full_name == second.full_name{
            if first.id == second.id{
                if first.status == second.status{
                    if first.avatar_small == second.avatar_small{
                        if first.avatar_profile == second.avatar_profile{
                            return true
                        }
                    }
                }
            }
        }
        return false
    }
    
    func equalGroups(_ first: Group, _ second: Group) -> Bool{
        if first.id == second.id {
            if first.name == second.name {
                if first.avatar == second.avatar {
                    return true
                }
            }
        }
        return false
    }
    
    
}

