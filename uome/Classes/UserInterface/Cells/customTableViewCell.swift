//
//  customTableViewCell.swift
//  uome
//
//  Created by George Hajjar on 2018-05-24.
//  Copyright © 2018 George Hajjar. All rights reserved.
//

import UIKit

class customTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 6
        //Set background color of cells
        //self.backgroundColor = UIColor(red: 36, green: 74, blue: 98, alpha: 1)
        
        nameLabel.textColor = UIColor.white
        priceLabel.textColor = UIColor.white
    }
}
