//
//  SettingsViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Steven on 10/6/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func settingsUnwind(segue: UIStoryboardSegue) {
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if (segue.identifier == "settingsToSubAccounts") {
            let uvc = segue.destinationViewController as! SubAccountViewController;
            let query = PFQuery(className: "SubAccounts")
            query.whereKey("username", equalTo: (currentUser?.username)!)
            do {
                let userArray =  try query.findObjects()
                uvc.users = userArray
            }
            catch {
                print("Error: Can't load all friends")
            }
        }
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
