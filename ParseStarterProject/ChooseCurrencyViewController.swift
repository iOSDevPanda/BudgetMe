//
//  ChooseCurrencyViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Steven on 11/17/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit

var selectedCurrency = "$"

class ChooseCurrencyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var currencyArray: [String] = ["$", "€", "£", "¥", "C$"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let currency: String = currencyArray[indexPath.row]
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        cell.textLabel?.text = currency
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyArray.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        let text = cell?.textLabel?.text
        selectedCurrency = text!
        self.performSegueWithIdentifier("unwindToSettings", sender: self)
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
