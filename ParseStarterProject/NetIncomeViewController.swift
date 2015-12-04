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
    
    var totIn:Int = 0
    var totExp:Int = 0
    var net:Int = 0
    
    var sal:Int = 0
    var schol:Int = 0
    var food:Int = 0
    var rent:Int = 0
    var gas:Int = 0
    var tuition:Int = 0
    var onetime:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewExp(globExp)
        
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
    
    @IBAction func calculateNet(sender: AnyObject) {
        queryIncomes()
        // queryExpenses()
        
        // Display the incomes and the expenses
        moneyIn.text = "$\(totIn)"
        moneyOut.text = "$\(globExp)"
        
        // subtract outflows from inflows
        net = totIn - globExp + onetime
        
        moneyNet.text = "$\(net)"
        
        if(net >= 0) {
            moneyNet.textColor = UIColor.greenColor()
        } else if(net < 0) {
            moneyNet.textColor = UIColor.redColor()
        }
    }
    
    // general function to query incomes
    func queryIncomes() {
        let in_query = PFQuery(className: "Incomes")
        in_query.whereKey("username", equalTo:(currentUser?.username)!)
        do {
            let userArray = try in_query.findObjects()
            user = userArray[0]
            let saltmp = user["salaryAnnual"]
            if(saltmp != nil) {
                sal = Int(saltmp as! NSNumber)
            }
            let scholtmp = user["scholarshipsAnnual"]
            if(scholtmp != nil) {
                schol = Int(scholtmp as! NSNumber)
            }
            totIn = sal + schol
        } catch {
            //
        }
    }
    
    // general function query expenses
    /*func queryExpenses() {
        
        let exp_query = PFQuery(className: "Expenses")
        exp_query.whereKey("username", equalTo:(currentUser?.username)!)
        do {
            let userArray = try exp_query.findObjects()
            user = userArray[0]
            let foodtmp = user["foodAnnual"]
            if(foodtmp != nil) {
                food = Int(foodtmp as! NSNumber)
            }
            let renttmp = user["rentAnnual"]
            if(renttmp != nil) {
                food = Int(renttmp as! NSNumber)
            }
            let gastmp = user["gasAnnual"]
            if(gastmp != nil) {
                food = Int(gastmp as! NSNumber)
            }
            let tuitiontmp = user["tuitionAnnual"]
            if(tuitiontmp != nil) {
                food = Int(tuitiontmp as! NSNumber)
            }
            
            // Sum them all up!
            totExp = food + rent + gas + tuition
        } catch {
            //
        }
        
        
    }*/
    
    func setViewExp(totExp: Int) {
        self.totExp = totExp
    }
    
    // Should probably figure this out
    //        let onetime_query = PFQuery(className: "OneTimes")
    //        onetime_query.whereKey("username", equalTo:(currentUser?.username)!)
    //        do {
    //            let userArray = try onetime_query.findObjects()
    //            user = userArray[0]
    //            let onetmp = user["oneTime"]
    //            if(onetmp != nil) {
    //                onetime = Int(onetmp as! NSNumber)
    //            }
    //        } catch {
    //            //
    //        }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
