//
//  MechanicTableviewCell.swift
//  Garage
//
//  Created by Amjad on 10/05/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit

class MechanicTableviewCell: UITableViewCell {

    @IBOutlet weak var serialNo: UILabel!
    
    @IBOutlet weak var makeLbl: UILabel!
    
    @IBOutlet weak var modelLbl: UILabel!
    
    
    @IBOutlet weak var plateLbl: UILabel!
    
    @IBOutlet weak var statusLbl: UILabel!
    
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        serialNo.text?.removeAll()
        makeLbl.text?.removeAll()
        modelLbl.text?.removeAll()
        plateLbl.text?.removeAll()
        statusLbl.text?.removeAll()
    }
    
    func populate(with details: Details) {
        
        serialNo.text = "\(details.finishedid)"
        makeLbl.text = details.finishedmake
        modelLbl.text = details.finishedmodel
        plateLbl.text = details.finishedplate
         statusLbl.text = details.finishedstatus
    }
    
}

struct Details {
    
    let finishedid: Int
    let finishedmake: String
    let finishedmodel: String
    let finishedplate: String
    let finishedstatus: String
}

    
    
    
    

