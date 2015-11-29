//
//  SavingsItem.swift
//  ParseStarterProject-Swift
//
//  Created by Stephanie Cruz on 11/29/15.
//  Copyright © 2015 Parse. All rights reserved.
//

// Some of this code is modeled after the following online source:
// http://www.raywenderlich.com/77974/making-a-gesture-driven-to-do-list-app-like-clear-in-swift-part-1

import UIKit

class SavingsItem: NSObject {
    // description of item
    var text:String
    
    // boolean indicating if item is done
    var completed:Bool
    
    // total amount 
    var total:Int
    
    // progress amount
    var progress:Double
    
    // initializes item
    init(text:String, total:Int) {
        self.text = text
        self.completed = false
        self.total = total
        self.progress = 0
    }

}
