//
//  NetIncomeViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Steven on 10/6/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class NetIncomeViewController: UIViewController {

    private var user: PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let query = PFQuery(className: "SubAccounts")
        query.whereKey("username", equalTo: (currentUser?.username)!)
        do {
            let userArray = try query.findObjects()
            user = userArray[0]
        }
        catch {
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // call emergency contact when button pressed
    @IBAction func CallContact(sender: AnyObject) {
        let toCall:String! = String(user["contactNumber"])
        //let toCall:String! = "9547895347"
        
        // insert phone number validation here, if desired.
        
        if  (toCall.utf16.count >= 10){
            
            if let url = NSURL(string: "telprompt://\(toCall)") {
                            UIApplication.sharedApplication().openURL(url)
            }

        }
        else { // spawn an alert for invalid phone number
            let alert = UIAlertView()
            alert.title = "Sorry!"
            alert.message = "Phone number is not valid."
            alert.addButtonWithTitle("Ok")
            alert.show()
        }
        
    }
    
    
    @IBAction func netIncomeUnwind(segue: UIStoryboardSegue) {
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
