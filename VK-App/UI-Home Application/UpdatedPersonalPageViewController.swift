//
//  UpdatedPersonalPageViewController.swift
//  UI-Home Application
//
//  Created by Sam Mazniker on 4/13/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit

class PersonalPageViewController: UIViewController {
    
    @IBOutlet weak var personalPageTable: UITableView!
    @IBOutlet weak var headPageView: HeadPageView!
    
    var personData = Person(name: "Not Found", photo: UIImage(imageLiteralResourceName: "friend1.jpg"))
    
    var posts = [
        "NEW Iphone Coming this September!",
        "How to code fast with no fingers?",
        "Revealing trueth about M.Jackson!",
        "New YOUtube video on channel of GeeksVid",
        "New Online course opens at GeekBrains"
    ]
    
    var temp = FriendData()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headPageView.image = personData.photo
        headPageView.name = personData.name
        headPageView.status = "I'm happy to finally use this App!"
        headPageView.friendsNumber = "344"
        headPageView.followersNumber = "10334"
        headPageView.postsNumber = "34223"
        
        headPageView.relationsState = .friends
        
        personalPageTable.dataSource = self
        personalPageTable.register(UINib(nibName: "NewsPostTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "postCell")
    }
    
}


extension PersonalPageViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newCell = personalPageTable.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! NewsPostTableViewCell
        newCell.privatePersonPhoto.image = temp.publicUserData[temp.tableLitterals[0]]?.first?.photo
        newCell.privatePersonName.text = temp.publicUserData[temp.tableLitterals[0]]?.first?.name
        return newCell
    }
    
    
}
