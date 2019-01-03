//
//  ReceiptCell.swift
//  Garage
//
//  Created by Amjad on 03/03/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit

class ReceiptCell: UITableViewCell {

    
    @IBOutlet weak var ProductName: UILabel!
    
    @IBOutlet weak var ProductQty: UILabel!
    
    @IBOutlet weak var ProductPrice: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}



