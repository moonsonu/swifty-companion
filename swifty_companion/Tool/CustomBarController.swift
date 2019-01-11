//
//  CustomBarController.swift
//  swifty_companion
//
//  Created by Kristine Sonu on 1/4/19.
//  Copyright © 2019 Kristine Sonu. All rights reserved.
//

import UIKit

class CustomBarController: UITabBarController {
    
    var tabB = UITabBarItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        let navigationFont = UIFont(name: "futura-Bold", size: 20)!
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: navigationFont], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red:0.00, green:0.73, blue:0.66, alpha:1.0), NSAttributedString.Key.font: navigationFont], for: .normal)
        
        UITabBar.appearance().barTintColor = UIColor(red:0.00, green:0.73, blue:0.66, alpha:1.0)
       
        
        let selectedImage1 = UIImage(named: "profile")?.withRenderingMode(.alwaysOriginal)
        let deSelectedImage1 = UIImage(named: "profile")?.withRenderingMode(.alwaysOriginal)
        tabB = self.tabBar.items![0]
        tabB.image = deSelectedImage1
        tabB.selectedImage = selectedImage1
        
        let selectedImage2 = UIImage(named: "skill")?.withRenderingMode(.alwaysOriginal)
        let deSelectedImage2 = UIImage(named: "skill")?.withRenderingMode(.alwaysOriginal)
        tabB = self.tabBar.items![1]
        tabB.image = deSelectedImage2
        tabB.selectedImage = selectedImage2
        
        let selectedImage3 = UIImage(named: "project")?.withRenderingMode(.alwaysOriginal)
        let deSelectedImage3 = UIImage(named: "project")?.withRenderingMode(.alwaysOriginal)
        tabB = self.tabBar.items![2]
        tabB.image = deSelectedImage3
        tabB.selectedImage = selectedImage3
        
        let numberOfTabs = CGFloat((tabBar.items?.count)!)
        let tabBartSize = CGSize(width: tabBar.frame.width / numberOfTabs, height: tabBar.frame.height + 40)
        tabBar.selectionIndicatorImage = UIImage.imageWithColor(color: UIColor(red:0.00, green:0.73, blue:0.66, alpha:1.0), size: tabBartSize)
        self.selectedIndex = 0
        
    }
}

extension UIImage {
    class func imageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
