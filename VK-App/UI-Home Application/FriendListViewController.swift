//
//  FriendListViewController.swift
//  UI-Home Application
//
//  Created by Sam Mazniker on 3/10/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit

class FriendListViewController: UIViewController {
    var friends: FriendList? = nil
    
    @IBOutlet weak var FriendTable: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        FriendTable.dataSource = self
        ServerTusks.instance.downloadFriendData(){
            [weak self] downloadedData in
            self!.friends = downloadedData
        }
        
//        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for Friends"
        navigationItem.searchController = searchController
        definesPresentationContext = true
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
        return friends!.headers.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return friends!.headers[section]
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends!.orderedList[ friends!.headers[section] ]!.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newCell = FriendTable.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as! FriendTableViewCell

        var currentSection = friends!.orderedList[friends!.headers[indexPath.section]]!
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
