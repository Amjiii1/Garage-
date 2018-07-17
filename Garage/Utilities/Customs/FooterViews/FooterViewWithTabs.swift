//
//  FooterViewWithTabs.swift
//  Garage
//
//  Created by Amjad Ali on 7/15/18.
//  Copyright © 2018 Amjad Ali. All rights reserved.
//

import Foundation
import UIKit


class FooterViewWithTabs: UIView {
    
    @IBOutlet weak var btnWelcome: UIButton!
    @IBOutlet weak var btnService: UIButton!
    @IBOutlet weak var btnCheckout: UIButton!
    
    @IBAction func tabButtons_action(_ sender: UIButton) {
        
        var storyboard: UIStoryboard!
        var vc: UIViewController!
        //select(sender)
        switch sender.tag {
        case btnWelcome.tag:
            storyboard = UIStoryboard(name: "WelcomeView", bundle: nil)
            vc = storyboard.instantiateViewController(withIdentifier: "WelcomeVc") as! WelcomeView
            btnWelcome.isSelected = true
            btnCheckout.isSelected = false
            btnService.isSelected = false

            break
        case btnService.tag:
            storyboard = UIStoryboard(name: "MechanicView", bundle: nil)
            vc = storyboard.instantiateViewController(withIdentifier: "MechanicVc") as! MechanicView
            btnService.isSelected = true
            btnWelcome.isSelected = false
            btnCheckout.isSelected = false
            break
        case btnCheckout.tag:
            storyboard = UIStoryboard(name: "CheckoutView", bundle: nil)
            vc = storyboard.instantiateViewController(withIdentifier: "CheckoutVc") as! CheckoutView
            btnCheckout.isSelected = true
            btnWelcome.isSelected = false
            btnService.isSelected = false

            break

        default:
            break
        }

//        if vc != nil {
//            switchViewController(vc: vc)
        }
    }
    
    
    
    
//}
