/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse

var currentUser = PFUser.currentUser()

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logIn(sender: AnyObject) {
        if (username.text != "" && password.text != "") {
            PFUser.logInWithUsernameInBackground(username.text!, password: password.text!) {
                (user: PFUser?, error: NSError?) -> Void in
                if user != nil {
                    currentUser = PFUser.currentUser()
                    self.performSegueWithIdentifier("logInToNetIncome", sender: self)
                } else {
                    //self.errorMessage.text = "Make sure you are using the correct username and password"
                }
            }
        } else {
            //errorMessage.text = "Make sure all fields have values!"
        }
        self.view.endEditing(true)
    }
    
    @IBAction func logOutUnwind(segue: UIStoryboardSegue) {
        PFUser.logOutInBackground()
        currentUser = PFUser.currentUser()
        username.text = ""
        password.text = ""
        //errorMessage.text = ""
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        self.view.endEditing(true)
    }
}
