//
//  orderdetailCell.swift
//  Garage
//
//  Created by Amjad on 04/09/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit

class orderdetailCell: UITableViewCell {
    
    
    @IBOutlet weak var labelItem: UILabel!
    
    @IBOutlet weak var labelPrice: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
