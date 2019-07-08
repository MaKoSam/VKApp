//
//  FriendListViewController.swift
//  UI-Home Application
//
//  Created by Sam Mazniker on 3/10/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit
import Alamofire

class FriendListViewController: UIViewController {
    
    @IBOutlet weak var FriendTable: UITableView!
    
//    let searchController = UISearchController(searchResultsController: nil)
//    var filteredFriends = FriendData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       ServerTusks.instance.downloadFriendList()
        
        FriendTable.dataSource = self
        
//        filteredFriends.nilData()
//        // Setup the Search Controller
//        searchController.searchResultsUpdater = self
//        searchController.obscuresBackgroundDuringPresentation = false
//        searchController.searchBar.placeholder = "Search for Friends"
//        navigationItem.searchController = searchController
//        definesPresentationContext = true
    }
}

//extension FriendListViewController : UISearchResultsUpdating {
//
//    func isFiltering() -> Bool {
//        return searchController.isActive && !searchBarIsEmpty()
//    }
//
//    func searchBarIsEmpty() -> Bool {
//        return searchController.searchBar.text?.isEmpty ?? true
//    }
//
//    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
//
//        filteredFriends.privateUserData.removeAll()
//
//        for elements in friends.privateUserData {
//            if elements.name.lowercased().contains(searchText.lowercased()) {
//                filteredFriends.privateUserData.append(elements)
//            }
//        }
//
//        for elements in filteredFriends.privateUserData {
//            print(elements.name, "\n")
//        }
//
//        print("---")
//
//        filteredFriends.updataPublicData()
//        FriendTable.reloadData()
//    }
//
//    func updateSearchResults(for searchController: UISearchController) {
//        filterContentForSearchText(searchController.searchBar.text!)
//    }
//}




extension FriendListViewController : UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
//        if isFiltering() {
//            return filteredFriends.tableLitterals.count
//        }
        return FriendList.instance.headers.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if isFiltering() {
//            return filteredFriends.tableLitterals[section]
//        }
        return FriendList.instance.headers[section]
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if isFiltering() {
//            return filteredFriends.publicUserData[filteredFriends.tableLitterals[section]]!.count
//        }
        return FriendList.instance.orderedList[ FriendList.instance.headers[section] ]!.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newCell = FriendTable.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as! FriendTableViewCell

        var currentSection = FriendList.instance.orderedList[FriendList.instance.headers[indexPath.section]]!

//        if isFiltering() {
//            currentSection = filteredFriends.publicUserData[filteredFriends.tableLitterals[indexPath.section]]!
//        }

        newCell.friendName.text = currentSection[indexPath.row].last_name
//        newCell.friendPhotoContentView.image = currentSection[indexPath.row].photo
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
