//
//  ProfileHeadPhoto.swift
//  UI-Home Application
//
//  Created by Sam Mazniker on 15/07/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit

class ProfileHeadPhoto: UIView {

    var image: UIImage?{
        didSet {
            contentView.image = image
        }
    }
    
    var contentView: UIImageView!
    
    @IBInspectable var shadowOffSet: CGSize = CGSize.zero
    @IBInspectable var shadowOpacity: Float = 0.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView = UIImageView(frame: bounds)
        contentView.clipsToBounds = true
        addSubview(contentView)
        
        layer.shadowOffset = shadowOffSet
        layer.shadowOpacity = shadowOpacity
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = bounds
        
        layer.cornerRadius = bounds.width / 2
        contentView.layer.cornerRadius = bounds.width / 2
    }

}
