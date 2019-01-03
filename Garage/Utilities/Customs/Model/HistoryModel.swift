//
//  HistoryModel.swift
//  Garage
//
//  Created by Amjad on 11/03/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit

class HistoryModel: NSObject {
    
    var Sno: Int?
    var Date: String?
    var Mechanic: String?
    var Total: String?
    
    
    override init() {
        
    }
    
    
    init(Sno: Int?, Date: String, Mechanic: String, Total: String){
        
        self.Sno = Sno
        self.Date = Date
        self.Mechanic =  Mechanic
        self.Total =  Total
       
        
    }
    
    
    
    init?(historyorder: [String: Any]) {
      guard  let sno = historyorder["SNo"] as? Int?,
       let date = historyorder["OrderDate"] as? String,
            let mechanic = historyorder["Mechanic"] as? String,
            let Total = historyorder["AmountTotal"] as? String
            else { return }
        self.Sno = sno
        self.Date = date
        self.Mechanic = mechanic
        self.Total = Total
        
    }
    
    
    
    
}
