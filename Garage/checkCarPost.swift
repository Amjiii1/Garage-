//
//  checkCarPost.swift
//  Garage
//
//  Created by Amjad on 25/05/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit

class checkCarPost: Codable {

    var CarInspectionDetailID: Int?
    var CarInspectionID: Int?
    var  Name: String?
    var  AlternateName: String?
    var Description: String?
    var Kilometer: String?
    var IsInspection: Bool?
    var IsReplace: Bool?
    var IsInspectWithoutReplace: Bool?
    
    
    init(CarInspectionDetailID: Int, CarInspectionID: Int, Name: String, AlternateName: String, Description: String, Kilometer: String, IsInspection: Bool, IsReplace: Bool, IsInspectWithoutReplace: Bool){
        self.CarInspectionDetailID =  CarInspectionDetailID
        self.CarInspectionID = CarInspectionID
        self.Name = Name
        self.AlternateName = AlternateName
        self.Description = Description
        self.Kilometer = Kilometer
        self.IsInspection = IsInspection
        self.IsReplace = IsReplace
        self.IsInspectWithoutReplace = IsInspectWithoutReplace
    }
    
    
    
}
