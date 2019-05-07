//
//  FriendTableViewCell.swift
//  UI-Home Application
//
//  Created by Sam Mazniker on 3/10/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {

    @IBOutlet weak var friendName: UILabel!
    @IBOutlet weak var friendPhoto: UIImageView!
    @IBOutlet weak var friendPhotoContentView: FriendTableBarPhotoView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
