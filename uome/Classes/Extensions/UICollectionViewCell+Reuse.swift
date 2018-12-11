//
//  UICollectionViewCell+Reuse.swift
//  BenIQ
//
//  Created by George Hajjar on 2018-08-10.
//  Copyright © 2018 Symbility Intersect. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    static var nibName: String {
        return String(describing: self)
    }
    class func register(with collectionView: UICollectionView) {        
        collectionView.register(
            UINib(nibName: nibName, bundle: nil),
            forCellWithReuseIdentifier: identifier)
    }
}
