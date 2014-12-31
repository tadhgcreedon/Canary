//
//  TaskManager.swift
//  CanaryApp
//
//  Created by Tadhg Creedon on 2014-11-13.
//  Copyright (c) 2014 com.tadhgerty. All rights reserved.
//

import Foundation
import Cocoa

class TasksManager: NSObject {
    var tasks: [Task] = []
    var tasksNumber: Int
    
    override init()
    {
        tasksNumber = 0
    }
    
    //adds a new task to the tasks manager
    func addTask(task: Task)
    {
        tasks.append(task)
        tasksNumber++
    }
    
    //adds a previously created task to the tasks manager
    func addCreatedTask(taskname:String, scorenumber: Int)
    {
        //fake values to make a task with
        var fakeEffortNumber:Int
        var fakePriorityNumber:Int
        
        //divide score in half to get fake priority and effort values
        if(scorenumber % 2 == 0)
        {
            fakeEffortNumber = (scorenumber/2)
            fakePriorityNumber = (scorenumber/2)
        }
        else
        {
            fakeEffortNumber = (scorenumber/2)
            fakePriorityNumber = ((scorenumber/2) + 1)
        }
        
        //add the task to the tasks manager
        var newTask = Task(taskName: taskname, priorityNumber: fakePriorityNumber, effortNumber: fakeEffortNumber)
        addTask(newTask)
        
    }
    
    //deletes task at the given array index
    func deleteTask(indexNumber: Int)
    {
        tasks.removeAtIndex(indexNumber)
        tasksNumber--
        println("Task at index \(indexNumber) removed")
        println("Current Tasks: \(tasks)")
    }
    
    //deletes all tasks currently stored in the tasks manager
    func deleteAllTasks()
    {
        tasks = [Task]()
        tasksNumber = 0
    }
    
    func getTaskByRowNumber(rowNumber: Int) -> Task
    {
        return tasks[rowNumber]
    }
    
    //return current number of tasks
    func numberOfTasks() -> Int
    {
        return tasksNumber
    }
    
}