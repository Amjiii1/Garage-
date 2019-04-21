//
//  XReportModel.swift
//  Garage
//
//  Created by Amjad on 27/07/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit

class XReportModel: NSObject {

    var TotalSales: Float?
    var MinusDiscount: Float?
    var MinusVoid: Float?
    var MinusComplimentory: Float?
    var MinusReturn: Float?
    var MinusTax: Float?
    var NetSales: Float?
    var PlusGratuity: Float?
    var PlusCharges: Float?
    var TotalTendered: Float?
    var Cash: Float?
    var Card: Float?
    var Loyality: Float?
    var GiftCard: Float?
    var Coupons: Float?
    var TotalTransactionType: Float?
    var TotalCashOrders: Int?
    var TotalCardOrders: Int?
    var TotatMultiPaymentOrders: Int?
    var TotalVoidOrders: Int?
    var TotalReturnOrders: Int?
    var TotalOrders: Int?
    var date: String?
    
    
    
    
   
    override init() {
        
    }
    
    
    init(TotalSales: Float, MinusDiscount: Float, MinusVoid: Float, MinusComplimentory: Float, MinusReturn: Float, MinusTax: Float, NetSales: Float, PlusGratuity: Float, PlusCharges: Float, TotalTendered: Float, Cash: Float, Card: Float, Loyality: Float, GiftCard: Float, Coupons: Float?,TotalTransactionType: Float, TotalCashOrders: Int, TotalCardOrders: Int, TotatMultiPaymentOrders: Int, TotalVoidOrders: Int, TotalReturnOrders: Int, TotalOrders: Int, date: String){
        
        self.TotalSales = TotalSales
        self.MinusDiscount =  MinusDiscount
        self.MinusVoid =  MinusVoid
        self.MinusComplimentory =  MinusComplimentory
        self.MinusReturn =  MinusReturn
        self.MinusTax =  MinusTax
        self.NetSales =  NetSales
        self.PlusGratuity =  PlusGratuity
        self.PlusCharges =  PlusCharges
        self.TotalTendered =  TotalTendered
        self.Cash =  Cash
        self.Card =  Card
        self.Loyality =  Loyality
        self.GiftCard =  GiftCard
        self.Coupons =  Coupons
        self.TotalTransactionType =  TotalTransactionType
        self.TotalCashOrders =  TotalCashOrders
        self.TotalCardOrders =  TotalCardOrders
        self.TotatMultiPaymentOrders =  TotatMultiPaymentOrders
        self.TotalVoidOrders =  TotalVoidOrders
        self.TotalReturnOrders =  TotalReturnOrders
        self.TotalOrders =  TotalOrders
        self.date =  date
        
        
        
    }
    
    
    
//    init?(XreportList: [String: Any]) {
//        guard let totalSales = XreportList["TotalSales"] as? String,
//            let minusDiscount = XreportList["MinusDiscount"] as? Float,
//            let minusVoid = XreportList["MinusVoid"] as? Float,
//            let minusComplimentory = XreportList["MinusComplimentory"] as? Float,
//            let minusReturn = XreportList["MinusReturn"] as? Float,
//            let minusTax = XreportList["MinusTax"] as? String,
//            let netSales = XreportList["NetSales"] as? String,
//            let plusGratuity = XreportList["PlusGratuity"] as? Float,
//            let plusCharges = XreportList["PlusCharges"] as? Float,
//            let totalTendered = XreportList["TotalTendered"] as? String,
//            let cash = XreportList["Cash"] as? String,
//            let card = XreportList["Card"] as? Float,
//            let loyality = XreportList["Loyality"] as? Float,
//            let giftCard = XreportList["GiftCard"] as? Float,
//            let coupons = XreportList["Coupons"] as? Float,
//            let totalCashOrders = XreportList["TotalCashOrders"] as? Int,
//            let totalCardOrders = XreportList["TotalCardOrders"] as? Int,
//            let totatMultiPaymentOrders = XreportList["TotatMultiPaymentOrders"] as? Int,
//            let totalVoidOrders = XreportList["TotalVoidOrders"] as? Int,
//            let totalReturnOrders = XreportList["TotalReturnOrders"] as? Int,
//            let totalTransactionType = XreportList["TotalTransactionType"] as? String,
//            let totalOrders = XreportList["TotalOrders"] as? Int
//            
//            else { return }
//        self.TotalSales = totalSales
//        self.MinusDiscount = minusDiscount
//        self.MinusVoid = minusVoid
//        self.MinusComplimentory = minusComplimentory
//        self.MinusReturn = minusReturn
//        self.MinusTax = minusTax
//        self.NetSales = netSales
//        self.PlusGratuity = plusGratuity
//        self.PlusCharges = plusCharges
//        self.TotalTendered = totalTendered
//        self.Cash = cash
//        self.Card = card
//        self.Loyality = loyality
//        self.GiftCard = giftCard
//        self.Coupons = coupons
//        self.TotalCashOrders = totalCashOrders
//        self.TotalCardOrders = totalCardOrders
//        self.TotatMultiPaymentOrders = totatMultiPaymentOrders
//        self.TotalVoidOrders = totalVoidOrders
//        self.TotalReturnOrders = totalReturnOrders
//        self.TotalTransactionType = totalTransactionType
//        self.TotalOrders = totalOrders
//        
//        
//    }
    
    
    
    
}
