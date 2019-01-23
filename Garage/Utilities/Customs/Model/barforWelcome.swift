//
//  barforWelcome.swift
//  Garage
//
//  Created by Amjad on 01/05/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit

class barforWelcome: UICollectionViewCell {
    
    @IBOutlet weak var title: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        title.text?.removeAll()
    }
    
    func populate(with model: String) {
        title.text = model
    }
    
    
    
    
}
