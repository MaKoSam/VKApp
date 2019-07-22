//
//  ProfilePageViewController.swift
//  UI-Home Application
//
//  Created by Sam Mazniker on 15/07/2019.
//  Copyright © 2019 Developer. All rights reserved.
//
//  Icons made by https://www.freepik.com/ title="Freepik"

import UIKit

class ProfilePageViewController: UIViewController {
    
    @IBOutlet weak var HeadPageVIew: ProfilePageHeadView!
    @IBOutlet weak var ProfileName: UILabel!
    @IBOutlet weak var ProfileLabel: UILabel!
    @IBOutlet weak var ProfileFollowers: UILabel!
    @IBOutlet weak var ProfilePosts: UILabel!
    @IBOutlet weak var ProfilePhoto: ProfileHeadPhoto!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

    }

}
