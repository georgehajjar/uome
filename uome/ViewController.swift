//
//  ViewController.swift
//  uome
//
//  Created by George Hajjar on 2018-05-23.
//  Copyright © 2018 George Hajjar. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var notRepeated = true
    let cellReuseIdentifier = "cell"
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //Initialize table delegates
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        //Initialize customTableViewCell nib
        let nib = UINib(nibName: "customTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "cell")
        
        //Hide Table View
        tableView.tableFooterView = UIView()
        
        
//        //New for DB
//        let person:Person = NSEntityDescription.insertNewObject(forEntityName: "Person", into: DatabaseController.persistentContainer.viewContext) as! Person
//        person.name = "Test"
//        person.money = 10.1
//
//        DatabaseController.saveContext()
//
//        let fetchRequest:NSFetchRequest<Person> = Person.fetchRequest()
//
//        do{
//            let searchResults = try DatabaseController.persistentContainer.viewContext.fetch(fetchRequest)
//            print("number of results: \(searchResults.count)")
//
//            for result in searchResults as [Person]{
//                print("\(result.name!) has \(result.money)")
//            }
//        }
//        catch{
//            print("Error: \(error)")
//        }

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    
    @IBAction func addParticipant(_ sender: Any) {
        let alert = UIAlertController(title: "Enter name of participant", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addTextField(configurationHandler: { textField in textField.placeholder = "Input your name here..." })
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            if let name = alert.textFields?.first?.text {
                
                //DB
                let person:Person = NSEntityDescription.insertNewObject(forEntityName: "Person", into: DatabaseController.persistentContainer.viewContext) as! Person
                person.name = name
                person.money = 0.0
                DatabaseController.saveContext()
                
                let fetchRequest:NSFetchRequest<Person> = Person.fetchRequest()
                
//                //DELETE REQUEST
//                let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
//                do {
//                    try DatabaseController.persistentContainer.viewContext.execute(batchDeleteRequest)
//
//                } catch {
//                    print("Error: \(error)")
//                }
//                
//                //DELETE REQUEST END
                
                do{
                    let searchResults = try DatabaseController.persistentContainer.viewContext.fetch(fetchRequest)
                    print("number of results: \(searchResults.count)")
                    
                    for result in searchResults as [Person]{
                        print("\(result.name!) has \(result.money)")
                    }
                }
                catch{
                    print("Error: \(error)")
                }
                //DB END
                
                if DataManager.sharedManager.nameData.isEmpty {
                    DataManager.sharedManager.nameData.append(name)
                    DataManager.sharedManager.moneyData.append(0)
                    self.tableView.reloadData()
                }
                else {
                    if DataManager.sharedManager.nameData.contains(name) {
                        self.notRepeated = false
                    }
                    else {
                        DataManager.sharedManager.nameData.append(name)
                        DataManager.sharedManager.moneyData.append(0)
                        self.tableView.reloadData()
                    }
                    self.notRepeated = true
                }
            }
        }))
        self.present(alert, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.sharedManager.nameData.count
        //let searchResults = try DatabaseController.persistentContainer.viewContext.fetch(fetchRequest)
        //return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Initialize custom cell
        let cell:customTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! customTableViewCell
        
        if !DataManager.sharedManager.nameData.isEmpty {
            cell.nameLabel.text = DataManager.sharedManager.nameData[indexPath.row]
            cell.priceLabel.text = String(format: "$ %.02f", DataManager.sharedManager.moneyData[indexPath.row])
        }
        return cell
    }
}
