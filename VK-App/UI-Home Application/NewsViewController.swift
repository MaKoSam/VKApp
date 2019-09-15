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
    
    func downloadNewsFeed(){
        
        ServerTusks.instance.downloadNewsFeed() {
            [weak self]  news in
            self?.newsPosts = news
            for elemets in self!.newsPosts {
                print("serverInstance:", elemets.source_id)
            }
            print("\n");
            self?.NewsTableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        downloadNewsFeed()
        NewsTableView.dataSource = self
        NewsTableView.register(UINib(nibName: "textPost", bundle: Bundle.main), forCellReuseIdentifier: "postCell")
    }

}


extension NewsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsPosts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newCell = NewsTableView.dequeueReusableCell(withIdentifier: "textPost", for: indexPath) as! TextPostCell
        
        newCell.LikeCount.text = "\(newsPosts[indexPath.row].likes!.count)"
        newCell.CommentCount.text = "\(newsPosts[indexPath.row].comments!.count)"
        newCell.ReviewCount.text = "\(newsPosts[indexPath.row].views!.count)"
        newCell.PostText.text = "\(newsPosts[indexPath.row].text) \(newsPosts[indexPath.row].date)"
        
        return newCell
    }


}
