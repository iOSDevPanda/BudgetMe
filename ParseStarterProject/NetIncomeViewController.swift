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
    
    @IBOutlet weak var moneyIn: UILabel!
    @IBOutlet weak var moneyOut: UILabel!
    @IBOutlet weak var moneyNet: UILabel!

    private var user: PFObject!
    
    private var query: PFQuery!
    private var userArray: [PFObject] = []
    
    private var latestIncome:Int! = 0
    private var latestExpense:Int! = 0
    private var latestOneTime:Int! = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateIncomes()
        updateExpenses()
        
        
        query = PFQuery(className: "SubAccounts")
        query.whereKey("username", equalTo: (currentUser?.username)!)
        do {
            userArray = try query.findObjects()
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
    
    @IBAction func calculateNet(sender: AnyObject) {
         updateIncomes()
         updateExpenses()
         //updateOneTimes()
        
        // subtract outflows from inflows
        let net:Int! = latestIncome - latestExpense + latestOneTime
        
        moneyNet.text = selectedCurrency + " \(net)"
        
        // SO COOL WOW COLOR
        if(net >= 0) {
            moneyNet.textColor = UIColor.greenColor()
        } else if(net < 0) {
            moneyNet.textColor = UIColor.redColor()
        }
    }
    
    // general function to query and update incomes
    func updateIncomes() {
        query = PFQuery(className: "Incomes")
        query.whereKey("username", equalTo:(currentUser?.username)!)
        do {
            userArray = try query.findObjects()
            user = userArray[0]
            latestIncome = NetIncomeViewController.convertFromUSD(Double(String(user["incomeTotal"]))!)
            let output:String! = String(latestIncome)
            moneyIn.text = selectedCurrency + " \(output)"
        } catch {
            //
        }
    }
    
    // general function query expenses
    func updateExpenses() {
        query = PFQuery(className: "Expenses")
        query.whereKey("username", equalTo:(currentUser?.username)!)
        do {
            userArray = try query.findObjects()
            user = userArray[0]
            latestExpense = NetIncomeViewController.convertFromUSD(Double(String(user["expenseTotal"]))!)
            let output:String! = String(latestExpense)
            moneyOut.text = selectedCurrency + " \(output)"
        } catch {
            //
        }
        
    }
    
    func updateOneTimes() {
        query = PFQuery(className: "OneTimes")
        query.whereKey("username", equalTo:(currentUser?.username)!)
        do {
            userArray = try query.findObjects()
            user = userArray[0]
            latestOneTime = NetIncomeViewController.convertFromUSD(Double(String(user["onetimeTotal"]))!)
        } catch {
            //
        }
    }
    
    //Values updated on 11/17/2015
    
    static func convertToUSD(value: Double) -> Int {
        switch (selectedCurrency) {
        case "$":
            return Int(value)
        case "€":
            return Int(value * 1.07)
        case "£":
            return Int(value * 1.52)
        case "¥":
            return Int(value * 0.0081)
        case "C$":
            return Int(value * 0.75)
        default:
            return 0
        }
    }
    
    static func convertFromUSD(value: Double) -> Int {
        switch (selectedCurrency) {
        case "$":
            return Int(value)
        case "€":
            return Int(value / 1.07)
        case "£":
            return Int(value / 1.52)
        case "¥":
            return Int(value / 0.0081)
        case "C$":
            return Int(value / 0.75)
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
