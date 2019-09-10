//
//  NewsViewController.swift
//  UI-Home Application
//
//  Created by Developer on 21/03/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {

    @IBOutlet weak var NewsTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        NewsTableView.dataSource = self
        NewsTableView.register(UINib(nibName: "textPost", bundle: Bundle.main), forCellReuseIdentifier: "postCell")
    }

}


extension NewsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newCell = NewsTableView.dequeueReusableCell(withIdentifier: "textPost", for: indexPath) as! TextPostCell
        return newCell
    }


}
