//
//  checkoutItems.swift
//  Garage
//
//  Created by Amjad on 06/06/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit

class checkoutItems: NSObject {
    
    
    var Name: String?
    var AlternateName: String?
    var Price: Double?
    var  ItemID: Int?
    var Quantity: Int?
    var OrderDetailID: Int?
    var itemorderid: Int?
    
   
    init(Name: String, AlternateName: String,Price: Double, ItemID: Int, Quantity: Int, OrderDetailID: Int, itemorderid: Int){
        self.Name =  Name
        self.AlternateName =  AlternateName
        self.Price = Price
        self.ItemID = ItemID
        self.Quantity = Quantity
        self.OrderDetailID = OrderDetailID
        self.itemorderid = itemorderid
        
        
    }
    
    

}
