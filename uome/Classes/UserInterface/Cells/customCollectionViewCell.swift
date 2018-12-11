//
//  customCollectionViewCell.swift
//  uome
//
//  Created by George Hajjar on 2018-11-28.
//  Copyright © 2018 George Hajjar. All rights reserved.
//

import UIKit

class customCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor(red: 0.14, green: 0.29, blue: 0.38, alpha: 1.0)
        self.layer.cornerRadius = 6
        
        nameLabel.textColor = UIColor.white
        priceLabel.textColor = UIColor.white
    }

}
