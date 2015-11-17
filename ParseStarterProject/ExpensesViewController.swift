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
    @IBOutlet var foodExpenseType: UISegmentedControl!
    @IBOutlet var rentExpenseType: UISegmentedControl!
    @IBOutlet var gasExpenseType: UISegmentedControl!
    @IBOutlet var tuitionExpenseType: UISegmentedControl!
    @IBOutlet weak var foodCurrency: UILabel!
    @IBOutlet weak var rentCurrency: UILabel!
    @IBOutlet weak var gasCurrency: UILabel!
    @IBOutlet weak var tuitionCurrency: UILabel!
    
    internal final var MONTHS_IN_YEAR = 12.0
    private var user: PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Default to yearly expenses when loaded.
        foodExpenseType.selectedSegmentIndex = 1;
        gasExpenseType.selectedSegmentIndex = 1;
        rentExpenseType.selectedSegmentIndex = 1;
        tuitionExpenseType.selectedSegmentIndex = 1;
        
        // Do any additional setup after loading the view.
        let query = PFQuery(className: "Expenses")
        query.whereKey("username", equalTo: (currentUser?.username)!)
        query.whereKey("subAccount", equalTo: currentAccount)
        do {
            let userArray = try query.findObjects()
            user = userArray[0]
            food.text = String(user["foodAnnual"])
            food.text = String(convertFromUSD((Double(food.text!)!)))
            rent.text = String(user["rentAnnual"])
            rent.text = String(convertFromUSD((Double(rent.text!)!)))
            gas.text = String(user["gasAnnual"])
            gas.text = String(convertFromUSD((Double(gas.text!)!)))
            tuition.text = String(user["tuitionAnnual"])
            tuition.text = String(convertFromUSD((Double(tuition.text!)!)))
        }
        catch {
        }
        
        foodCurrency.text = selectedCurrency
        rentCurrency.text = selectedCurrency
        gasCurrency.text = selectedCurrency
        tuitionCurrency.text = selectedCurrency
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func updateExpenses(sender: AnyObject) {
        if (food.text! != "") {
            let annual = foodExpenseType.selectedSegmentIndex == 0 ? Double(food.text!)! * MONTHS_IN_YEAR : Double(food.text!)
            user["foodAnnual"] = convertToUSD(Double(annual!))
        }
        if (rent.text! != "") {
            let annual = rentExpenseType.selectedSegmentIndex == 0 ? Double(rent.text!)! * MONTHS_IN_YEAR : Double(rent.text!)
            user["rentAnnual"] = convertToUSD(Double(annual!))
        }
        if (gas.text! != "") {
            let annual = gasExpenseType.selectedSegmentIndex == 0 ? Double(gas.text!)! * MONTHS_IN_YEAR : Double(gas.text!)
            user["gasAnnual"] = convertToUSD(Double(annual!))
        }
        if (tuition.text! != "") {
            let annual = tuitionExpenseType.selectedSegmentIndex == 0 ? Double(tuition.text!)! * MONTHS_IN_YEAR : Double(tuition.text!)
            user["tuitionAnnual"] = convertToUSD(Double(annual!))
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
