//
//  SubuserModel.swift
//  Garage
//
//  Created by Amjad on 07/06/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit

class SubuserModel: NSObject {

    var SubUserID: Int?
    var FullName: String?
   
    
    
    override init() {
        
    }
    
    
    init(SubUserID: Int, FullName: String){
        
        self.SubUserID = SubUserID
        self.FullName =  FullName
      
        
        
        
    }
    
    
    init?(SubUser: [String: Any]) {
        guard let SubUserID = SubUser["SubUserID"] as? Int,
            let FullName = SubUser["FullName"] as? String
        
            else { return }
        self.SubUserID = SubUserID
        self.FullName = FullName
       
    }
    
    
}
