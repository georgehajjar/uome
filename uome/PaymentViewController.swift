//
//  PaymentViewController.swift
//  uome
//
//  Created by George Hajjar on 2018-05-29.
//  Copyright © 2018 George Hajjar. All rights reserved.
//

import UIKit

class PaymentViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var paidBy = [String]()
    let foods = ["apple", "banana", "grapes", "orange"]
    
    @IBOutlet weak var paidByPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return foods[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return foods.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        paidBy.append(foods[row])
        print(paidBy[0])
    }
}
