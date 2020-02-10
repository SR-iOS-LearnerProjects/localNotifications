//
//  ViewController.swift
//  localNotifications
//
//  Created by Sridatta Nallamilli on 06/01/20.
//  Copyright © 2020 Sridatta Nallamilli. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    @IBOutlet weak var internetStatus: UILabel!
    @IBOutlet weak var connectionTypeLbl: UILabel!
    
    @IBOutlet weak var connectionBtn: UIButton!
    @IBOutlet weak var notificationBtn: UIButton!
    @IBOutlet weak var pullRefresh: UIButton!
    @IBOutlet weak var loadMoreData: UIButton!
    @IBOutlet weak var webView: UIButton!
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    
    
    
    var reachability: Reachability?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Button Styles
        connectionBtn.layer.cornerRadius = connectionBtn.frame.height / 2.0
        notificationBtn.layer.cornerRadius = notificationBtn.frame.height / 2.0
        pullRefresh.layer.cornerRadius = pullRefresh.frame.height / 2.0
        loadMoreData.layer.cornerRadius = loadMoreData.frame.height / 2.0
        webView.layer.cornerRadius = webView.frame.height / 2.0
        saveBtn.layer.cornerRadius = saveBtn.frame.height / 2.0
        clearButton.layer.cornerRadius = clearButton.frame.height / 2.0

        // Notification Delegate
        UNUserNotificationCenter.current().delegate = self
        
        
        nameField.delegate = self
        
        print(UserDefaults.standard.dictionaryRepresentation())
        
        let savedName = UserDefaults.standard.object(forKey: "name")

        if let nameInput = savedName as? String {
            nameField.text = nameInput
        }
        
        
    }

    // Local Notification Function
    func sendLocalNotification() {
        
        // STEP - 1: Ask the user for permission
        // Done in AppDelegate.swift
        
        
        // STEP - 2: Creating notification content
        let content = UNMutableNotificationContent()
        content.categoryIdentifier = "myIdentifier"
        content.title = "Local Notification Triggered!"
        content.subtitle = "Test Success."
        content.body = "This is a Local Notification with Image and Actions Buttons."
        content.sound = UNNotificationSound.default
        
        // Content Image
        guard let path = Bundle.main.path(forResource: "SampleAppIcon", ofType: "jpg") else { return }
        let url = URL(fileURLWithPath: path)
//        https://images.unsplash.com/photo-1578258682172-ea337b005de7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80
        do {
            let attachment = try UNNotificationAttachment(identifier: "war", url: url, options: [:])
            content.attachments = [attachment]
        }
        catch {
            print("Error finding the attachement!")
        }
    
        
        // STEP - 3: Creating the notification trigger
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1.5, repeats: false)
        
        
        // STEP - 4: Creating the request
        let request = UNNotificationRequest(identifier: "notification", content: content, trigger: trigger)
        
        
        // STEP - 5: Registering the request with notification center
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().add(request) { (error) in
            print(error.debugDescription)
        }
        
        // Notification Action
        // defining ations
        let like = UNNotificationAction.init(identifier: "Like", title: "Give a Like!", options: .foreground)
        let dismiss = UNNotificationAction.init(identifier: "Dismiss", title: "Dismiss", options: .destructive)
        // adding actions to a category
        let category = UNNotificationCategory.init(identifier: content.categoryIdentifier, actions: [like, dismiss], intentIdentifiers: [], options: [])
        // assigning the category to notification framework
        UNUserNotificationCenter.current().setNotificationCategories([category])
        
        
        
    }
    
    @IBAction func triggerButton(_ sender: UIButton) {
        sendLocalNotification()
    }
    
    
    @IBAction func checkInternet(_ sender: UIButton) {
        
        // Display Connection Status
        self.reachability = try! Reachability()
        
        if ((self.reachability!.connection) != .unavailable) {
            print("Internet Available")
            internetStatus.text = "Available"
            internetStatus.textColor = .systemGreen
        }
        else {
            print("Internet Not Available")
            internetStatus.text = "Not Available"
            internetStatus.textColor = .systemRed
        }
        
        // Display Connection Type
        switch reachability!.connection {
        case .wifi:
            print("Connected via Wi-Fi")
            connectionTypeLbl.text = "Wi-Fi "
            connectionTypeLbl.textColor = .systemGreen
        case .cellular:
            print("Connected via Cellular Data")
            connectionTypeLbl.text = "Cellular Data"
            connectionTypeLbl.textColor = .systemOrange
        case .none:
            print("Network Not Reachable")
            connectionTypeLbl.text = "Not Reachable"
            connectionTypeLbl.textColor = .systemRed
        case .unavailable:
            print("No Connection")
            connectionTypeLbl.text = "No Connection"
            connectionTypeLbl.textColor = .systemRed
        }
        
    }
    
    
    @IBAction func onClickSave(_ sender: UIButton) {
        UserDefaults.standard.set(nameField.text, forKey: "name")
    }
    
    @IBAction func onClickClear(_ sender: UIButton) {
        UserDefaults.standard.removeObject(forKey: "name")
        nameField.text = ""
        nameField.placeholder = "Enter your name"
    }
    
    
    
}


extension ViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.alert, .sound, .badge])
        
    }
    
    // Push to another VC on clicking the notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler: () -> Void) {
        if response.actionIdentifier == "Like" {
            let vc = self.storyboard?.instantiateViewController(identifier: "LikeVC") as! LikeViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}


extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
