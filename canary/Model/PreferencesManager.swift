//
//  PreferencesManager.swift
//  CanaryApp
//
//  Created by Tadhg Creedon on 2014-12-02.
//  Copyright (c) 2014 com.tadhgerty. All rights reserved.
//

import Cocoa

class PreferencesManager: NSObject {

    //value that stores whether the user is a morning lark or night owl
    enum userIsMorningLark: Int {
        case morningLark = 0
        case nightOwl = 1
    }
    
    //value that determines theme/background colour of tasks table
    enum theme: Int {
        case notePad = 0
        case blankCanvas = 1
        case terminal = 2
    }
    
    /* Not implemented yet
    //value that determines what animation occurs upon deleting a task
    enum taskDeleteAnimation: Int {
        case poof = 0
        case laser = 1
        case none = 2
    }
    */
   
    var notifications: Bool
    
    //default values, get updated from database upon opening app in tableviewcontroller
    var isMorningLark = userIsMorningLark.morningLark
    var gridTheme = theme.notePad
    //var deleteAnimation = taskDeleteAnimation.poof
    
    override init()
    {
        //default value, get updated from database upon opening app in tableviewcontroller
        notifications = true
    }
}
