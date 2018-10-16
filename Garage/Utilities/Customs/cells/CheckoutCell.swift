//
//  CheckoutCell.swift
//  Garage
//
//  Created by Amjad  on 16/01/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit

class CheckoutCell: UITableViewCell {

    
    @IBOutlet weak var CSerialnmb: UILabel!
    
    @IBOutlet weak var CMake: UILabel!
    
    
    @IBOutlet weak var CModel: UILabel!
    
    @IBOutlet weak var CPlatenmb: UILabel!
    
    @IBOutlet weak var Bay: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        CSerialnmb.text?.removeAll()
        CMake.text?.removeAll()
        CModel.text?.removeAll()
        CPlatenmb.text?.removeAll()
         Bay.text?.removeAll()
    }
    
    func populate(with checkoutcar: CheckoutCars) {
        
        CSerialnmb.text = "\(checkoutcar.id)"
        CMake.text = checkoutcar.make
        CModel.text = checkoutcar.model
        CPlatenmb.text = checkoutcar.plate
        Bay.text = checkoutcar.Cbay
    }
    
}

struct CheckoutCars {
    
    let id: Int
    let make: String
    let model: String
    let plate: String
    let Cbay: String
}
