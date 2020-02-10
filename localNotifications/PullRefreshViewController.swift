//
//  PullRefreshViewController.swift
//  localNotifications
//
//  Created by Sridatta Nallamilli on 06/01/20.
//  Copyright © 2020 Sridatta Nallamilli. All rights reserved.
//

import UIKit

class PullRefreshViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var dataArr = [String]()
    
    let myRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.refreshControl = myRefreshControl
        
    }
    
    @objc private func refresh(sender: UIRefreshControl) {
        let str = "This is line \(dataArr.count)"
        dataArr.append(str)
        tableView.reloadData()
        sender.endRefreshing()
    }

}

extension PullRefreshViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let element = dataArr[indexPath.row]
        cell.textLabel?.text = element
        return cell
    }
    
    
}
