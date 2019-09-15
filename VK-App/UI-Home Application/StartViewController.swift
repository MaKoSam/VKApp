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
    
    
    var loadIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    func updateInstalledData(CompletionHeandler: @escaping () -> Void){
        
        DispatchQueue.global(qos: .utility).async {
            ServerTusks.instance.downloadOwnerData(){
                [weak self] downloadedOwner in
                print("Ready to write Owner")
                RealmDatabaseActions.instance.saveOwner(downloadedOwner)
                
                DispatchQueue.main.async {
                    self?.ProfileName.text = "\(downloadedOwner.first_name) \(downloadedOwner.last_name)"
                    CompletionHeandler()
                }
            }
            
            ServerTusks.instance.downloadFriendData(){
                [weak self] friendList in
                print("Ready to write Friends")
                RealmDatabaseActions.instance.saveOwnerFriends(friendList)
            }
            
            ServerTusks.instance.downloadGroupData(){
                [weak self] groupList in
                print("Ready to write Groups")
                RealmDatabaseActions.instance.saveOwnerGroups(groupList)
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
        
//        DispatchQueue.global(qos: .utility).async {
//            self.updateInstalledData{
//                [weak self] in
//                print("Im Out")
//            }
//        }
        
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
