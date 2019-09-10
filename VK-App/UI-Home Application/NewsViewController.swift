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
        
        DispatchQueue.main.async {
            ServerTusks.instance.downloadNewsFeed() {
                [weak self]  in
                
                print("\n\nexecuted")
//                for elements in news {
//                    print(elements.text, "\n")
//                    print(elements.date, "\n---\n")
//                }
//                self?.newsPosts = news
            }
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        NewsTableView.dataSource = self
        NewsTableView.register(UINib(nibName: "textPost", bundle: Bundle.main), forCellReuseIdentifier: "postCell")
    }

}


extension NewsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newCell = NewsTableView.dequeueReusableCell(withIdentifier: "textPost", for: indexPath) as! TextPostCell
        
//        newCell.PostText.text = "\(newsPosts[indexPath.row].text) \(newsPosts[indexPath.row].date)"
        return newCell
    }


}
