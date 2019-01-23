//
//  BayforWelcomeOBj.swift
//  Garage
//
//  Created by Amjad on 01/05/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit

class BayforWelcomeOBj: NSObject {
    
    
    var WBayID: Int?
    var WName: String?
    var WLocationID: Int?
    
    
    override init() {
        
    }
    
    
    init(BayID: Int, Name: String, LocationID: Int){
        
        self.WBayID = BayID
        self.WName =  Name
        self.WLocationID =  LocationID
        
        
        
    }
    
    
    init?(WBaylist: [String: Any]) {
        guard let BayID = WBaylist["BayID"] as? Int,
            let Name = WBaylist["Name"] as? String,
            let LocationID = WBaylist["LocationID"] as? Int
            else { return }
        self.WBayID = BayID
        self.WName = Name
        self.WLocationID = LocationID
        
        
    
    
    

}
}
