//
//  LoadMoreDataViewController.swift
//  localNotifications
//
//  Created by Sridatta Nallamilli on 06/01/20.
//  Copyright © 2020 Sridatta Nallamilli. All rights reserved.
//

import UIKit

class LoadMoreDataViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var recordsArr = [Int]()
    var limit = 10
    let totalEnteries = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var index = 0
        while index < limit {
            recordsArr.append(index)
            index = index + 1
        }
        
    }
    

}


extension LoadMoreDataViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Record \(recordsArr[indexPath.row])"
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == recordsArr.count - 1 {
            // we are at last cell load more content
            if recordsArr.count < totalEnteries {
                // we need to bring more records as there are some pending records available
                var index = recordsArr.count
                limit = index + 10
                while index < limit {
                    recordsArr.append(index)
                    index = index + 1
                }
                self.perform(#selector(loadTable), with: nil, afterDelay: 1.0)
            }
        }
    }
    
    @objc func loadTable() {
        self.tableView.reloadData()
    }
    
    
}
