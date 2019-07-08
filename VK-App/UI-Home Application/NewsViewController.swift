////
////  NewsViewController.swift
////  UI-Home Application
////
////  Created by Developer on 21/03/2019.
////  Copyright © 2019 Developer. All rights reserved.
////
//
//import UIKit
//
////private var serverAnswer = [
//    User(first_name: "None", last_name: "Rihanna", photo: UIImage(imageLiteralResourceName: "friend1.jpg")),
//    User(first_name: "None",last_name: "Jeff Bezos", photo: UIImage(imageLiteralResourceName: "friend2.jpg")),
//    User(first_name: "None",last_name: "Bill Atkinson", photo: UIImage(imageLiteralResourceName: "friend3.jpg")),
//    User(first_name: "None",last_name: "Steve P. Jobs", photo: UIImage(imageLiteralResourceName: "friend4.jpg")),
//    User(first_name: "None",last_name: "Jane Woodsilgton", photo: UIImage(imageLiteralResourceName: "friend5.jpg")),
//    User(first_name: "None",last_name: "Lisa Jobs", photo: UIImage(imageLiteralResourceName: "friend6.jpg"))
//]
//
//private var temp = FriendList(serverAnswer)
//
//class NewsViewController: UIViewController {
//
//    @IBOutlet weak var NewsTableView: UITableView!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        NewsTableView.dataSource = self
//        NewsTableView.register(UINib(nibName: "NewsPostTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "postCell")
//    }
//
//}
//
//
//extension NewsViewController : UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//        return 5
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let newCell = NewsTableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! NewsPostTableViewCell
//        newCell.privatePersonPhoto.image = temp.orderedList[temp.headers[0]]?.first?.photo
//        newCell.privatePersonName.text = temp.orderedList[temp.headers[0]]?.first?.last_name
//
//        newCell.postPhoto.image = temp.orderedList[temp.headers[0]]?.first?.photo
//
//        return newCell
//    }
//
//
//}
