//
//  MechanicCell.swift
//  Garage
//
//  Created by Amjad on 29/02/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit
import Kingfisher

class MechanicCell: UICollectionViewCell {
    
    @IBOutlet weak var subtitle: UILabel!
    
    @IBOutlet weak var mechanicImage: UIImageView!
    
   
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
         mechanicImage.image = nil
       
        subtitle.text?.removeAll()
      
       

    }
    
    func Mpopulate(with model: String, image: String) {
      
        subtitle.text = model.capitalized

      
        if let url = URL(string: image) {
            mechanicImage.kf.indicatorType = .activity
            mechanicImage.kf.setImage(with: url)
        }
    }
    
    
}
