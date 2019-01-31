//
//  CheckcarPostData.swift
//  Garage
//
//  Created by Amjad on 24/05/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import Foundation


struct InspectionListPOST {
    
    let InspectionDetails: [InspectionDetailsPOST]
    let InspectionID: Int
    let Name: String
    let AlternateName: String
    let Image: String
    let Description: String
    let UserID: Int
}

struct  InspectionDetailsPOST {
    
    
    let CarInspectionDetailID: Int
    let CarInspectionID: Int
    let Name: String
    let AlternateName: String
    let Description: String
    let Kilometer: String
    let IsInspection: Bool
    let IsReplace: Bool
    let IsInspectWithoutReplace: Bool
}
