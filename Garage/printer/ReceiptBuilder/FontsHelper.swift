//
//  FontsHelper.swift
//  MarnPOS-P2P
//
//  Created by Admin on 12/06/2018.
//  Copyright © 2018 M. Arqam Owais. All rights reserved.
//

import Foundation
import UIKit

class FontsHelper {
    
    enum FontEnglish: String {
        case regualar = "Code Pro LC"
        case bold = "Code Pro Bold LC"
    }
    
    enum SFProDisplay: String {
        case medium = "SFProDisplay-Regular"
        case bold = "SFProDisplay-Bold"
    }
    
    
    enum FontArabic: String {
        case regualar = "DINNextLTArabic-Regular"
        case bold = "DINNextLTArabic-Bold"
    }
    
}

struct FontSize {
    fileprivate static var margin: CGFloat = DeviceType.IS_IPAD_PRO_OR_GREAT ? 3 : 0
    
    static let buttonMacro: CGFloat = 14.0 + margin
    static let buttonMinimum: CGFloat = 15.0 + margin
    static let buttonMedium: CGFloat = 16.0 + margin
    static let dashboardButton: CGFloat = 17.0 + margin
    static let dashboardButtonLarge: CGFloat = 20.0 + margin
    
    static let labelSlightBiggerThanMacro: CGFloat = 14.0 + margin
    static let labelMicro: CGFloat = 10.0 + margin
    static let labelMedium: CGFloat = 17.0 + margin
    static let labelLarge: CGFloat = 20.0 + margin
    
    static let labelMacro: CGFloat = 13.0 + margin
    static let labelMinimum: CGFloat = 12.0 + margin //noPrinterAdded
    static let labelSmall: CGFloat = 15.0 + margin
    static let rotateLabel: CGFloat = 30.0 + margin
    static let refundLabel: CGFloat = 36.0 + margin
}

struct Fonts {
    static var regularFontName: String {
        get {
            if Fonts().checkEng() {
                return "Code Pro LC"
            } else {
                return "DINNextLTArabic-Regular"
            }
        }
    }
    
    static var boldFontName: String {
        if Fonts().checkEng() {
            return "Code Pro Bold LC"
        } else{
            return "DINNextLTArabic-Bold"
        }
    }
    
    private func checkEng() -> Bool {
        if NSLocalizedString("English", comment: "") == "English" {
            return true
        } else {
            return false
        }
    }
}




