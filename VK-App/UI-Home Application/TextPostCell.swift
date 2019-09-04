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
    @IBOutlet weak var PostText: UILabel!
    @IBOutlet weak var PostPhotoCollection: UICollectionView!
    @IBOutlet weak var StatisticsView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        PostCoverView.layer.cornerRadius = CGFloat(20)
        UserNameView.layer.cornerRadius = CGFloat(10)
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
