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

    @IBOutlet weak var currency: UILabel!
    @IBOutlet weak var amount: UITextField!
    
    var oneTimeData = 0
    var user : PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let query = PFQuery(className: "OneTimes")
        query.whereKey("username", equalTo: (currentUser?.username)!)
        query.whereKey("subAccount", equalTo: currentAccount)
        do {
            let userArray = try query.findObjects()
            user = userArray[0]
        } catch {
            //
        }
        
        amount.text = "0"
        currency.text = selectedCurrency
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func income(sender: AnyObject) {
        if(amount.text! != "") {
            upload(Double(amount.text!)!)
        }
    }
    
    @IBAction func expense(sender: AnyObject) {
        if(amount.text! != "") {
            upload(0-Double(amount.text!)!)
        }
    }
    
    func upload(value: Double) {
        user["onetimeTotal"] = NetIncomeViewController.convertToUSD(Double(user["onetimeTotal"] as! NSNumber)) + NetIncomeViewController.convertToUSD(value)
        
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
