//
//  AddPaymentViewController.swift
//  uome
//
//  Created by George Hajjar on 2018-06-07.
//  Copyright © 2018 George Hajjar. All rights reserved.
//

import UIKit

class AddPaymentViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    var restOfNames = [String]()
    var temp = ""
    
    @IBOutlet weak var payeeName: UITextField!
    @IBOutlet weak var amount: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initialize Payee input picker
        let payeePickerView = UIPickerView()
        payeePickerView.delegate = self
        payeeName.inputView = payeePickerView
        
        //Create new array with all names minus payer
        restOfNames = DataManager.sharedManager.nameData
        let toBeRemoved = restOfNames.index(of: DataManager.sharedManager.payer)
        restOfNames.remove(at: toBeRemoved!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //self.payeePicker.reloadAllComponents()
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
        payeeName.text = restOfNames[row]
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func addPayment(_ sender: Any) {
        DataManager.sharedManager.payee.append(temp)
        DataManager.sharedManager.payeeAmount.append(Double(amount.text!)!)
        
        DataManager.sharedManager.total = DataManager.sharedManager.total + Double(amount.text!)!
        
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
}
