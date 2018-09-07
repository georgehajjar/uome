//
//  SettingsViewController.swift
//  uome
//
//  Created by George Hajjar on 2018-07-12.
//  Copyright © 2018 George Hajjar. All rights reserved.
//

import UIKit
import CoreData

class SettingsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func clearPersonClass(_ sender: Any) {
        let fetchRequest:NSFetchRequest<Person> = Person.fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        do {
            try DatabaseController.persistentContainer.viewContext.execute(batchDeleteRequest)
            
        } catch {
            print("Error: \(error)")
        }
    }
    
}
