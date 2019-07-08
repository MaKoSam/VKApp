//
//  UpdatedPersonalPageViewController.swift
//  UI-Home Application
//
//  Created by Sam Mazniker on 4/13/19.
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

private var temp = FriendList(serverAnswer)

class PersonalPageViewController: UIViewController {
    
    @IBOutlet weak var personalPageTable: UITableView!
    @IBOutlet weak var headPageView: HeadPageView!
    
    var personData = User(first_name: "None", last_name: "Not Found", photo: UIImage(imageLiteralResourceName: "friend1.jpg"))
    
    var posts = [
        "NEW Iphone Coming this September!",
        "How to code fast with no fingers?",
        "Revealing trueth about M.Jackson!",
        "New YOUtube video on channel of GeeksVid",
        "New Online course opens at GeekBrains"
    ]
    
    
    private class NetworkSession {
        static let custom: Alamofire.Session = {
            let configuration = URLSessionConfiguration.default
            let sessionManager = Alamofire.Session(configuration: configuration)
            return sessionManager
        }()
    }
    
    private func downloadUserData(){
        let parameters: Parameters = [
            "fields": "status,city,photo_50",
            "access_token": Session.instance.app_token!,
            "v": "5.101"
        ]
        
        NetworkSession.custom.request("https://api.vk.com/method/users.get", parameters: parameters).responseJSON {
            response in
            
            print(response.value)
        }
    }

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadUserData()
        
        headPageView.image = personData.photo
        headPageView.name = personData.last_name
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
        newCell.privatePersonPhoto.image = temp.orderedList[temp.headers[0]]?.first?.photo
        newCell.privatePersonName.text = temp.orderedList[temp.headers[0]]?.first?.last_name
        return newCell
    }
    
    
}
