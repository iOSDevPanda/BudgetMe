//
//  CreateSubAccountViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Steven on 10/29/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class CreateSubAccountViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func createSubAccount(sender: AnyObject) {
        if (username.text != "") {
            createSubAccount()
        } else {
            //errorMessage.text = "Make sure all fields have values!"
            print("Make sure all fields have values!")
        }
        self.view.endEditing(true)
        //create subaccount in SubAccount DB
        //create incomes and expenses rows
    }
    
    func createIncomesRow() {
        let incomes = PFObject(className: "Incomes")
        incomes["username"] = currentUser?.username
        incomes["subAccount"] = username.text!
        incomes["salaryAnnual"] = 0
        incomes["scholarshipsAnnual"] = 0
        incomes.saveInBackgroundWithBlock {
            (success: Bool, error:NSError?) -> Void in
            if(success) {
                print("Saved")
            }
            else {
                print("Error")
            }
        }
    }
    func createExpensesRow() {
        let expenses = PFObject(className: "Expenses")
        expenses["username"] = currentUser?.username
        expenses["subAccount"] = username.text!
        expenses["gasAnnual"] = 0
        expenses["foodAnnual"] = 0
        expenses["tuitionAnnual"] = 0
        expenses["rentAnnual"] = 0
        expenses.saveInBackgroundWithBlock {
            (success: Bool, error:NSError?) -> Void in
            if(success) {
                print("Saved")
            }
            else {
                print("Error")
            }
        }
    }

    func createSubAccount() {
        let subAccount = PFObject(className: "SubAccounts")
        subAccount["username"] = currentUser?.username
        subAccount["subAccount"] = username.text!
        subAccount.saveInBackgroundWithBlock {
            (success: Bool, error:NSError?) -> Void in
            if(success) {
                print("Saved")
                self.createExpensesRow()
                self.createIncomesRow()
            }
            else {
                print("Error")
            }
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
