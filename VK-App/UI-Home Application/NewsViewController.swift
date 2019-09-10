//
//  NewsViewController.swift
//  UI-Home Application
//
//  Created by Developer on 21/03/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {

    @IBOutlet weak var NewsTableView: UITableView!
    
    var newsPosts: [NewsFeedPost] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        
        DispatchQueue.global(qos: .userInitiated).async {
            ServerTusks.instance.downloadNewsFeed() {
                [weak self]  news in
                DispatchQueue.main.async {
                    self?.newsPosts = news
                    for elemets in self!.newsPosts {
                        print("insider")
                        print(elemets.source_id, "\n\n")
                    }
                }
            }
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        NewsTableView.dataSource = self
        NewsTableView.register(UINib(nibName: "textPost", bundle: Bundle.main), forCellReuseIdentifier: "postCell")
        print("outsider, not in table")
        for elemets in newsPosts {
            print(elemets.source_id, "\n\n")
        }
    }

}


extension NewsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newCell = NewsTableView.dequeueReusableCell(withIdentifier: "textPost", for: indexPath) as! TextPostCell
        print("outsider, in table")
        for elemets in newsPosts {
            print(elemets.source_id, "\n\n")
        }
//        newCell.PostText.text = "\(newsPosts[indexPath.row].text) \(newsPosts[indexPath.row].date)"
        return newCell
    }


}
