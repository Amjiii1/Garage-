//
//  HistoryModel.swift
//  Garage
//
//  Created by Amjad on 11/03/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit

class HistoryModel: NSObject {
    
    var TransactionNo: Int?
    var Sno: Int?
    var Date: String?
    var Mechanic: String?
    var Total: String?
    
    
    override init() {
        
    }
    
    
    init(TransactionNo: Int?, Sno: Int?, Date: String, Mechanic: String, Total: String){
        
        self.TransactionNo = TransactionNo
        self.Sno = Sno
        self.Date = Date
        self.Mechanic =  Mechanic
        self.Total =  Total
       
        
    }
    
    
    
    init?(historyorder: [String: Any]) {
      guard  let sno = historyorder["SNo"] as? Int?,
        let transactionNo = historyorder["TransactionNo"] as? Int,
       let date = historyorder["OrderDate"] as? String,
            let mechanic = historyorder["Mechanic"] as? String,
            let Total = historyorder["AmountTotal"] as? String
            else { return }
        self.TransactionNo = transactionNo
         self.Sno = sno
        self.Sno = sno
        self.Date = date
        self.Mechanic = mechanic
        self.Total = Total
        
    }
    
    
    
    
}
