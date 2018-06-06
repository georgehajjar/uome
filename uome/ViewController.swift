//
//  ViewController.swift
//  uome
//
//  Created by George Hajjar on 2018-05-23.
//  Copyright © 2018 George Hajjar. All rights reserved.
//

import UIKit

extension UIImage {
    class func colorForNavBar(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        //    Or if you need a thinner border :
        //    let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 0.5)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var nameData = [String]()
    var moneyData = [Int]()
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
        
        //Tab Bar Color and White line
        UITabBar.appearance().backgroundImage = UIImage.colorForNavBar(color: UIColor(red:0.03, green:0.11, blue:0.14, alpha:1.0))
        UITabBar.appearance().shadowImage = UIImage.colorForNavBar(color: UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.2))
    }
    
    
    @IBAction func addParticipant(_ sender: Any) {
        let alert = UIAlertController(title: "Enter name of participant", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addTextField(configurationHandler: { textField in textField.placeholder = "Input your name here..." })
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            if let name = alert.textFields?.first?.text {
                if self.nameData.isEmpty {
                    self.nameData.append(name)
                    self.moneyData.append(0)
                    self.tableView.reloadData()
                }
                else {
                    if self.nameData.contains(name) {
                        self.notRepeated = false
                    }
                    else {
                        self.nameData.append(name)
                        self.moneyData.append(0)
                        self.tableView.reloadData()
                    }
                    self.notRepeated = true
                }
            }
        }))
        self.present(alert, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Initialize custom cell
        let cell:customTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! customTableViewCell
        
        if !nameData.isEmpty {
            cell.nameLabel.text = nameData[indexPath.row]
            cell.priceLabel.text = String(moneyData[indexPath.row])
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "leftPlusButtonSegue" {
            if let participantVC = segue.destination as? ParticipantViewController {
//                if participantVC.buttonPressed {
//                    self.nameData.append(participantVC.participantName.text!)
//                    if !nameData.isEmpty {
//                        print(nameData[0])
//                    }
//                }
            }
        }
    }
    
    
    
    
}
