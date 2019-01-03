//
//  HistoryCell.swift
//  Garage
//
//  Created by Amjad on 11/03/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit

class HistoryCell: UITableViewCell {

    
    @IBOutlet weak var SrNo: UILabel!
    @IBOutlet weak var Date: UILabel!
    @IBOutlet weak var Mechanic: UILabel!
    
    @IBOutlet weak var Total: UILabel!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
