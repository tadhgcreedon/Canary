//
//  Task.swift
//  Toucan
//
//  Created by Tadhg Creedon on 2014-11-13.
//  Copyright (c) 2014 com.tadhgerty. All rights reserved.
//

import Foundation
import Cocoa

class Task: NSObject {
    var taskName:String
    var priorityNumber:Int
    var effortNumber:Int
    var scoreNumber:Int
    
    init(taskName: String, priorityNumber: Int, effortNumber: Int)
    {
        self.taskName = taskName
        self.priorityNumber = priorityNumber
        self.effortNumber = effortNumber
        scoreNumber = priorityNumber + effortNumber
    }
}