//
//  FriendTableViewCell.swift
//  UI-Home Application
//
//  Created by Sam Mazniker on 3/10/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {
    var imageURL : String?

    @IBOutlet weak var friendName: UILabel!
    @IBOutlet weak var friendLastName: UILabel!
    @IBOutlet weak var friendPhoto: UIImageView!
    @IBOutlet weak var friendPhotoContentView: FriendTableBarPhotoView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        let url = URL(string: imageURL!)
//        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
//        friendPhotoContentView.image = UIImage(data: data!)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
