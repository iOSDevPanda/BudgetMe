//
//  ExpensesViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Steven on 10/6/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class ExpensesViewController: UIViewController {

    @IBOutlet weak var food: UITextField!
    @IBOutlet weak var rent: UITextField!
    @IBOutlet weak var gas: UITextField!
    @IBOutlet weak var tuition: UITextField!

    private var user: PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let query = PFQuery(className: "Expenses")
        query.whereKey("username", equalTo: (currentUser?.username)!)
        do {
            let userArray = try query.findObjects()
            user = userArray[0]
            food.text = String(user["foodAnnual"])
            rent.text = String(user["rentAnnual"])
            gas.text = String(user["gasAnnual"])
            tuition.text = String(user["tuitionAnnual"])
        }
        catch {
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func updateExpenses(sender: AnyObject) {
        if (food.text! != "") {
            user["foodAnnual"] = Int(food.text!)
        }
        if (rent.text! != "") {
            user["rentAnnual"] = Int(rent.text!)
        }
        if (gas.text! != "") {
            user["gasAnnual"] = Int(gas.text!)
        }
        if (tuition.text! != "") {
            user["tuitionAnnual"] = Int(tuition.text!)
        }
        user.saveInBackgroundWithBlock {
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
