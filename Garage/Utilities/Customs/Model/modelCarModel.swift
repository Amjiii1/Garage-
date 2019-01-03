//
//  modelCarModel.swift
//  Garage
//
//  Created by Amjad on 26/03/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit

class modelCarModel: NSObject {

    var ModelID: Int?
    var Name: String?
    var Year: Int?
    var EngineNo: String?
    var RecommendedAmount: String?
    
    
    
    override init() {
        
    }
    
    
    init(ModelID: Int, Name: String, Year: Int, EngineNo: String, RecommendedAmount: String){
        
        self.ModelID = ModelID
        self.Name =  Name
        self.Year =  Year
        self.EngineNo =  EngineNo
        self.RecommendedAmount =  RecommendedAmount
        
        
        
        
    }
    
    
    
    init?(Modeldetails: [String: Any]) {
        guard let modelID = Modeldetails["ModelID"] as? Int,
            let name = Modeldetails["Name"] as? String,
            let year = Modeldetails["Year"] as? Int,
            let engineNo = Modeldetails["EngineNo"] as? String,
            let recommendedAmount = Modeldetails["RecommendedAmount"] as? String
            
            else { return }
        self.ModelID = modelID
        self.Name = name
         self.Year = year
         self.EngineNo = engineNo
         self.RecommendedAmount = recommendedAmount
        
        
    }
    
    
    
    
}
