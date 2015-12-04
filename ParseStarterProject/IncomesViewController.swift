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
    @IBOutlet weak var salaryCurrency: UILabel!
    @IBOutlet weak var scholarshipCurrency: UILabel!
    
    private var user: PFObject!
    internal final var MONTHS_IN_YEAR = 12.0
    
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
            salary.text = String(NetIncomeViewController.convertFromUSD((Double(salary.text!)!)))
            scholarships.text = String(user["scholarshipsAnnual"])
            scholarships.text = String(NetIncomeViewController.convertFromUSD((Double(scholarships.text!)!)))
            
        }
        catch {
        }
        
        salaryIncomeType.selectedSegmentIndex = 1
        scholarshipIncomeType.selectedSegmentIndex = 1
        
        salaryCurrency.text = selectedCurrency
        scholarshipCurrency.text = selectedCurrency
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        updateIncome(sender!)
    }
    
    func updateIncome(sender: AnyObject) {
        if (salary.text! != "") {
            let annual = salaryIncomeType.selectedSegmentIndex == 0 ? Double(salary.text!)! * MONTHS_IN_YEAR : Double(salary.text!)
            user["salaryAnnual"] = NetIncomeViewController.convertToUSD(Double(annual!))
        }
        if (scholarships.text! != "") {
            let annual = scholarshipIncomeType.selectedSegmentIndex == 0 ? Double(scholarships.text!)! * MONTHS_IN_YEAR : Double(scholarships.text!)
            user["scholarshipsAnnual"] = NetIncomeViewController.convertToUSD(Double(annual!))
        }
        
        user["incomeTotal"] = Int(user["salaryAnnual"] as! NSNumber) + Int(user["scholarshipsAnnual"] as! NSNumber)
        
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
