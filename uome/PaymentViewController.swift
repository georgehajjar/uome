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
    
    @IBOutlet weak var paymentTitle: UITextField!
    @IBOutlet weak var paidByPicker: UIPickerView!
    @IBOutlet weak var totalMoney: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.paidByPicker.reloadAllComponents()
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
        temp = DataManager.sharedManager.nameData[row]
    }
    
    
    @IBAction func addPressed(_ sender: UIButton) {
        DataManager.sharedManager.moneyData[DataManager.sharedManager.nameData.index(of: temp)!] = Int(totalMoney.text!)!
    }
    
}
