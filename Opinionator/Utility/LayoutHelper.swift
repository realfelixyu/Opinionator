//
//  LayoutHelper.swift
//  Opinionator
//
//  Created by Felix Yu on 8/22/20.
//  Copyright © 2020 Felix Yu. All rights reserved.
//

import Foundation
import UIKit

class LayoutHelper {
    //iPhone X size
    static let baseSize = CGSize(width: 375.0, height: 812.0)
    
    class func pixelRelativeToScreen(toWidth width: CGFloat) -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let relativity =  screenWidth / baseSize.width
        let relativeWidth = width * relativity
        return relativeWidth
    }
    
    class func pixelRelativeToScreen(toHeight height: CGFloat) -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        let relativity =  screenHeight / baseSize.height
        let relativeHeight = height * relativity
        return relativeHeight
    }
    
    class func fontRelativeToScreen(toSize size: CGFloat) -> CGFloat {
        
        let screenHeight = UIScreen.main.bounds.height
        let relativity =  screenHeight / baseSize.height
        let relativeSize = size * relativity
        return relativeSize
        
    }

    class func isSmallDevice() -> Bool {
        let deviceHeight = UIScreen.main.bounds.size.height
        return deviceHeight < 600
    }
    
    
    class func isMediumDevice() -> Bool {
        let deviceHeight = UIScreen.main.bounds.size.height
        return deviceHeight < 740 && deviceHeight >= 600
    }
    
    static func relativeHeight(percentOfScreen percent: Double) -> CGFloat {
        let decimalFromPercent = CGFloat(percent)/100
        let screenHeight = UIScreen.main.bounds.height
        let relativeValue =  screenHeight * decimalFromPercent
        return relativeValue
    }
    
    static func relativeWidth(percentOfScreen percent: Double) -> CGFloat {
        let decimalFromPercent = CGFloat(percent)/100
        let screenWidth = UIScreen.main.bounds.width
        let relativeValue =  screenWidth * decimalFromPercent
        return relativeValue
    }
}
