//
//  photoContentView.swift
//  UI-Home Application
//
//  Created by Developer on 18/03/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit

class ProfilePhotoView: UIView {
    
    var image: UIImage?{
        didSet {
            contentView.image = image
        }
    }
    var contentView: UIImageView!
    
    @IBInspectable var shadowOffSet: CGSize = CGSize.zero
    @IBInspectable var shadowOpacity: Float = 0.5
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView = UIImageView(frame: bounds)
        contentView.clipsToBounds = true
        addSubview(contentView)
        
        layer.shadowOffset = shadowOffSet
        layer.shadowOpacity = shadowOpacity
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        UIView.animate(withDuration: 0.3){
            
            self.center.x = self.bounds.width / 2 + 10
            self.center.y = self.bounds.height / 2 + 49
            
            self.frame.size.width -= 10
            self.frame.size.height -= 10
            
            self.contentView.frame.size.width -= 10
            self.contentView.frame.size.height -= 10
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 0.3,
                       initialSpringVelocity: 0.2,
                       options: [],
                       animations: {
            self.frame.size.width += 10
            self.frame.size.height += 10
            
            self.center.x = self.bounds.width / 2 + 10
            self.center.y = self.bounds.height / 2 + 49
            
            self.contentView.frame.size.width += 10
            self.contentView.frame.size.height += 10 } )
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = bounds
        
        layer.cornerRadius = bounds.width / 2
        contentView.layer.cornerRadius = bounds.width / 2
    }
}
