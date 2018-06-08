//
//  DataManager.swift
//  uome
//
//  Created by George Hajjar on 2018-06-06.
//  Copyright © 2018 George Hajjar. All rights reserved.
//

import Foundation

class DataManager {
    
    static let sharedManager = DataManager()
    
    //Hold names of participants
    var nameData = [String]()
    //Hold net amount of each participant. Arrays are linked by index number
    var moneyData = [Int]()
    
    /*For History and Payment tab*/
    
    //Title of payment
    var historyTitle = ""
    //Who paid
    var payer = ""
    //Who got paid for and how much they got paid for
    var payee = [String]()
    var payeeAmount = [Int]()
    //Total paid by payer
    var total = 0
    
}
