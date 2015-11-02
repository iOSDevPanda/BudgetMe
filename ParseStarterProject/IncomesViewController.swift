//
//  IncomesViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Steven on 10/6/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class IncomesViewController: UIViewController {

    @IBOutlet weak var salary: UITextField!
    @IBOutlet weak var scholarships: UITextField!

    private var user: PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //query for current values, esle set 0
        let query = PFQuery(className: "Incomes")
        query.whereKey("username", equalTo: (currentUser?.username)!)
        query.whereKey("subAccount", equalTo: currentAccount)
        do {
            let userArray = try query.findObjects()
            user = userArray[0]
            salary.text = String(user["salaryAnnual"])
            scholarships.text = String(user["scholarshipsAnnual"])
        }
        catch {
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func updateIncome(sender: AnyObject) {
        if (salary.text! != "") {
            user["salaryAnnual"] = Int(salary.text!)
        }
        if (scholarships.text! != "") {
            user["scholarshipsAnnual"] = Int(scholarships.text!)
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
