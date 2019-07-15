//
//  ProfilePageHeadView.swift
//  UI-Home Application
//
//  Created by Sam Mazniker on 15/07/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit

class ProfilePageHeadView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderColor = UIColor(red: 254, green: 254, blue: 254, alpha: 1).cgColor
        layer.borderWidth = CGFloat(2)
        layer.cornerRadius = CGFloat(20)
    }

}
