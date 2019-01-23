//
//  modelCar.swift
//  Garage
//
//  Created by Amjad on 26/03/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit

class modelCar: NSObject {
    
    var Name: String?
    var ModelID: Int?
    var Year: Int?
    var EngineNo: String?
    var RecommendedLitres: String?
    
    
    
    override init() {
        
    }
    
    
    init(Name: String, ModelID: Int, Year: Int, EngineNo: String, RecommendedLitres: String) {
        self.Name = Name
        self.ModelID = ModelID
        self.Year = Year
        self.EngineNo = EngineNo
        self.RecommendedLitres = RecommendedLitres
        
    }
    
    
    
    
    
    
    
    
    init(DetailsModel: [String: Any]){
        
        guard let name = DetailsModel["Name"] as? String,
            let modelid = DetailsModel["ModelID"] as? Int,
            let year = DetailsModel["Year"] as? Int,
            let engineno = DetailsModel["EngineNo"] as? String,
            let recomend = DetailsModel["RecommendedLitres"] as? String
            
            
            else {return}
        
        self.Name = name
        self.ModelID = modelid
        self.Year = year
        self.EngineNo = engineno
        self.RecommendedLitres = recomend
        
    }
    
    
    
    
    
    
    
}
