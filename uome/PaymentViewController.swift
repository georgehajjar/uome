//
//  PaymentViewController.swift
//  uome
//
//  Created by George Hajjar on 2018-05-29.
//  Copyright © 2018 George Hajjar. All rights reserved.
//

import UIKit

class PaymentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var payer = ""
    let cellReuseIdentifier = "cell"
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //self.paidByPickerView.reloadAllComponents()
        self.tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        totalLabel.text = String(format: "$ %.02f", DataManager.sharedManager.total)
    }
    
    //Set text color to white
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let str = DataManager.sharedManager.nameData[row]
        return NSAttributedString(string: str, attributes: [NSAttributedStringKey.foregroundColor:UIColor.white])

    }
    
    //
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //Set data in pickerview
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return DataManager.sharedManager.nameData[row]
    }
    
    //Set number of rows
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return DataManager.sharedManager.nameData.count
    }
    
    //When item is selected in pickerview do...
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        DataManager.sharedManager.payer = DataManager.sharedManager.nameData[row]
        paidByName.text = DataManager.sharedManager.nameData[row]
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.sharedManager.payee.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Initialize custom cell
        let cell:customTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! customTableViewCell
        
        if !DataManager.sharedManager.payee.isEmpty {
            cell.nameLabel.text = DataManager.sharedManager.payee[indexPath.row]
            cell.priceLabel.text = String(format: "$ %.02f", DataManager.sharedManager.payeeAmount[indexPath.row])
        }
        return cell
    }
    
    @IBAction func addPressed(_ sender: UIButton) {
        if paymentTitle.text != "" || !tableView.visibleCells.isEmpty {
            //DataManager.sharedManager.moneyData[DataManager.sharedManager.nameData.index(of: payer)!] = Int(totalMoney.text!)!
            DataManager.sharedManager.historyTitle = paymentTitle.text!
            
            //Handle amount to give to payer
            DataManager.sharedManager.moneyData[DataManager.sharedManager.nameData.index(of: paidByName.text!)!] = DataManager.sharedManager.moneyData[DataManager.sharedManager.nameData.index(of: paidByName.text!)!] + DataManager.sharedManager.total
            
           //Handle amount to give to payee
            for payee in DataManager.sharedManager.payee {
                DataManager.sharedManager.moneyData[DataManager.sharedManager.nameData.index(of: payee)!] = DataManager.sharedManager.moneyData[DataManager.sharedManager.nameData.index(of: payee)!] - DataManager.sharedManager.payeeAmount[DataManager.sharedManager.payee.index(of: payee)!]
            }
        }
        else {
            let alert = UIAlertController(title: "Error", message: "No Payments Added!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)

        }
        
        paymentTitle.text = ""
        paidByName.text = ""
        DataManager.sharedManager.payee.removeAll()
        DataManager.sharedManager.payeeAmount.removeAll()
        DataManager.sharedManager.total = 0
        self.tableView.reloadData()
        totalLabel.text = ""
        
    }
    
}

/*        if !tableView.visibleCells.isEmpty {
 paidByPicker.isUserInteractionEnabled = false
 }*/
