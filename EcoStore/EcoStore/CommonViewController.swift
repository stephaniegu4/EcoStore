//
//  CommonViewController.swift
//  EcoStore
//
//  Created by Stephanie Gu on 2019-09-14.
//  Copyright © 2019 Stephanie Gu. All rights reserved.
//

import UIKit

// Allows for easy addition of RGB colours throughout app
extension UIColor {
    
    static func fromRGB(_ red : CGFloat, _ green: CGFloat, _ blue: CGFloat) -> UIColor {
        return UIColor(red: CGFloat(red / 255), green: CGFloat(green / 255), blue: CGFloat(blue / 255), alpha: 1)
    }
}

class CommonViewController : UIViewController {
    
}
