//
//  PreferencesManager.swift
//  CanaryApp
//
//  Created by Tadhg Creedon on 2014-12-02.
//  Copyright (c) 2014 com.tadhgerty. All rights reserved.
//

import Cocoa

public class PreferencesManager: NSObject {

    //value that stores whether the user is a morning lark or night owl
    public enum userIsMorningLark: Int {
        case morningLark = 0
        case nightOwl = 1
    }
    
    //value that determines theme/background colour of tasks table
    public enum theme: Int {
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
   
    public var notifications: Bool
    
    //default values, get updated from database upon opening app in tableviewcontroller
    public var isMorningLark = userIsMorningLark.morningLark
    public var gridTheme = theme.notePad
    //var deleteAnimation = taskDeleteAnimation.poof
    
    public func setIsMorningLark(yesOrNo: Bool)
    {
        if(yesOrNo)
        {
            isMorningLark = userIsMorningLark.morningLark
        }
        else
        {
            isMorningLark = userIsMorningLark.nightOwl
        }
    }
    
    override public init()
    {
        //default value, get updated from database upon opening app in tableviewcontroller
        notifications = true
    }
}
