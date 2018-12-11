//
//  PaymentViewController.swift
//  uome
//
//  Created by George Hajjar on 2018-05-29.
//  Copyright © 2018 George Hajjar. All rights reserved.
//

import UIKit
import CoreData

class PaymentViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, NSFetchedResultsControllerDelegate {
    
    let cellReuseIdentifier = "cell"
    
    @IBOutlet weak var addPaymentButton: UIButton!
    @IBOutlet weak var paymentTitle: UITextField!
    @IBOutlet weak var paidByName: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initialize Paid By input picker
        let paidByPickerView = UIPickerView()
        paidByPickerView.delegate = self
        paidByName.inputView = paidByPickerView
        
        //Initialize table delegates
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        //Initialize customTableViewCell nib
        let nib = UINib(nibName: "customTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "cell")
        
        //Hide Table View
        tableView.tableFooterView = UIView()
        
        //Lock add payment button if user did not input payer
        addPaymentButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        totalLabel.text = String(format: "$ %.02f", DataManager.sharedManager.total)
        
        //Lock payer change if user already added a payment
        if !tableView.visibleCells.isEmpty {
            paidByName.isUserInteractionEnabled = false
        }
    }
    
//    //Set text color to white
//    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
//        let str = DataManager.sharedManager.nameData[row]
//        return NSAttributedString(string: str, attributes: [NSAttributedStringKey.foregroundColor:UIColor.white])
//    }
    
    //Number of columns
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //Set data in pickerview
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return DataManager.sharedManager.nameData[row]
        var userName: String = ""
        let fetchRequest:NSFetchRequest<Person> = Person.fetchRequest()
        do{
            let people = try DatabaseController.persistentContainer.viewContext.fetch(fetchRequest)
            userName = people[row].name!
        }
        catch{
            print("Error: \(error)")
        }
        return userName
    }
    
    //Set number of rows
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return DataManager.sharedManager.nameData.count
        var userCount: Int = 0
        let fetchRequest:NSFetchRequest<Person> = Person.fetchRequest()
        do{
            let people = try DatabaseController.persistentContainer.viewContext.fetch(fetchRequest)
            userCount = people.count
        }
        catch{
            print("Error: \(error)")
        }
        return userCount
    }
    
    //When item is selected in pickerview do...
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        DataManager.sharedManager.payer = DataManager.sharedManager.nameData[row]
//        paidByName.text = DataManager.sharedManager.nameData[row]
        let fetchRequest:NSFetchRequest<Person> = Person.fetchRequest()
        var payer: String = ""
        
        do{
            let people = try DatabaseController.persistentContainer.viewContext.fetch(fetchRequest)
            payer = people[row].name!
            
            let history:History = NSEntityDescription.insertNewObject(forEntityName: "History", into: DatabaseController.persistentContainer.viewContext) as! History
            
            history.participants.append(payer)
            DataManager.sharedManager.payer = payer
            history.title = ""
            history.owed.append(1.0)
            
            paidByName.text = payer
        } catch{
            print("Error: \(error)")
        }

        //Unlock add payment button if user inputted payer
        if paidByName.text != "" {
            addPaymentButton.isEnabled = true
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

//extension PaymentViewController : UICollectionViewDelegate {}
//
//extension PaymentViewController : UICollectionViewDataSource {
//    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        <#code#>
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        <#code#>
//    }
//}
    
extension PaymentViewController : UITableViewDelegate {}

extension PaymentViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.sharedManager.payee.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Initialize custom cell
        //let cell:customTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! customTableViewCell
        
        if !DataManager.sharedManager.payee.isEmpty {
            //cell.nameLabel.text = DataManager.sharedManager.payee[indexPath.row]
            //cell.priceLabel.text = String(format: "$ %.02f", DataManager.sharedManager.payeeAmount[indexPath.row])
        }
        return UITableViewCell()
    }
    
    @IBAction func addPressed(_ sender: UIButton) {
        if paymentTitle.text != "" && !tableView.visibleCells.isEmpty {
            
            //Save title
            DataManager.sharedManager.historyTitle = paymentTitle.text!
            
            //Handle amount to give to payer
            DataManager.sharedManager.moneyData[DataManager.sharedManager.nameData.index(of: paidByName.text!)!] = DataManager.sharedManager.moneyData[DataManager.sharedManager.nameData.index(of: paidByName.text!)!] + DataManager.sharedManager.total
            
           //Handle amount to give to payee
            for payee in DataManager.sharedManager.payee {
                DataManager.sharedManager.moneyData[DataManager.sharedManager.nameData.index(of: payee)!] = DataManager.sharedManager.moneyData[DataManager.sharedManager.nameData.index(of: payee)!] - DataManager.sharedManager.payeeAmount[DataManager.sharedManager.payee.index(of: payee)!]
            }
            
            //Alert when payment is added to home screen
            let alert = UIAlertController(title: "Success", message: "Added Payment", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            //Reset everything
            paymentTitle.text = ""
            paidByName.text = ""
            DataManager.sharedManager.payee.removeAll()
            DataManager.sharedManager.payeeAmount.removeAll()
            DataManager.sharedManager.total = 0
            self.tableView.reloadData()
            totalLabel.text = ""
        }
        
        else {
            //Alert when not all fields are filled
            let alert = UIAlertController(title: "Error", message: "Fill Out all Fields!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
