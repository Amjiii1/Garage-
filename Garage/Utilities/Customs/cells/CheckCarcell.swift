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
    
    
    
//
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        self.selectionStyle = .none
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        self.accessoryType = selected ? .checkmark : .none
    }

}
