//
//  SavingsViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Stephanie Cruz on 11/29/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class SavingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var savingsItems = [SavingsItem]()
    var curr = 500 // hardcode test
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initializing table
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // Styling the table
        tableView.rowHeight = 100.0
        
        
        if savingsItems.count > 0 {
            return // don't need to initialize again
        }

        // initialize the list
        savingsItems.append(SavingsItem(text: "New Car", total: 15000))
        savingsItems.append(SavingsItem(text: "iPhone 6s", total: 200))
        savingsItems.append(SavingsItem(text: "Ukelele", total: 100))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savingsItems.count
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("cell",
                forIndexPath: indexPath) as! UITableViewCell
            
            cell.textLabel!.numberOfLines = 0
            cell.textLabel!.lineBreakMode = NSLineBreakMode.ByWordWrapping
            
            let item = savingsItems[indexPath.row]
            
            // Before loading cell, update progress 
            updateProgress(item)
            
            cell.textLabel?.text = "\(item.text) \nTotal: \(item.total) \nProgress: \(item.progress)%"
            return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath
        indexPath: NSIndexPath) -> CGFloat {
            return tableView.rowHeight;
    }
    
    func updateProgress(item:SavingsItem) {
        item.progress = (Double)((Double)(self.curr) / (Double)(item.total)) * 100.0
        
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
