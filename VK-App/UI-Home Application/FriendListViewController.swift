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
            let preloadedList = realm.objects(User.self)
            var arrayList = Array(preloadedList)
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
        searchController.searchBar.placeholder = "Search for a friend"
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
            guard let activeHeaders = myFiltered?.headers else {
                return 0
            }
            return activeHeaders.count
        } else {
            guard let activeHeaders = myFriends?.headers else {
                return 0
            }
            return activeHeaders.count
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if isFiltering() {
            guard let activeHeaders = myFiltered?.headers else {
                return ""
            }
            return activeHeaders[section]
        } else {
            guard let activeHeaders = myFriends?.headers else {
                return ""
            }
            return activeHeaders[section]
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            guard let activeList = myFiltered?.orderedList,
                  let activeHeaders = myFiltered?.headers,
                  let activeSection = activeList[ activeHeaders[section] ] else {
                return 0
            }
            return activeSection.count
        } else {
            guard let activeList = myFriends?.orderedList,
                let activeHeaders = myFriends?.headers,
                let activeSection = activeList[ activeHeaders[section] ] else {
                    return 0
            }
            return activeSection.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newCell = FriendTable.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as! FriendTableViewCell
        
        var currentSection = [User]()
        if isFiltering() {
            guard let activeList = myFiltered?.orderedList,
                let activeHeaders = myFiltered?.headers,
                let activeSection = activeList[ activeHeaders[indexPath.section] ] else {
                    return newCell
            }
            currentSection = activeSection
        } else {
            guard let activeList = myFriends?.orderedList,
                let activeHeaders = myFriends?.headers,
                let activeSection = activeList[ activeHeaders[indexPath.section] ] else {
                    return newCell
            }
            currentSection = activeSection
        }
        
        newCell.friendName.text = currentSection[indexPath.row].first_name
        newCell.friendName.textAlignment = .right
        newCell.friendLastName.text = currentSection[indexPath.row].last_name
        
        if let imageURL = currentSection[indexPath.row].avatar_small {
            let healper = DispatchQueue.global(qos: .background)
            healper.async {
                let url = URL(string: imageURL)
                do {
                    let data = try Data(contentsOf: url!)
                    DispatchQueue.main.async {
                        newCell.friendPhotoContentView.image = UIImage(data: data)
                    }
                } catch {
                    print(error)
                }
            }
        }
        
        return newCell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPerson"{
            let indexPath = self.FriendTable.indexPathForSelectedRow!
            var currentSection = myFriends!.orderedList[myFriends!.headers[indexPath.section]]!
            if isFiltering() {
                currentSection = myFiltered!.orderedList[myFiltered!.headers[indexPath.section]]!
            }
            if let destination : ProfilePageViewController! = segue.destination as! ProfilePageViewController {
                destination?.PersonalIdentificator = currentSection[indexPath.row].id
            }
        }
    }

}
