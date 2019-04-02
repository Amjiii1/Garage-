//
//  Xreport.swift
//  Garage
//
//  Created by Amjad on 25/07/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit

class Xreport: NSObject {
    
    
    var totalSales:String!
    var minusDiscount:String!
    var minusVoid:String!
    var minusComplimentary:String!
    var minuesReturns:String!
    var tax:String!
    var netSales:String!
    var plusGratuity:String!
    var plusCharges:String!
    var totalTendered:String!
    var cash:String!
    var credit:String!
    var loyalty:String!
    var giftCard:String!
    var coupons:String!
//    var ledger:String!
    var totalTrNTypes:String!
    var totalOrders:String!
    var TotalCardOrders:String!
    var TotalCashOrders:String!
    var TotalVoidOrders:String!
    var TotalRefundOrders:String!
    var TotalMultiPayOrders:String!
//    var Close:String!
//    {
//        didSet {
//            self.CloseDate = Close.components(separatedBy: " ")[0]
//        }
//    }
//    var Open:String!
//    var isZreport = false
//    var CloseDate:String = ""
    init(
        totalSales:String,
        minusDiscount:String,
        minusVoid:String,
        minusComplimentary:String,
        minuesReturns:String,
        tax:String,
        netSales:String,
        plusGratuity:String,
        plusCharges:String,
        totalTendered:String,
        cash:String,
        credit:String,
        loyalty:String,
        giftCard:String,
        coupons:String,
        totalTrNTypes:String,
        totalOrders:String,
//        isZreport:Bool = false,
//        Open:String,
//        Close:String,
        totalCashOrders:String,
        totalCardOrders:String,
        totalVoidOrders:String,
        totalRefundOrders:String,
        totalMultiPayOrders:String )
//        ledger:String = "")
    {
        self.totalSales  = totalSales
        self.minusDiscount  = minusDiscount
        self.minusVoid  = minusVoid
        self.minusComplimentary  = minusComplimentary
        self.minuesReturns  = minuesReturns
        self.tax  = tax
        self.netSales  = netSales
        self.plusGratuity  = plusGratuity
        self.plusCharges  = plusCharges
        self.totalTendered  = totalTendered
        self.cash  = cash
        self.credit  = credit
        self.loyalty = loyalty
        self.giftCard  = giftCard
        self.coupons  = coupons
       // self.ledger  = ledger
        self.totalTrNTypes  = totalTrNTypes
        self.totalOrders  = totalOrders
//        self.isZreport = isZreport
//        self.Open = Open
//        self.Close = Close
//        self.CloseDate = Close.components(separatedBy: " ")[0]
        self.TotalRefundOrders = totalRefundOrders
        self.TotalVoidOrders = totalVoidOrders
        self.TotalCashOrders = totalCashOrders
        self.TotalCardOrders = totalCardOrders
        self.TotalMultiPayOrders = totalMultiPayOrders
    }

}
