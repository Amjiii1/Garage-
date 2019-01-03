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



