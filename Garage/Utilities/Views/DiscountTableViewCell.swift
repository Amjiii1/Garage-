//
//  DiscountTableViewCell.swift
//  Garage
//
//  Created by Amjad on 19/01/1441 AH.
//  Copyright © 1441 Amjad Ali. All rights reserved.
//

import UIKit

class DiscountTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblAmount: UILabel!
    
    @IBOutlet weak var lblCurrency: UILabel!
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
