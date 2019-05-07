//
//  AllCommuityTableViewCell.swift
//  UI-Home Application
//
//  Created by Sam Mazniker on 3/11/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit

class AllCommuityTableViewCell: UITableViewCell {
    
    @IBOutlet weak var allCommunityName: UILabel!
    @IBOutlet weak var allCommuityPhoto: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
