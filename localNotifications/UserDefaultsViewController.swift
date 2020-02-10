//
//  UserDefaultsViewController.swift
//  localNotifications
//
//  Created by Sridatta Nallamilli on 06/01/20.
//  Copyright © 2020 Sridatta Nallamilli. All rights reserved.
//

import UIKit
import Foundation

class UserDefaultsViewController: UIViewController {

    @IBOutlet weak var nameLbl
    : UITextField!
    
    @IBOutlet weak var saveBtn: UIButton!
    
    @IBOutlet weak var clearBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(UserDefaults.standard.dictionaryRepresentation())
        
//        let savedName = UserDefaults.standard.object(forKey: "name")
//
//        if let nameInput = savedName as? String {
//            nameLbl.text = nameInput
//        }
        
    }
  
    @IBAction func onClickSave(_ sender: UIButton) {
        UserDefaults.standard.set(nameLbl.text, forKey: "name")
    }
    
    @IBAction func onClickClear(_ sender: UIButton) {
    }
    
}
