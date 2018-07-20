//
//  ViewController.swift
//  uome
//
//  Created by George Hajjar on 2018-05-23.
//  Copyright © 2018 George Hajjar. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    fileprivate lazy var fetchedResultsController: NSFetchedResultsController<Person> = {
        //Create Fetch Request
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()

        //Configure Fetch Request
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]

        //Create Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: DatabaseController.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)

        //Configure Fetched Results Controller
        fetchedResultsController.delegate = self

        return fetchedResultsController
    }()
    
    @IBAction func addParticipant(_ sender: Any) {
        let alert = UIAlertController(title: "Enter name of participant", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addTextField(configurationHandler: { textField in textField.placeholder = "Input your name here..." })
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            if let name = alert.textFields?.first?.text {
                
                //DB START
                let fetchRequest:NSFetchRequest<Person> = Person.fetchRequest()
                
                do {
                    let people = try DatabaseController.persistentContainer.viewContext.fetch(fetchRequest)
                    
                    let query:NSFetchRequest<Person> = Person.fetchRequest()
                    query.predicate = NSPredicate(format: "name = %@", name)
                    let occurances = try DatabaseController.persistentContainer.viewContext.fetch(query)
                    
                    if people.count == 0 {
                        let person:Person = NSEntityDescription.insertNewObject(forEntityName: "Person", into: DatabaseController.persistentContainer.viewContext) as! Person
                        person.name = name
                        person.money = 0.0
                        DatabaseController.saveContext()
                        self.tableView.reloadData()
                        print("Person Added. Empty")
                    }
                    else {
                        if occurances.count != 0 {
                            print("Person not added. Duplicate")
                        }
                        else {
                            let person:Person = NSEntityDescription.insertNewObject(forEntityName: "Person", into: DatabaseController.persistentContainer.viewContext) as! Person
                            person.name = name
                            person.money = 0.0
                            DatabaseController.saveContext()
                            self.tableView.reloadData()
                            print("Person Added. No Duplicate")
                        }
                    }
                }
                catch{
                    print("Error: \(error)")
                }
                
                do{
                    let personArray = try DatabaseController.persistentContainer.viewContext.fetch(fetchRequest)
                    print("number of results: \(personArray.count)")
                    
                    for pers in personArray as [Person]{
                        print("\(pers.name!) has \(pers.money)")
                    }
                }
                catch{
                    print("Error: \(error)")
                }
                //DB END
                
                
//                if DataManager.sharedManager.nameData.isEmpty {
//                    DataManager.sharedManager.nameData.append(name)
//                    DataManager.sharedManager.moneyData.append(0)
//                    self.tableView.reloadData()
//                }
//                else {
//                    if DataManager.sharedManager.nameData.contains(name) {
//                    }
//                    else {
//                        DataManager.sharedManager.nameData.append(name)
//                        DataManager.sharedManager.moneyData.append(0)
//                        self.tableView.reloadData()
//                    }
//                }
            }
        }))
        self.present(alert, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return DataManager.sharedManager.nameData.count
        
//        let fetchRequest:NSFetchRequest<Person> = Person.fetchRequest()
//        do{
//            let searchResults = try DatabaseController.persistentContainer.viewContext.fetch(fetchRequest)
//            return searchResults.count
//        }
//        catch{
//            print("Error: \(error)")
//        }
        
        guard let sections = self.fetchedResultsController.sections else {
            fatalError("No sections in fetchedResultsController")
        }
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Initialize custom cell
        let cell:customTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! customTableViewCell
        
//        if !DataManager.sharedManager.nameData.isEmpty {
//            cell.nameLabel.text = DataManager.sharedManager.nameData[indexPath.row]
//            cell.priceLabel.text = String(format: "$ %.02f", DataManager.sharedManager.moneyData[indexPath.row])
//        }
//        return cell
        
        let fetchRequest:NSFetchRequest<Person> = Person.fetchRequest()
        do{
            let people = try DatabaseController.persistentContainer.viewContext.fetch(fetchRequest)
            
            if people.count != 0 {
                cell.nameLabel.text = people[indexPath.row].name!
                cell.priceLabel.text = String(format: "$ %.02f", people[indexPath.row].money)
            }
        }
        catch{
            print("Error: \(error)")
        }
        return cell
    }
}
