//
//  OneTimesViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Steven on 10/6/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class OneTimesViewController: UIViewController {

    @IBOutlet weak var amount: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        amount.text = "0"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func income(sender: AnyObject) {
        if(amount.text! != "") {
            upload(Int(amount.text!)!)
        }
    }
    
    @IBAction func expense(sender: AnyObject) {
        if(amount.text! != "") {
            upload(0-Int(amount.text!)!)
        }
    }
    
    func upload(value: Int) {
        let oneTimes = PFObject(className: "OneTimes")
        oneTimes["username"] = currentUser?.username
        oneTimes["subAccount"] = currentAccount
        oneTimes["oneTime"] = value
        oneTimes.saveInBackgroundWithBlock {
            (success: Bool, error:NSError?) -> Void in
            if(success) {
                print("Saved")
            }
            else {
                print("Error")
            }
        }

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        self.view.endEditing(true)
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
