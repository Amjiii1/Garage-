//
//  ReceiptModel.swift
//  Garage
//  Created by Amjad on 03/03/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit

class ReceiptModel: Codable {
    
    var Name: String?
    var AlternateName: String?
    var Price: Double?
    var  ItemID: Int?
    var Quantity: Int?
    var Mode: String?
    var OrderDetailID: Int?
    var Status: Int?
    
    
//    override init() {
//        
//    }
//    
    init(Name: String, AlternateName: String?, Price: Double, ItemID: Int, Quantity: Int, Mode: String, OrderDetailID: Int, Status: Int){
        self.Name =  Name
        self.AlternateName =  AlternateName
        self.Price = Price
        self.ItemID = ItemID
       self.Quantity = Quantity
       self.Mode = Mode
        self.OrderDetailID = OrderDetailID
        self.Status = Status
}
    

}
