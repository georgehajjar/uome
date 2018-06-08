//
//  AddPaymentViewController.swift
//  uome
//
//  Created by George Hajjar on 2018-06-07.
//  Copyright © 2018 George Hajjar. All rights reserved.
//

import UIKit

class AddPaymentViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var payeePicker: UIPickerView!
    @IBOutlet weak var amount: UITextField!
    
    var restOfNames = [String]()
    var temp = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initialize picker delegates
        self.payeePicker.delegate = self
        
        restOfNames = DataManager.sharedManager.nameData
        let toBeRemoved = restOfNames.index(of: DataManager.sharedManager.payer)
        restOfNames.remove(at: toBeRemoved!)
        
        self.payeePicker.reloadAllComponents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.payeePicker.reloadAllComponents()
    }
    
    @IBAction func quitAddPayment(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    //Set text color to white
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let str = restOfNames[row]
        return NSAttributedString(string: str, attributes: [NSAttributedStringKey.foregroundColor:UIColor.white])
    }
    
    //
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //Set data in pickerview
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return restOfNames[row]
    }
    
    //Set number of rows
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return restOfNames.count
    }
    
    //When item is selected in pickerview do...
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        temp = restOfNames[row]
    }
    
    @IBAction func addPayment(_ sender: Any) {
        DataManager.sharedManager.payee.append(temp)
        DataManager.sharedManager.payeeAmount.append(Int(amount.text!)!)
    }
}
