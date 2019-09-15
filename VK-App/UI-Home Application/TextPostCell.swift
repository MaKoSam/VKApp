//
//  TextPostCell.swift
//  UI-Home Application
//
//  Created by Sam Mazniker on 03/09/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit

class TextPostCell: UITableViewCell {
    
    @IBOutlet weak var PostCoverView: UIView!
    @IBOutlet weak var UserAvatar: UserPhotoView!
    @IBOutlet weak var UserNameView: UIView!
    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var PostText: UILabel!
    @IBOutlet weak var PostPhotoCollection: UICollectionView!
    @IBOutlet weak var StatisticsView: UIView!
    @IBOutlet weak var LikeState: UIImageView!
    @IBOutlet weak var LikeCount: UILabel!
    @IBOutlet weak var CommentCount: UILabel!
    @IBOutlet weak var ReviewCount: UILabel!
    
    var AttachedFiles: [Attachment] = [] {
        didSet {
            DispatchQueue.main.async {
                self.PostPhotoCollection.reloadData()
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        PostPhotoCollection.dataSource = self
        PostCoverView.layer.cornerRadius = CGFloat(20)
        UserNameView.layer.cornerRadius = CGFloat(10)
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension TextPostCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return AttachedFiles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let defaultCell = PostPhotoCollection.dequeueReusableCell(withReuseIdentifier: "photo", for: indexPath) as! PhotoAttachmentCell
        
        if AttachedFiles[indexPath.row].type == "photo" {
            let newCell = PostPhotoCollection.dequeueReusableCell(withReuseIdentifier: "photo", for: indexPath) as! PhotoAttachmentCell
            if let photoAttached = AttachedFiles[indexPath.row].photo {
                for elements in photoAttached.imageURL {
                    if elements.type == "x" {
                        DispatchQueue.global(qos: .utility).async {
                            let url = URL(string: elements.URL)
                            do {
                                let data = try Data(contentsOf: url!)
                                DispatchQueue.main.async {
                                    newCell.imageView.image = UIImage(data: data)
                                }
                            } catch {
                                print(error)
                            }
                        }
                    }
                }
            }
            return newCell
        } else
        if AttachedFiles[indexPath.row].type == "link" {
            let newCell = PostPhotoCollection.dequeueReusableCell(withReuseIdentifier: "link", for: indexPath) as! LinkAttachmentCell
            if let linkAttached = AttachedFiles[indexPath.row].link {
                DispatchQueue.main.async {
                    newCell.link.titleLabel?.text = linkAttached.url
                }
                if let photoCover = linkAttached.coverPhoto {
                    for elements in photoCover.imageURL{
                        if elements.type == "x" {
                            DispatchQueue.global(qos: .utility).async {
                                let url = URL(string: elements.URL)
                                do {
                                    let data = try Data(contentsOf: url!)
                                    DispatchQueue.main.async {
                                        newCell.linkImage.image = UIImage(data: data)
                                    }
                                } catch {
                                    print(error)
                                }
                            }
                        }
                    }
                }
            }
            return newCell
        } else {
            return defaultCell
        }
    }
    
    
}
