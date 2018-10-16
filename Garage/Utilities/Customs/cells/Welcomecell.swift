//
//  Welcomecell.swift
//  Garage
//
//  Created by Amjad  on 10/01/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit

class Welcomecell: UITableViewCell {

   
    
    @IBOutlet weak var serialnmb: UILabel!
    
    @IBOutlet weak var make: UILabel!
    
    @IBOutlet weak var model: UILabel!
    
    @IBOutlet weak var plateNmb: UILabel!
    @IBOutlet weak var editBtn: UIButton!

    
    override func prepareForReuse() {
    super.prepareForReuse()
    
    serialnmb.text?.removeAll()
    make.text?.removeAll()
    model.text?.removeAll()
    plateNmb.text?.removeAll()
}

func populate(with car: Car) {
    
    serialnmb.text = "\(car.id)"
    make.text = car.make
    model.text = car.model
    plateNmb.text = car.plate
}

}

struct Car {
    
    let id: Int
    let make: String
    let model: String
    let plate: String
}


