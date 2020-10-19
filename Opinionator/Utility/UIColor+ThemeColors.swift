//
//  UIColor+ThemeColors.swift
//  Opinionator
//
//  Created by Felix Yu on 8/22/20.
//  Copyright © 2020 Felix Yu. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    struct basicColors {
        static let purple = UIColor(red: 0.29, green: 0.22, blue: 0.51, alpha: 1)
        static let teal = UIColor(red: 0.36, green: 0.71, blue: 0.74, alpha: 1)
        static let gray = UIColor(red: 0.64, green: 0.65, blue: 0.65, alpha: 1)
    }
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static let twitterBlue = UIColor.rgb(red: 29, green: 161, blue: 242)
}
