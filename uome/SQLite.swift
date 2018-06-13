//
//  SQLite.swift
//  uome
//
//  Created by George Hajjar on 2018-06-12.
//  Copyright © 2018 George Hajjar. All rights reserved.
//

import Foundation
import SQLite3

class SQLite {
    
    var db: OpaquePointer?
        
    let fileurl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("HeroDatabase.sqlite")
    
    if sqlite3_open(fileurl.path, &db) != SQLITE_OK {
        print("Error opening database")
        return
    }
    
    let createTableQuery = "CREATE TABLE IF NOT EXISTS Heros (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, powerrank INTEGER)"
    
    if sqlite3_exec(db, createTableQuery, nil, nil, nil) != SQLITE_OK {
        print("Error creating table")
        return
    }
    
    print("Everything is fine")
}
