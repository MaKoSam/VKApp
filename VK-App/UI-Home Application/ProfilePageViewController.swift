//
//  ProfilePageViewController.swift
//  UI-Home Application
//
//  Created by Sam Mazniker on 15/07/2019.
//  Copyright © 2019 Developer. All rights reserved.
//
//  Icons made by https://www.freepik.com/ title="Freepik"

import UIKit
import RealmSwift

class ProfilePageViewController: UIViewController {
    
    var PersonalIdentificator: Int = 0
    
    @IBOutlet weak var HeadPageVIew: ProfilePageHeadView!
    @IBOutlet weak var ProfileName: UILabel!
    @IBOutlet weak var ProfileLabel: UILabel!
    @IBOutlet weak var ProfileFollowers: UILabel!
    @IBOutlet weak var ProfilePosts: UILabel!
    @IBOutlet weak var ProfilePhoto: ProfileHeadPhoto!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        do {
            let realm = try Realm()
            let userData = realm.objects(User.self).filter("id = %@", PersonalIdentificator).first
            ProfileName.text = "\(userData!.first_name) \(userData!.last_name)"
            ProfileName.textAlignment = .center
            ProfileName.adjustsFontSizeToFitWidth = true
            
            ProfileLabel.textAlignment = .center
            ProfileLabel.adjustsFontSizeToFitWidth = true
            ProfileLabel.text = userData?.status
            
            if let imageURL = userData?.avatar_profile {
                let healper = DispatchQueue.global(qos: .background)
                healper.async {
                    let url = URL(string: imageURL)
                    do {
                        let data = try Data(contentsOf: url!)
                        DispatchQueue.main.async {
                            self.ProfilePhoto.image = UIImage(data: data)
                        }
                    } catch {
                        print(error)
                    }
                }
            }
        } catch {
            print(error)
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print("\(String(describing: selfData?.first_name)) \(String(describing: selfData?.last_name))")

    }

}
