//
//  PaymentViewController.swift
//  uome
//
//  Created by George Hajjar on 2018-05-29.
//  Copyright © 2018 George Hajjar. All rights reserved.
//

import UIKit

class PaymentViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    var temp = ""
    
    
    @IBOutlet weak var paidByPicker: UIPickerView!
    @IBOutlet weak var totalMoney: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return DataManager.sharedManager.nameData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return DataManager.sharedManager.nameData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        temp = DataManager.sharedManager.nameData[row]
    }
    
    @IBAction func donePressed(_ sender: UIButton) {
        DataManager.sharedManager.moneyData[DataManager.sharedManager.nameData.index(of: temp)!] = Int(totalMoney.text!)!
    }
    
}
