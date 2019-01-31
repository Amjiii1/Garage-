//
//  CheckCarcell.swift
//  Garage
//
//  Created by Amjad on 16/05/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit

class CheckCarcell: UITableViewCell {

    @IBOutlet weak var checkboxA: UIButton!
    @IBOutlet weak var checkBoxB: UIButton!
    @IBOutlet weak var checkBoxC: UIButton!
    @IBOutlet weak var titleLabels: UILabel!
    
    
    @IBAction func onTypeCTap(_ sender: UIButton) {
        
        sender.isSelected = true
        checkboxA.isSelected = false
        checkBoxB.isSelected = false
    }
    
    
    @IBAction func onTypeBTap(_ sender: UIButton) {
      
        
        sender.isSelected = true
        checkboxA.isSelected = false
        checkBoxC.isSelected = false
    }
    
    
    @IBAction func onTypeATap(_ sender: UIButton) {
     
        sender.isSelected = true
        checkBoxB.isSelected = false
        checkBoxC.isSelected = false
    }
}
