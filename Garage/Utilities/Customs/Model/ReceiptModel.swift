//
//  ReceiptModel.swift
//  Garage
//  Created by Amjad on 03/03/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit

class ReceiptModel: Codable {
    
    var Name: String?
    var Price: Int?
    var  ItemID: Int?
    var Quantity: Int?
    
//    override init() {
//        
//    }
//    
    init(Name: String, Price: Int, ItemID: Int, Quantity: Int){
        self.Name =  Name
        self.Price = Price
        self.ItemID = ItemID
       self.Quantity = Quantity
}
    

}
