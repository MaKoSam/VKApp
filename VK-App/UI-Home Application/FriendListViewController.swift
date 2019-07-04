//
//  FriendListViewController.swift
//  UI-Home Application
//
//  Created by Sam Mazniker on 3/10/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit
import Alamofire

private var serverAnswer = [
    User(first_name: "None", last_name: "Rihanna", photo: UIImage(imageLiteralResourceName: "friend1.jpg")),
    User(first_name: "None",last_name: "Jeff Bezos", photo: UIImage(imageLiteralResourceName: "friend2.jpg")),
    User(first_name: "None",last_name: "Bill Atkinson", photo: UIImage(imageLiteralResourceName: "friend3.jpg")),
    User(first_name: "None",last_name: "Steve P. Jobs", photo: UIImage(imageLiteralResourceName: "friend4.jpg")),
    User(first_name: "None",last_name: "Jane Woodsilgton", photo: UIImage(imageLiteralResourceName: "friend5.jpg")),
    User(first_name: "None",last_name: "Lisa Jobs", photo: UIImage(imageLiteralResourceName: "friend6.jpg"))
]

var friends = FriendList(serverAnswer)

private class NetworkSession {
    static let custom: Alamofire.Session = {
        let configuration = URLSessionConfiguration.default
        let sessionManager = Alamofire.Session(configuration: configuration)
        return sessionManager
    }()
}

private func downloadFriendList(){
    let parameters: Parameters = [
        "access_token": Session.instance.app_token!,
        "v": "5.101"
    ]
    
    NetworkSession.custom.request("https://api.vk.com/method/friends.get", parameters: parameters).responseJSON {
        response in
        print(response.value)
    }
}



class FriendListViewController: UIViewController {
    
    @IBOutlet weak var FriendTable: UITableView!
    
//    let searchController = UISearchController(searchResultsController: nil)
//    var filteredFriends = FriendData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       downloadFriendList()
        
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
        return friends.headers.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if isFiltering() {
//            return filteredFriends.tableLitterals[section]
//        }
        return friends.headers[section]
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if isFiltering() {
//            return filteredFriends.publicUserData[filteredFriends.tableLitterals[section]]!.count
//        }
        return friends.orderedList[ friends.headers[section] ]!.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newCell = FriendTable.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as! FriendTableViewCell

        var currentSection = friends.orderedList[friends.headers[indexPath.section]]!

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
