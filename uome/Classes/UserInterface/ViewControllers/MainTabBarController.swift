//
//  MainTabBarController.swift
//  uome
//
//  Created by George Hajjar on 2018-06-06.
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

class MainTabBarController: UITabBarController {

    @IBOutlet weak var mainTabBar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Tab Bar Color and White line
        UITabBar.appearance().backgroundImage = UIImage.colorForNavBar(color: UIColor(red:0.03, green:0.11, blue:0.14, alpha:1.0))
        UITabBar.appearance().shadowImage = UIImage.colorForNavBar(color: UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.2))
        
        if let tabBarItems = mainTabBar.items {
            
            tabBarItems[0].title = "Home"
            tabBarItems[0].image = #imageLiteral(resourceName: "home")
            //tabBarItems[0].selectedImage =
            
            tabBarItems[1].title = "Owes"
            tabBarItems[1].image = #imageLiteral(resourceName: "money_bag")
            //tabBarItems[1].selectedImage =
            
            tabBarItems[2].title = "Add"
            tabBarItems[2].image = #imageLiteral(resourceName: "plus")
            //tabBarItems[2].selectedImage =
            
            tabBarItems[3].title = "History"
            tabBarItems[3].image = #imageLiteral(resourceName: "clock")
            //tabBarItems[3].selectedImage =
            
            tabBarItems[4].title = "Settings"
            tabBarItems[4].image = #imageLiteral(resourceName: "settings")
            //tabBarItems[4].selectedImage =
        }
    }
}
