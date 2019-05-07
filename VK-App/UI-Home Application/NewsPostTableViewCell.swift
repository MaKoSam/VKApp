//
//  NewsPostTableViewCell.swift
//  UI-Home Application
//
//  Created by Developer on 21/03/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit

class NewsPostTableViewCell: UITableViewCell {

    @IBOutlet weak var privatePersonPhoto: NewsPrivatePhotoView!
    @IBOutlet weak var privatePersonName: UILabel!
    @IBOutlet weak var newsPostLikeControl: audienceActivity!
    
    @IBOutlet weak var postPhoto: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
