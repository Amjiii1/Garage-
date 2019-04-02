//
//  Checkoutdetails.swift
//  Garage
//
//  Created by Amjad on 19/07/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit

class Checkoutdetails: NSObject {

    var CardNumber: String?
    var CardHolderName: String?
    var  CardType: String?
    var AmountPaid: Double?
    var AmountDiscount: Double?
    var PaymentMode: Int?
    
    
    //    override init() {
    //
    //    }
    //
    init(CardNumber: String, CardHolderName: String, CardType: String, AmountPaid: Double, AmountDiscount: Double, PaymentMode: Int){
        self.CardNumber =  CardNumber
        self.CardHolderName = CardHolderName
        self.CardType = CardType
        self.AmountPaid = AmountPaid
        self.AmountDiscount = AmountDiscount
        self.PaymentMode = PaymentMode
    }
    
   
    
   
    
    
}
