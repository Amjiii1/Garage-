//
//  historyChecklist.swift
//  Garage
//
//  Created by Amjad on 08/09/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import Foundation


struct InspectionListH {
    
    let InspectionDetailsH: [InspectionDetailsH]
    let InspectionIDH: Int
    let NameH: String
    let AlternativeH: String
    let OrderIDH: Int
}

struct  InspectionDetailsH {
    
    let CarInspectionDetailIDH: Int
    let CarInspectionIDH: Int
    let Name: String
    let AlternativeH: String
    let Value: String
   
}
