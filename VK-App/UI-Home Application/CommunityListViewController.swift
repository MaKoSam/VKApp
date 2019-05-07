//
//  CommunityListViewController.swift
//  UI-Home Application
//
//  Created by Sam Mazniker on 3/11/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit

class CommunityListViewController: UIViewController {
    
    var community = [
        "Apple Lovers",
        "Swift Coders",
        "Late HomeWork",
        "Time Management"
    ]

    @IBOutlet weak var communityTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        communityTable.dataSource = self
    }
    
    @IBAction func addCommunity(segue: UIStoryboardSegue){
        if segue.identifier == "addCommunity" {
            let allCommunityController = segue.source as! AllCommunityViewController
            if let indexPath = allCommunityController.allCommunityTable.indexPathForSelectedRow{
                let newCommunity = allCommunityController.allCommunity[indexPath.row]
                if !self.community.contains(newCommunity){
                    self.community.append(newCommunity)
                    allCommunityController.allCommunity.remove(at: indexPath.row)
                    allCommunityController.allCommunityTable.reloadData()
                    self.communityTable.reloadData()
                }
            }
        }
    }

}


extension CommunityListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return community.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newCell = communityTable.dequeueReusableCell(withIdentifier: "communityCell", for: indexPath) as! CommunityTableViewCell
        newCell.communityName.text = community[indexPath.row]
        newCell.communityPhoto.image = UIImage(imageLiteralResourceName: "friend2.jpg")
        return newCell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            self.community.remove(at: indexPath.row)
            self.communityTable.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}
