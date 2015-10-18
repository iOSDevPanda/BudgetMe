//
//  NetIncomeViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Steven on 10/6/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit

class NetIncomeViewController: UIViewController {
    @IBOutlet weak var moneyIn: UILabel!
    @IBOutlet weak var moneyOut: UILabel!
    @IBOutlet weak var moneyNet: UILabel!
    
    var totIn:Int = 1000
    var totExp:Int = 600
    var net:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func netIncomeUnwind(segue: UIStoryboardSegue) {
    }
    
    @IBAction func calculateNet(sender: AnyObject) {
        // Display the incomes and the expenses 
        moneyIn.text = "$\(totIn)"
        moneyOut.text = "$\(totExp)"
        
        // subtract outflows from inflows
        net = totIn - totExp
        
        moneyNet.text = "$\(net)"
        
        if(net >= 0) {
            moneyNet.textColor = UIColor.redColor()
        } else if(net < 0) {
            moneyNet.textColor = UIColor.greenColor()
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
