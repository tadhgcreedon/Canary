//
//  TasksManagerTest.swift
//  Canary
//
//  Created by Tadhg Creedon on 2014-12-31.
//  Copyright (c) 2014 com.tadhgcreedon. All rights reserved.
//

import Cocoa
import XCTest

class TasksManagerTest: XCTestCase {
    
    var tasks: [Task] = []
    var tasksNumber: Int
    
    var tasksManager1: TasksManager
    
    var task1: Task
    var task2: Task
    var task3: Task
    
    override func setUp() {
        super.setUp()
        tasksManager1 = TaskManager()
        
        task1 = Task("test1", 1, 1)
        task2 = Task("test2", 2, 2)
        task3 = Task("test3", 3, 3)
    }
    
    //checks that init works properly
    func initTest() {
        var tasksManager2 = TaskManager()
        XCTAssert((tasksManager2.tasksNumber == 0), "Pass")
    }
    
    //checks that TasksManager adds a task properly
    func addTaskTest() {
        
        tasksManager1.addTask(task1)
        XCTAssert((tasksManager1.tasks[0].taskName == "test1"), "Pass")
        XCTAssert((tasksManager1.tasks[0].priorityNumber == 1), "Pass")
        XCTAssert((tasksManager1.tasks[0].effortNumber == 1), "Pass")
        XCTAssert((tasksManager1.tasksNumber == 1), "Pass")
        
        tasksManager1 = TaskManager()
    }
    
    //checks that TasksManager adds a created task properly
    func addCreatedTaskTest() {
        
        tasksManager1.addCreatedTask("test4", 6)
        taskManager1.tasks[0].taskName = "test4"
        taskManager1.tasks[0].scoreNumber = 6
        
        tasksManager1 = TaskManager()
    }
    
    
    //checks that TasksManager deletes a task properly
    func deleteTaskTest() {
        tasksManager1.addTask(task1)
        tasksManager1.addTask(task2)
        tasksManager1.addTask(task3)
        XCTAssert((tasksManager1.tasksNumber = 3), "Pass")
        
        tasksManager1.deleteTask(2)
        XCTAssert((tasksManager1.tasksNumber == 2), "Pass")
        XCTAssert((tasksManager1.tasks[0] == task1), "Pass")
        XCTAssert((tasksManager1.tasks[1] == task3), "Pass")
        
        tasksManager1 = TaskManager()
    }
    
    //checks that TasksManager deletes all tasks properly
    func deleteAllTasksTest() {
        tasksManager1.addTask(task1)
        tasksManager1.addTask(task2)
        tasksManager1.addTask(task3)
        XCTAssert((tasksManager1.tasksNumber = 3), "Pass")
        
        tasksManager1.deleteAllTasks()
        XCTAssert((tasksManager1.tasksNumber == 0), "Pass")
        XCTAssert((tasksManager1.tasks == Task[]), "Pass")
        
        tasksManager1 = TaskManager()
    }
    
    //checks that TasksManager gets task by row number/index properly
    func getTaskByRowNumberTest() {
        tasksManager1.addTask(task1)
        tasksManager1.addTask(task2)
        tasksManager1.addTask(task3)
        
        XCTAssert((tasksManager1.getTaskByRowNumber(1) == task1), "Pass")
        XCTAssert((tasksManager1.getTaskByRowNumber(2) == task1), "Pass")
        XCTAssert((tasksManager1.getTaskByRowNumber(3) == task1), "Pass")
    }
    
    //checks that TasksManager gets number of tasks properly
    func getTaskByRowNumberTest() {
        tasksManager1.addTask(task1)
        XCTAssert((tasksManager1.numberOfTasks() == 1), "Pass")
        
        tasksManager1.addTask(task2)
        XCTAssert((tasksManager1.numberOfTasks == 2), "Pass")
        
        tasksManager1.addTask(task3)
        XCTAssert((tasksManager1.numberOfTasks == 3), "Pass")
        
        taskManager1.deleteTask(1)
        XCTAssert((tasksManager1.numberOfTasks == 2), "Pass")
        
        taskManager1.deleteTask(1)
        XCTAssert((tasksManager1.numberOfTasks == 1), "Pass")
        
        taskManager1.deleteAllTasks()
        XCTAssert((tasksManager1.numberOfTasks == 0), "Pass")
    }
    
}
