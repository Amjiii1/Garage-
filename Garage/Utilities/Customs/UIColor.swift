//
//  UIColor.swift
//  Garage
//
//  Created by Amjad on 04/04/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    // Setup custom colours we can use throughout the app using hex values
    static let DefaultApp = UIColor(hex: 0xFFB509)
    static let BlackApp = UIColor(hex: 0x36363B)
    static let transparentBlack = UIColor(hex: 0x000000, a: 0.5)
    static let rgbRed = UIColor(red: 255, green: 0, blue: 0)
    
    // Create a UIColor from RGB
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: a
        )
    }
    
    // Create a UIColor from a hex value (E.g 0x000000)
    convenience init(hex: Int, a: CGFloat = 1.0) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF,
            a: a
        )
    }
}
