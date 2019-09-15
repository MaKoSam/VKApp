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
        DispatchQueue.global(qos: .userInteractive).async {
            ServerTusks.instance.downloadNewsFeed() {
                [weak self]  news in
                DispatchQueue.main.async {
                    self?.newsPosts = news
                    self?.NewsTableView.reloadData()
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        NewsTableView.dataSource = self
    }
}


extension NewsViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsPosts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newCell = NewsTableView.dequeueReusableCell(withIdentifier: "textPost", for: indexPath) as! TextPostCell
        
        DispatchQueue.global(qos: .userInteractive).async {
            if self.newsPosts[indexPath.row].source_id > 0 {
                DispatchQueue.global(qos: .userInitiated).async {
                    ServerTusks.instance.downloadUsersData("\(self.newsPosts[indexPath.row].source_id)") {
                        [weak self] downloadedUser in
                        if let postOwner = downloadedUser.first {
                            //Download User Avatar
                            DispatchQueue.global(qos: .utility).async {
                                if let imageURL = postOwner.avatar_small {
                                    let url = URL(string: imageURL)
                                    do {
                                        let data = try Data(contentsOf: url!)
                                        DispatchQueue.main.async {
                                            newCell.UserAvatar.image = UIImage(data: data)
                                        }
                                    } catch {
                                        print(error)
                                    }
                                }
                            }
                            //Set User Name
                            DispatchQueue.main.async {
                                newCell.UserName.text = postOwner.full_name
                            }
                        }
                    }
                }
            } else {
                DispatchQueue.global(qos: .userInitiated).async {
                    ServerTusks.instance.downloadGroupById("\((-1) * self.newsPosts[indexPath.row].source_id)") {
                        [weak self] downloadedGroup in
                        if let postOwner = downloadedGroup.first {
                            //Download Group Avatar
                            DispatchQueue.global(qos: .utility).async {
                                let url = URL(string: postOwner.avatar)
                                do {
                                    let data = try Data(contentsOf: url!)
                                    DispatchQueue.main.async {
                                        newCell.UserAvatar.image = UIImage(data: data)
                                    }
                                } catch {
                                    print(error)
                                }
                            }
                            //Set Group Name
                            DispatchQueue.main.async {
                                newCell.UserName.text = postOwner.name
                            }
                        }
                    }
                }
            }
            
            DispatchQueue.main.async {
                newCell.PostText.text = self.newsPosts[indexPath.row].text + " " + self.newsPosts[indexPath.row].date
                newCell.AttachedFiles = self.newsPosts[indexPath.row].attachment
            }
            
            if let numberOfLikes = self.newsPosts[indexPath.row].likes {
                DispatchQueue.main.async {
                    newCell.LikeCount.text = "\(numberOfLikes.count)"
                }
            }
            if let numberOfComments = self.newsPosts[indexPath.row].comments {
                DispatchQueue.main.async {
                    newCell.CommentCount.text = "\(numberOfComments.count)"
                }
            }
            if let numberOfViews = self.newsPosts[indexPath.row].views {
                DispatchQueue.main.async {
                    newCell.ReviewCount.text = "\(numberOfViews.count)"
                }
            }
            
        }
        
        return newCell
    }


}
