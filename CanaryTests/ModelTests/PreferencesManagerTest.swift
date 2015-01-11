//
//  File.swift
//  Canary
//
//  Created by Tadhg Creedon on 2014-12-31.
//  Copyright (c) 2014 com.tadhgcreedon. All rights reserved.
//

import Cocoa
import XCTest

class PreferencesManagerTest: XCTestCase {
    //enum var's
    var morningLark: Int
    var nightOwl: Int
    
    var notePad: Int
    var blankCanvas: Int
    var terminal: Int
    
    var PreferencesManager: PreferencesManager
    
    override func setUp() {
        super.setUp()

        morningLark = PreferencesManager.userIsMorningLark.morningLark
        nightOwl = PreferencesManager.userIsMorningLark.nightOwl
        
        notePad = PreferencesManager.theme.notePad
        blankCanvas = PreferencesManager.theme.blankCanvas
        terminal = PreferencesManager.theme.terminal
        
    }
    
    //checks to make sure enums work properly
    func enumTest() {
        XCTAssert((morningLark == 1), "Pass")
        XCTAssert((nightOwl == 2), "Pass")
        XCTAssert((notePad == 1), "Pass")
        XCTAssert((blankCanvas == 2), "Pass")
        XCTAssert((terminal == 3), "Pass")
    }
    
    //checks that init works properly
    func initTest() {
        PreferencesManager = PreferencesManager()
        XCTAssert((preferencesManager.notifications), "Pass")
    }
}