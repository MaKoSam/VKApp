//
//  StartViewController.swift
//  UI-Home Application
//
//  Created by Sam Mazniker on 03/08/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    @IBOutlet weak var ProfileAvatar: UIImageView!
    @IBOutlet weak var ProfileName: UILabel!
    
    
    var loadIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    func updateInstalledData(completionHandler: @escaping() -> Void){
        DispatchQueue.main.async {
            
            ServerTusks.instance.downloadOwnerData(){
                [weak self] downloadedOwner in
                ServerTusks.instance.saveOwner(downloadedOwner)
                self?.ProfileName.text = "\(downloadedOwner.first_name) \(downloadedOwner.last_name)"
                
                
                ServerTusks.instance.downloadFriendData(){
                    [weak self] friendList in
                    ServerTusks.instance.saveOwnerFriends(downloadedOwner, friendList)
                    
                    ServerTusks.instance.downloadGroupData(){
                        [weak self] groupList in
                        ServerTusks.instance.saveOwnerGroups(downloadedOwner, groupList)
                        
                        completionHandler()
                    }
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        loadIndicator.center = self.view.center
        loadIndicator.hidesWhenStopped = true
        loadIndicator.style = .gray
        view.addSubview(loadIndicator)
        loadIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        updateInstalledData{
            [weak self] in
            
            self?.loadIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

}
