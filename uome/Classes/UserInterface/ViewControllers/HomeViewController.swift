//
//  HomeViewController.swift
//  uome
//
//  Created by George Hajjar on 2018-05-23.
//  Copyright © 2018 George Hajjar. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.homeCollectionView.reloadData()
    }
    
    func setUpCollectionView() {
        //Initialize table delegates
        self.homeCollectionView.delegate = self;
        self.homeCollectionView.dataSource = self;
        
        //Initialize customCollectionViewCell
        customCollectionViewCell.register(with: homeCollectionView)
        
        //Disable Scroll Bars
        homeCollectionView.showsVerticalScrollIndicator = false
        homeCollectionView.showsHorizontalScrollIndicator = false
        
        //Set vertical scroll direction
        if let layout = homeCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
        }
    }
    
    fileprivate lazy var fetchedResultsController: NSFetchedResultsController<Person> = {
        //Create Fetch Request
        let fetchRequest:NSFetchRequest<Person> = Person.fetchRequest()

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
                
                do {
                    let query:NSFetchRequest<Person> = Person.fetchRequest()
                    query.predicate = NSPredicate(format: "name = %@", name)
                    let occurances = try DatabaseController.persistentContainer.viewContext.fetch(query)
                    
                    if occurances.count != 0 {
                        let errorAlert = UIAlertController(title: "Duplicate participant not added", message: nil, preferredStyle: .alert)
                        errorAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                        self.present(errorAlert, animated: true)
                        return
                    }
                    else {
                        let person:Person = NSEntityDescription.insertNewObject(forEntityName: "Person", into: DatabaseController.persistentContainer.viewContext) as! Person
                        person.name = name
                        person.money = 0.0
                        
//                        let history:History = NSEntityDescription.insertNewObject(forEntityName: "History", into: DatabaseController.persistentContainer.viewContext) as! History
//                        history.title = "Test1"
//                        history.participants.append(person.name!)
//                        history.owed.append(person.money)
                        
                        DatabaseController.saveContext()
                        self.homeCollectionView.reloadData()
                    }
                } catch{
                    print("Error: \(error)")
                }
                
                let fetchRequest:NSFetchRequest<Person> = Person.fetchRequest()
                
                do{
                    let personArray = try DatabaseController.persistentContainer.viewContext.fetch(fetchRequest)
                    print("number of people: \(personArray.count)")

                    for pers in personArray as [Person]{
                        print("\(pers.name!) has \(pers.money)")
                    }
                } catch{
                    print("Error: \(error)")
                }
                
//                let historyFetchRequest:NSFetchRequest<History> = History.fetchRequest()
//
//                do{
//                    let historyArray = try DatabaseController.persistentContainer.viewContext.fetch(historyFetchRequest)
//                    print("number of history: \(historyArray.count)")
//
//                    for pers in historyArray as [History]{
//                        print("Tile of Payment: \(pers.title!)")
//                        for i in 1...pers.participants.count{
//                            print(pers.participants[i-1])
//                        }
//                        for i in 1...pers.owed.count{
//                            print(pers.owed[i-1])
//                        }
//                    }
//                } catch{
//                    print("Error: \(error)")
//                }
            }
        }))
        self.present(alert, animated: true)
    }
}

extension HomeViewController : UICollectionViewDelegate {}

extension HomeViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let fetchRequest:NSFetchRequest<Person> = Person.fetchRequest()
        do{
            let searchResults = try DatabaseController.persistentContainer.viewContext.fetch(fetchRequest)
            return searchResults.count
        } catch{
            print("Error: \(error)")
        }
        
        guard let sections = self.fetchedResultsController.sections else {
            //assertionFailure("No sections in fetchedResultsController")
            return 0
        }
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //Initialize custom cell
        guard let collectionViewCell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: customCollectionViewCell.identifier, for: indexPath) as? customCollectionViewCell else {
            assertionFailure("cellForRowAt error")
            return UICollectionViewCell()
        }
        
        let fetchRequest:NSFetchRequest<Person> = Person.fetchRequest()
        do{
            let people = try DatabaseController.persistentContainer.viewContext.fetch(fetchRequest)
            
            if people.count != 0 {
                collectionViewCell.nameLabel.text = people[indexPath.row].name!
                collectionViewCell.priceLabel.text = String(format: "$ %.02f", people[indexPath.row].money)
            }
            else {
                return UICollectionViewCell()
            }
        } catch{
            print("Error: \(error)")
        }
        
        return collectionViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 50)
    }
}
