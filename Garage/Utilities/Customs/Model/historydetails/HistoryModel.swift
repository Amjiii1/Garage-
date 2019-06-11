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
    var OrderID: Int?
    var TotalAmount: Double?
   // var Tax: Double?
    
    
    override init() {
        
    }
    
    
    init(TransactionNo: Int?, Sno: Int?, Date: String, Mechanic: String, Total: String, OrderID: Int?, TotalAmount: Double?){
        
        self.TransactionNo = TransactionNo
        self.Sno = Sno
        self.Date = Date
        self.Mechanic =  Mechanic
        self.Total =  Total
        self.OrderID =  OrderID
         self.TotalAmount =  TotalAmount
       // self.Tax =  Tax
       
        
    }
    
    
    
    init?(historyorder: [String: Any]) {
      guard  let sno = historyorder["SNo"] as? Int?,
        let transactionNo = historyorder["TransactionNo"] as? Int,
       let date = historyorder["OrderDate"] as? String,
            let mechanic = historyorder["Mechanic"] as? String,
            let Total = historyorder["AmountTotal"] as? String,
         let orderID = historyorder["OrderID"] as? Int,
         let totalAmount = historyorder["TotalAmount"] as? Double
      //  let Tax = historyorder["Tax"] as? Double
            else { return }
        self.TransactionNo = transactionNo
         self.Sno = sno
        self.Sno = sno
        self.Date = date
        self.Mechanic = mechanic
        self.Total = Total
         self.OrderID = orderID
        self.TotalAmount = totalAmount
     //    self.Tax = Tax
        
    }
    
    
    
    
}
