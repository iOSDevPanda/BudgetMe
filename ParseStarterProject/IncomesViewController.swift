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
    @IBOutlet weak var salaryIncomeType: UISegmentedControl!
    @IBOutlet weak var scholarshipIncomeType: UISegmentedControl!

    private var user: PFObject!
    internal final var MONTHS_IN_YEAR:Int! = 12
    
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
        
        salaryIncomeType.selectedSegmentIndex = 0
        scholarshipIncomeType.selectedSegmentIndex = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func updateIncome(sender: AnyObject) {
        if (salary.text! != "") {
            user["salaryAnnual"] = salaryIncomeType.selectedSegmentIndex == 0 ? Int(salary.text!)! * MONTHS_IN_YEAR : Int(salary.text!)
        }
        if (scholarships.text! != "") {
            user["scholarshipsAnnual"] = scholarshipIncomeType.selectedSegmentIndex == 0 ? Int(scholarships.text!)! * MONTHS_IN_YEAR : Int(scholarships.text!)
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
