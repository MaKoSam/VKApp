//
//  StartViewController.swift
//  UI-Home Application
//
//  Created by Sam Mazniker on 03/08/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    @IBOutlet weak var ProfileName: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
//        let friends = RealmDatabaseDownload.instance.friends()
//
//        DispatchQueue.global(qos: .default).async {
//            var photoService : PhotoCacheService?
//            print("im innnnn")
//            for elements in friends {
//                print("very inn")
//                if let imageURL = elements.avatar_small {
//                    photoService?.UpdatePhotoCaches(byUrl: imageURL)
//                }
//            }
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
