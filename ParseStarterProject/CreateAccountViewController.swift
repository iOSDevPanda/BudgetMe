//
//  CreateAccountViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Steven on 10/6/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class CreateAccountViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var validSignUp = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        username.delegate = self
        email.delegate = self
        password.delegate = self
        //errorMessage.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createAccount(sender: AnyObject) {
        if (username.text != "" && password.text != "" && email.text != "") {
            let user = PFUser()
            user.username = username.text!
            user.password = password.text!
            user.email = email.text!
            //user.contactNumber = contact.text!
                
            user.signUpInBackgroundWithBlock {
                (succeeded: Bool, error: NSError?) -> Void in
                
                if (error == nil) {
                    self.validSignUp = true
                    self.createIncomesRow()
                    self.createExpensesRow()
                    self.createInitialSubAccount()
                    PFUser.logInWithUsernameInBackground(self.username.text!, password: self.password.text!) {
                        (user: PFUser?, error: NSError?) -> Void in
                        currentUser = PFUser.currentUser()
                        currentAccount = self.username.text!
                        self.performSegueWithIdentifier("createAccountToNetIncome", sender: self)
                    }
                } else {
                    print(error?.description)
                    if (error?.code == 202) {
                        //self.errorMessage.text = "That username is already in use."
                    } else if (error?.code == 125) {
                        //self.errorMessage.text = "Your email has an improper format. Use the a@a.com format."
                    }
                }
            }
        } else {
            //errorMessage.text = "Make sure all fields have values!"
        }
        
        self.view.endEditing(true)
    }
    
    func createIncomesRow() {
        let incomes = PFObject(className: "Incomes")
        incomes["username"] = username.text!
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
        expenses["username"] = username.text!
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
    
    func createInitialSubAccount() {
        let subAccount = PFObject(className: "SubAccounts")
        subAccount["username"] = username.text!
        subAccount["subAccount"] = username.text!
        subAccount["contactNumber"] = ""
        subAccount.saveInBackgroundWithBlock {
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
