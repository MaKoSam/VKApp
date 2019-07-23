//
//  FriendListViewController.swift
//  UI-Home Application
//
//  Created by Sam Mazniker on 3/10/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit
import RealmSwift

class FriendListViewController: UIViewController {
    var myFriends: FriendList? = FriendList([])
    var myFiltered: FriendList? = FriendList([])
    
    @IBOutlet weak var FriendTable: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    
    func loadDataFromDataBase(){
        do {
            let realm = try Realm()
            print(realm.configuration.fileURL)
            let preloadedList = realm.objects(User.self)
            let arrayList = Array(preloadedList)
            self.myFriends = FriendList(arrayList)
        } catch {
            print(error)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadDataFromDataBase()
        
        FriendTable.dataSource = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for Friends"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}

extension FriendListViewController : UISearchResultsUpdating {
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }

    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }

    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        do {
            let realm = try Realm()
            let filteredList = realm.objects(User.self).filter("full_name contains %@", searchText.lowercased())
            let arrayList = Array(filteredList)
            myFiltered = FriendList(arrayList)
        } catch {
            print(error)
        }
        
        FriendTable.reloadData()
    }

    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}




extension FriendListViewController : UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        if isFiltering() {
            if myFiltered != nil {
                return myFiltered!.headers.count
            } else {
                return 0
            }
        } else {
            if myFriends != nil {
                return myFriends!.headers.count
            } else {
                return 0
            }
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if isFiltering() {
            if myFiltered != nil {
                return myFiltered!.headers[section]
            } else {
                return nil
            }
        } else {
            if myFriends != nil {
                return myFriends!.headers[section]
            } else {
                return nil
            }
        }
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            if myFiltered != nil {
                return myFiltered!.orderedList[ myFiltered!.headers[section] ]!.count
            } else {
                return 0
            }
        } else {
            if myFriends != nil {
                return myFriends!.orderedList[ myFriends!.headers[section] ]!.count
            } else {
                return 0
            }
        }
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newCell = FriendTable.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as! FriendTableViewCell
        var currentSection = myFriends!.orderedList[myFriends!.headers[indexPath.section]]!
        
        if isFiltering() {
            currentSection = myFiltered!.orderedList[myFiltered!.headers[indexPath.section]]!
        }
        
        newCell.friendName.text = currentSection[indexPath.row].first_name
        newCell.friendName.textAlignment = .right
        newCell.friendLastName.text = currentSection[indexPath.row].last_name
        
        if currentSection[indexPath.row].avatar_small != nil {
            newCell.imageURL = currentSection[indexPath.row].avatar_small!
        }
        return newCell
    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "toPerson"{
//            let indexPath = self.FriendTable.indexPathForSelectedRow!
//            let currentSection = friends.publicUserData[friends.tableLitterals[indexPath.section]]!
//            if let destination : PersonalPageViewController! = segue.destination as! PersonalPageViewController {
//                destination?.personData = currentSection[indexPath.row]
//            }
//        }
//    }

}
