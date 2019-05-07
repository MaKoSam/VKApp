//
//  AllCommunityViewController.swift
//  UI-Home Application
//
//  Created by Sam Mazniker on 3/11/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit

class AllCommunityViewController: UIViewController {
    
    var allCommunity = [
        "Some crap",
        "Some other crap",
        "Friends",
        "Instagram Pictures",
        "Geekbrains University",
        "OBK",
        "I love China"
    ]

    @IBOutlet weak var allCommunityTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        allCommunityTable.dataSource = self
    }

}


extension AllCommunityViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCommunity.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newCell = allCommunityTable.dequeueReusableCell(withIdentifier: "allCommunityCell", for: indexPath) as! AllCommuityTableViewCell
        newCell.allCommunityName.text = allCommunity[indexPath.row]
        newCell.allCommuityPhoto.image = UIImage(imageLiteralResourceName: "friend3.jpg")
        //fix the mis-type above
        
        return newCell
    }
    
    
}
