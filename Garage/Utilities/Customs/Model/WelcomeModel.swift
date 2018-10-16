//
//  WelcomeModel.swift
//  Garage
//
//  Created by Amjad  on 10/01/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit

class WelcomeModel: NSObject {

    
    var serialNumb: String?
    var makeCar: String? 
    var modelCar: String?
    var plateNumbCar: String?
    
    
    override init() {
        
    }
    
    
    init(serial: String, make: String, model: String, platenmb: String ){
        
        self.serialNumb = serial
        self.makeCar =  make
        self.modelCar =  model
        self.plateNumbCar =  platenmb
       // self.actionButtonEdit = actionButton
        
    }
    
}
