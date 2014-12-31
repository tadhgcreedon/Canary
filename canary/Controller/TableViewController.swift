//
//  TableViewController.swift
//  Canary
//
//  Created by Tadhg Creedon on 2014-12-10.
//  Copyright (c) 2014 com.tadhgcreedon. All rights reserved.
//

import Cocoa
import CoreData

class TableViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    
    //table that displays tasks
    @IBOutlet weak var tableView: NSTableView!
    //a popover menu for selecting task name, effort and priority
    @IBOutlet weak var taskAttributes: NSPopover!
    //popover text outlet
    @IBOutlet weak var taskNameText: NSTextField!
    //popover priority outlet
    @IBOutlet weak var taskPriorityNumberSelector: NSPopUpButton!
    //popover effort outlet
    @IBOutlet weak var taskEffortNumberSelector: NSPopUpButton!
    //new task button outlet
    @IBOutlet weak var newTaskButton: NSButton!
    //edit tasks button outlet
    @IBOutlet weak var editTasksButton: NSButton!
    
    
    
    //delete column for table view
    @IBOutlet weak var deleteColumn: NSTableColumn!
    
    //holds array of tasks + helper methods
    var tasksManager = TasksManager()
    
    //holds all user preferences
    var preferencesManager = PreferencesManager()
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        println("Current Tasks: \(tasksManager.tasks)")
        //hides cell deletion colum
        deleteColumn.hidden = true
        
        //core data stuff start
        
        
        var appDelegate: AppDelegate = (NSApplication.sharedApplication().delegate as AppDelegate)
        var context: NSManagedObjectContext! = appDelegate.managedObjectContext
        
        var request = NSFetchRequest(entityName: "Task")
        request.returnsObjectsAsFaults = false
        
        var results:NSArray! = context.executeFetchRequest(request, error:nil)
        
        // Load tasks
        if(results.count > 0)
        {
            for result in results {
                var tasknamed: String = result.valueForKey("taskName") as String
                var scorenum: Int = result.valueForKey("scoreNumber") as Int
                tasksManager.addCreatedTask(tasknamed, scorenumber: scorenum)
                
                println("loaded task \(tasknamed) in to tasks manager")
            }
        }
        else
        {
            println("0 results, no tasks or potential error")
        }
        
        
        //Load preferences
        
        request = NSFetchRequest(entityName: "Preferences")
        //request.returnsObjectsAsFaults = false
        
        var results2:NSArray! = context.executeFetchRequest(request, error:nil)
        
        if(results2.count > 0)
        {
            if(results2[0].valueForKey("morningLark") as Bool == false)
            {
                preferencesManager.isMorningLark = PreferencesManager.userIsMorningLark.nightOwl
            }
            
            if(results2[0].valueForKey("theme") as Int == 2)
            {
                preferencesManager.gridTheme = PreferencesManager.theme.blankCanvas
            }
            else
            {
                if(results2[0].valueForKey("theme") as Int == 3)
                {
                    preferencesManager.gridTheme = PreferencesManager.theme.terminal
                }
                
            }
        }
        
        /* Notifications not yet implemented
        if(results2[0].valueForKey("notifications") as Bool == false)
        {
        preferencesManager.notifications = false
        }
        */
        
        //core data stuff end
        
        //sort by score number
        tasksManager.tasks.sort({ $0.scoreNumber > $1.scoreNumber })
        
        //set grid theme
        
        //update table
        
        tableView.reloadData()
        println("Current Tasks: \(tasksManager.tasks)")
        
    }
    
    //opens new task menu
    //TODO user input of score and name
    @IBAction func newTask(sender: NSButton)
    {
        taskAttributes.showRelativeToRect(sender.bounds, ofView: sender, preferredEdge: 0)
    }
    
    //used when user clicks "new task" from menu
    @IBAction func menuNewTask(sender: NSMenuItem) {
        taskAttributes.showRelativeToRect(newTaskButton.bounds, ofView: newTaskButton, preferredEdge: 0)
    }
    
    
    //enters new task into tasks manager
    @IBAction func createNewTask(sender: NSButton)
    {
        if(taskNameText.stringValue == "")
        {
            var enterATaskNameAlert:NSAlert! = NSAlert()
            enterATaskNameAlert.messageText = "Please enter a task name to create a task."
            enterATaskNameAlert.informativeText = "e.g. \"Write last 3 chapters of my novel\""
            enterATaskNameAlert.runModal()
            
            return
        }
        var taskname = taskNameText.stringValue
        var prioritynum = taskPriorityNumberSelector.titleOfSelectedItem
        var effortnum = taskEffortNumberSelector.titleOfSelectedItem
        var pn = popUpButtonNumber(prioritynum!)
        var en = popUpButtonNumber(effortnum!)
        var newTask = Task(taskName: taskname, priorityNumber: pn, effortNumber: en)
        tasksManager.addTask(newTask)
        
        //close popover + reset values
        taskAttributes.close()
        
        //update table
        tableView.reloadData()
        
        //core data stuff start
        
        var appDelegate: AppDelegate = (NSApplication.sharedApplication().delegate as AppDelegate)
        var context: NSManagedObjectContext! = appDelegate.managedObjectContext
        
        var aNewTask = NSEntityDescription.insertNewObjectForEntityForName("Task", inManagedObjectContext: context) as NSManagedObject
        aNewTask.setValue(newTask.taskName, forKey: "taskName")
        aNewTask.setValue(newTask.scoreNumber, forKey: "scoreNumber")
        context.save(nil)
        
        println(aNewTask)
        println("Task Saved")
        
        //core data stuff end
        
        //reset input values
        taskNameText.stringValue = ""
        taskPriorityNumberSelector.setTitle("1")
        taskEffortNumberSelector.setTitle("1")
        
        //console confirmation for debugging
        println("\(newTask.taskName) added to Tasks Manager")
    }
    
    //cancels create new task by closing popover
    @IBAction func cancelCreateNewTask(sender: NSButton)
    {
        //close popover
        taskAttributes.close()
        
        //reset input values
        taskNameText.stringValue = ""
        taskPriorityNumberSelector.setTitle("1")
        taskEffortNumberSelector.setTitle("1")
    }
    
    //shows delete buttons and enables the user to edit task name and score
    @IBAction func editTasks(sender: NSButton) {
        //if there are no tasks
        if(tasksManager.tasksNumber == 0)
        {
            var enterATaskAlert:NSAlert! = NSAlert()
            enterATaskAlert.messageText = "Please enter a task."
            enterATaskAlert.informativeText = "e.g. \"Finish my essay about great white sharks\""
            enterATaskAlert.runModal()
            return
        }
        
        //check if able to edit/if so, change button title to "Done" and vice versa
        if(sender.title != "Done")
        {
            deleteColumn.hidden = false;
            sender.title = "Done"
        }
        else
        {
            deleteColumn.hidden = true;
            sender.title = "..."
        }
    }
    
    //When user calls Edit Tasks from menu
    @IBAction func menuEditTasks(sender: NSMenuItem) {
        editTasks(editTasksButton)
    }
    
    
    //Deletes the task belonging to the delete button pressed
    @IBAction func tableDeleteButton(sender: NSButtonCell) {
        //Core data delete
        
        //tasks manager delete
        //get button row number
        var rowToDelete:Int = tableView.clickedRow
        println(rowToDelete)
        var deleteTask: Task = tasksManager.tasks[rowToDelete]
        tasksManager.deleteTask(rowToDelete)
        
        //Core Data Stuff start
        
        var appDelegate: AppDelegate = (NSApplication.sharedApplication().delegate as AppDelegate)
        var context: NSManagedObjectContext! = appDelegate.managedObjectContext
        
        var request = NSFetchRequest(entityName: "Task")
        request.returnsObjectsAsFaults = false
        
        var results:NSArray! = context.executeFetchRequest(request, error:nil)
        
        var taskToDelete:NSManagedObject = results[rowToDelete] as NSManagedObject
        context.deleteObject(taskToDelete)
        
        //Core Data stuff end
        
        tableView.reloadData()
        
        
        //close menu if there are no more tasks to edit
        if(tasksManager.tasksNumber == 0)
        {
            deleteColumn.hidden = true;
            editTasksButton.title = "..."
        }
    }
    
    //deletes all tasks created by the user
    @IBAction func menuDeleteAllTasks(sender: NSMenuItem)
    {
        tasksManager.deleteAllTasks()
        
        //core data stuff start
        
        var appDelegate: AppDelegate = (NSApplication.sharedApplication().delegate as AppDelegate)
        var context: NSManagedObjectContext! = appDelegate.managedObjectContext
        
        var request = NSFetchRequest(entityName: "Task")
        request.returnsObjectsAsFaults = false
        
        var results:NSArray! = context.executeFetchRequest(request, error:nil)
        
        if(results.count > 0)
        {
            for result in results {
                var tasknamed: String = result.valueForKey("taskName") as String
                var res:NSManagedObject = result as NSManagedObject
                context.deleteObject(res)
                
                println("Task \(tasknamed) Deleted")
            }
        }
        else
        {
            println("0 results, no tasks or potential error; nothing to delete")
        }
        
        
        context.save(nil)
        
        
        
        //core data stuff end
        
        //close popover + reset values
        taskAttributes.close()
        //update table
        tableView.reloadData()
        //console confirmation for testing
        println("Deleted all tasks")
    }
    
    
    //helper method that returns int value of selector string value.
    //this is pretty shitty so find a better way at some point
    func popUpButtonNumber(number: String) -> Int
    {
        if(number == "1")
        {
            return 1
        }
        else if(number == "2")
        {
            return 2
        }
        else if(number == "3")
        {
            return 3
        }
        else if(number == "4")
        {
            return 4
        }
        else if(number == "5")
        {
            return 5
        }
        else if(number == "6")
        {
            return 6
        }
        else if(number == "7")
        {
            return 7
        }
        else if(number == "8")
        {
            return 8
        }
        else if(number == "9")
        {
            return 9
        }
        else
        {
            return -1
        }
    }
    
    //required method of NSTableViewDataSource -> returns number of rows in table
    func numberOfRowsInTableView(aTableView: NSTableView!) -> Int
    {
        let numberOfRows:Int = tasksManager.numberOfTasks()
        return numberOfRows
    }
    
    //required method of NSTableViewDataSource
    func tableView(tableView: NSTableView!, objectValueForTableColumn tableColumn: NSTableColumn!, row: Int) -> AnyObject!
    {
        //var newString = getDataArray().objectAtIndex(row).objectForKey(tableColumn.identifier)
        
        var obj: String
        if(tableColumn.identifier == "Task")
        {
            if(tasksManager.tasksNumber != 0)
            {
                return tasksManager.getTaskByRowNumber(row).taskName
            }
            else
            {
                return ""
            }
        }
        else if(tableColumn.identifier == "Score")
        {
            if(tasksManager.tasksNumber != 0)
            {
                return tasksManager.getTaskByRowNumber(row).scoreNumber
            }
            else
            {
                return ""
            }
        }
        else
        {
            return "error"
        }
    }
    
    
    //prevents column reordering
    func tableView(inTableView: NSTableView, mouseDownInHeaderOfTableColumn: NSTableColumn)
    {
        inTableView.allowsColumnReordering = false
    }
    
    func setGridTheme(bgColour: NSColor, linesColour: NSColor)
    {
        //set grid colours
        tableView.backgroundColor = bgColour
        tableView.gridColor = linesColour
    }
    
}