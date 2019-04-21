//
//  popModel.swift
//  Garage
//
//  Created by Amjad on 06/03/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit

class popModel: NSObject {
    
    var BayID: Int?
    var Name: String?
    var LocationID: Int?
    
    
    override init() {
        
    }
    
    
    init(BayID: Int, Name: String, LocationID: Int){
        
        self.BayID = BayID
        self.Name =  Name
        self.LocationID =  LocationID
    
        
    }
    
    
    init?(Baylist: [String: Any]) {
        guard let BayID = Baylist["BayID"] as? Int,
            let Name = Baylist["Name"] as? String,
            let LocationID = Baylist["LocationID"] as? Int
            else { return }
        self.BayID = BayID
        self.Name = Name
        self.LocationID = LocationID
     
        
    }
    
    
    
    
    
    
    
    
}
