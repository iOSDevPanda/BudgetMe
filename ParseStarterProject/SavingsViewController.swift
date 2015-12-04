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
    
    // Parse set up 
    private var user:PFObject!
    
    // Stuff needed for the Parse Query
    var net:Int = 0
    
    var savingsItems = [SavingsItem]()
    // var curr = 100 // hard code test

    // Adding the progress view
    // var progressView = UIProgressView(progressViewStyle: .Bar)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Parse set up
        let query = PFQuery(className: "SubAccounts")
        query.whereKey("username", equalTo: (currentUser?.username)!)
        do {
            let userArray = try query.findObjects()
            user = userArray[0]
        } catch {
        }
        
        
        // Initializing table
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // Styling the table
        tableView.rowHeight = 200.0
        
        
        // Adding the progress view
        // HERE we are trying this out, currently still trying to figure out this feature
//        progressView.center = tableView.center
//        progressView.trackTintColor = UIColor.lightGrayColor()
//        progressView.tintColor = UIColor.blueColor()
        
        // need to figure out how to put the progress bar in each cell
        // self.view.addSubview(progressView)
        
        
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
                forIndexPath: indexPath) 
            
            cell.textLabel!.numberOfLines = 0
            cell.textLabel!.lineBreakMode = NSLineBreakMode.ByWordWrapping
            
            let item = savingsItems[indexPath.row]
            
            // Before loading cell, update progress 
            updateProgress(item)
            
            let cellData = "\(item.text) \nTotal: \(item.total) \nProgress: \((item.progress)*100)%"
            
            
            cell.textLabel?.text = cellData
            
            if(item.progress < 0.5) {
                cell.textLabel?.textColor = UIColor.redColor()
            } else if(item.progress >= 0.5 && item.progress < 0.75) {
                cell.textLabel?.textColor = UIColor.orangeColor()
            } else if(item.progress >= 0.75 && item.progress < 1) {
                cell.textLabel?.textColor = UIColor.orangeColor()
            } else if(item.progress >= 1) {
                cell.textLabel?.textColor = UIColor.greenColor()
            }
            
            // progressView.progress = updateProgress(item)
            
            return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath
        indexPath: NSIndexPath) -> CGFloat {
            return tableView.rowHeight;
    }
    
    func updateProgress(item:SavingsItem)->Float {
        
        // Calculate net first
//        queryIncomes()
//        queryExpenses()
        
        item.progress = (Float)((Float)(self.net) / (Float)(item.total))
        
        if(item.progress < 0) {
            item.progress = 0
        } else if(item.progress > 1) {
            item.progress = 1
        }
        
        return item.progress
    }
    
    func setViewNet(net: Int) {
        self.net = net
    }

//    // general function to query incomes
//    func queryIncomes() {
//        let in_query = PFQuery(className: "Incomes")
//        in_query.whereKey("username", equalTo:(currentUser?.username)!)
//        do {
//            let userArray = try in_query.findObjects()
//            user = userArray[0]
//            let saltmp = user["salaryAnnual"]
//            if(saltmp != nil) {
//                sal = Int(saltmp as! NSNumber)
//            }
//            let scholtmp = user["scholarshipsAnnual"]
//            if(scholtmp != nil) {
//                schol = Int(scholtmp as! NSNumber)
//            }
//            totIn = sal + schol
//        } catch {
//            //
//        }
//    }
//    
//    // general function query expenses
//    func queryExpenses() {
//        
//        let exp_query = PFQuery(className: "Expenses")
//        exp_query.whereKey("username", equalTo:(currentUser?.username)!)
//        do {
//            let userArray = try exp_query.findObjects()
//            user = userArray[0]
//            let foodtmp = user["foodAnnual"]
//            if(foodtmp != nil) {
//                food = Int(foodtmp as! NSNumber)
//            }
//            let renttmp = user["rentAnnual"]
//            if(renttmp != nil) {
//                food = Int(renttmp as! NSNumber)
//            }
//            let gastmp = user["gasAnnual"]
//            if(gastmp != nil) {
//                food = Int(gastmp as! NSNumber)
//            }
//            let tuitiontmp = user["tuitionAnnual"]
//            if(tuitiontmp != nil) {
//                food = Int(tuitiontmp as! NSNumber)
//            }
//            
//            // Sum them all up!
//            totExp = 15000
//            // totExp = food + rent + gas + tuition
//        } catch {
//            //
//        }
//        
//        
//    }
    
    /*
    /* I am literally so bad at using Parse help
    
    func addSavingsGoals() {
        let savings = PFObject(className: "Savings")
        savings["username"] = 
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    */

}
