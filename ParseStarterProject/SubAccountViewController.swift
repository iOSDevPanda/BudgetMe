//
//  SubAccountViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Steven on 10/29/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class SubAccountViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var users = [PFObject]()
    var selectedUser: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let userInfo:PFObject = users[indexPath.row] as PFObject
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        cell.textLabel?.text = String(userInfo["subAccount"])
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        let text = cell?.textLabel?.text
        selectedUser = text!
    }

    @IBAction func subAccountUnwind(segue: UIStoryboardSegue) {
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
