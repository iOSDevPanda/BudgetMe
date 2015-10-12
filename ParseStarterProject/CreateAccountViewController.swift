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
            
            user.signUpInBackgroundWithBlock {
                (succeeded: Bool, error: NSError?) -> Void in
                
                if (error == nil) {
                    self.validSignUp = true
                    PFUser.logInWithUsernameInBackground(self.username.text!, password: self.password.text!) {
                        (user: PFUser?, error: NSError?) -> Void in
                        currentUser = PFUser.currentUser()
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
