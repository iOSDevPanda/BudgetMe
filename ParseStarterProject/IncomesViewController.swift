//
//  IncomesViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Steven on 10/6/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

var globIn = 0

class IncomesViewController: UIViewController {

    @IBOutlet weak var salary: UITextField!
    @IBOutlet weak var scholarships: UITextField!
    @IBOutlet weak var salaryIncomeType: UISegmentedControl!
    @IBOutlet weak var scholarshipIncomeType: UISegmentedControl!
    @IBOutlet weak var salaryCurrency: UILabel!
    @IBOutlet weak var scholarshipCurrency: UILabel!
    
    var salaryData = 0
    var scholarshipData = 0
    
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
            salary.text = String(convertFromUSD((Double(salary.text!)!)))
            scholarships.text = String(user["scholarshipsAnnual"])
            scholarships.text = String(convertFromUSD((Double(scholarships.text!)!)))
            
            // Calculating Total Income
            salaryData = Int(user["salaryAnnual"] as! NSNumber)
            scholarshipData = Int(user["scholarshipsAnnual"] as! NSNumber)
            
            globIn = salaryData + scholarshipData
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
    
    @IBAction func updateIncome(sender: AnyObject) {
        if (salary.text! != "") {
            let annual = salaryIncomeType.selectedSegmentIndex == 0 ? Double(salary.text!)! * MONTHS_IN_YEAR : Double(salary.text!)
            user["salaryAnnual"] = convertToUSD(Double(annual!))
        }
        if (scholarships.text! != "") {
            let annual = scholarshipIncomeType.selectedSegmentIndex == 0 ? Double(scholarships.text!)! * MONTHS_IN_YEAR : Double(scholarships.text!)
            user["scholarshipsAnnual"] = convertToUSD(Double(annual!))
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
    
    //Values updated on 11/17/2015
    
    func convertToUSD(value: Double) -> Double {
        switch (selectedCurrency) {
            case "$":
                return value
            case "€":
                return (value * 1.07)
            case "£":
                return (value * 1.52)
            case "¥":
                return (value * 0.0081)
            case "C$":
                return (value * 0.75)
            default:
                return 0
        }
    }
    
    func convertFromUSD(value: Double) -> Double {
        switch (selectedCurrency) {
        case "$":
            return value
        case "€":
            return (value / 1.07)
        case "£":
            return (value / 1.52)
        case "¥":
            return (value / 0.0081)
        case "C$":
            return (value / 0.75)
        default:
            return 0
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
