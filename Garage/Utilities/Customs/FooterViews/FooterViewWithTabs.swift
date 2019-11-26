//
//  FooterViewWithTabs.swift
//  Garage
//
//  Created by Amjad Ali on 7/15/18.
//  Copyright © 2018 Amjad Ali. All rights reserved.
//




import Foundation
import UIKit

protocol FooterViewWithTabsDelegate {
    func selectedButtonIndex(index: Int)
}

class FooterViewWithTabs: UIView {
    
    @IBOutlet weak var btnWelcome: UIButton!
    @IBOutlet weak var btnService: UIButton!
    @IBOutlet weak var btnCheckout: UIButton!
    @IBOutlet weak var buttonsContainer: UIView!
    var delegate: FooterViewWithTabsDelegate!
    
    var buttons = [UIButton]()
    override func awakeFromNib() {
        buttons = [btnWelcome, btnService, btnCheckout]
        if L102Language.currentAppleLanguage() == "ar" {
            btnWelcome.titleEdgeInsets = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 25)
            btnService.titleEdgeInsets = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 25)
            btnCheckout.titleEdgeInsets = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 25)
        }
    }
    
    @IBAction func tabButtons_action(_ sender: UIButton) {
        for i in 1...3 {
            if let button = buttonsContainer.viewWithTag(i) as? UIButton {
                button.isSelected = false
                
            }
        }
        sender.isSelected = true
       
        if delegate != nil {
            delegate.selectedButtonIndex(index: sender.tag)
        }
    }
}



