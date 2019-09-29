//
//  RealmDatabaseDownload.swift
//  UI-Home Application
//
//  Created by Sam Mazniker on 28/09/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

import Foundation
import RealmSwift

class RealmDatabaseDownload {
    static let instance = RealmDatabaseDownload()
    private init(){ }
    
    func friends() -> [User] {
        do {
            let realm = try Realm()
            let preloadedList = realm.objects(User.self)
            return Array(preloadedList)
        } catch {
            print(error)
        }
        return []
    }

}
