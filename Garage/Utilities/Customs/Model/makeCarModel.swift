//
//  makeCarModel.swift
//  Garage
//
//  Created by Amjad on 25/03/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit

class makeCarModel: NSObject {

    
    var MakeID: Int?
    var Name: String?
    
    
    
    override init() {
        
    }
    
    
    init(MakeID: Int, Name: String){
        
        self.MakeID = MakeID
        self.Name =  Name
       
        
    }
    
    
    
    init?(Makedetails: [String: Any]) {
        guard let makeid = Makedetails["MakeID"] as? Int,
            let name = Makedetails["Name"] as? String
            
            else { return }
        self.MakeID = makeid
        self.Name = name
      
        
    }
}
