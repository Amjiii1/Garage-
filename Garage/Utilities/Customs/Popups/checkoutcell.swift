//
//  checkoutcell.swift
//  Garage
//
//  Created by Amjad on 05/06/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit

class checkoutcell: UITableViewCell {

    
    @IBOutlet weak var productlabel: UILabel!
    
    @IBOutlet weak var Qtylabel: UILabel!
    
    @IBOutlet weak var pricelabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
