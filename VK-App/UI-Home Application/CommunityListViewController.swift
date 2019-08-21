//
//  CommunityListViewController.swift
//  UI-Home Application
//
//  Created by Sam Mazniker on 3/11/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit
import RealmSwift

class CommunityListViewController: UIViewController {
    
    @IBOutlet weak var CommunityTable: UITableView!
    var myGroups : [Group] = []
    var myFiltered : [Group] = []
    
    func loadDataFromDataBase(){
        do {
            let realm = try Realm()
            let preloadedList = realm.objects(Group.self)
            myGroups = Array(preloadedList)
        } catch {
            print(error)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDataFromDataBase()
        CommunityTable.dataSource = self
        
        
    }
}


extension CommunityListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newCell = CommunityTable.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! CommunityTableViewCell
        newCell.CommunityName.text = myGroups[indexPath.row].name
        return newCell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            myGroups.remove(at: indexPath.row)
            self.CommunityTable.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}
