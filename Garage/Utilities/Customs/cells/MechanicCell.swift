//
//  MechanicCell.swift
//  Garage
//
//  Created by Amjad on 29/02/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit

class MechanicCell: UICollectionViewCell {
    
    @IBOutlet weak var subtitle: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        subtitle.text?.removeAll()
    }
    
    func populate(with model: String) {
        subtitle.text = model
    }
    
    
}
