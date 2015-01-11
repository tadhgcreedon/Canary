//
//  TaskTests.swift
//  Canary
//
//  Created by Tadhg Creedon on 2014-12-31.
//  Copyright (c) 2014 com.tadhgcreedon. All rights reserved.
//

import Cocoa
import XCTest

class TaskTest: XCTestCase {
    var taskName:String
    var priorityNumber:Int
    var effortNumber:Int
    
    var task: Task
    
    override func setUp() {
        super.setUp()
        
        taskName = "test1"
        priorityNumber = 1
        effortNumber = 1

    }

    //checks that init works properly
    func initTest() {
        task = Task(taskName, priorityNumber, effortNumber)
        XCTAssert((task.taskName = "test1"), "Pass")
        XCTAssert((task.priorityNumber == 1), "Pass")
        XCTAssert((task.effortNumber == 1), "Pass")
        XCTAssert((task.scoreNumber == 2), "Pass")
        
        taskName = "test2"
        priorityNumber = 4
        effortNumber = 3
        task = Task(taskName, priorityNumber, effortNumber)
        XCTAssert((task.taskName == "test2"), "Pass")
        XCTAssert((task.priorityNumber == 4), "Pass")
        XCTAssert((task.effortNumber == 3), "Pass")
        XCTAssert((task.scoreNumber == 7), "Pass")
        
    }
}
