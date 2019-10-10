//
//  mechanicModel.swift
//  Garage
//
//  Created by Amjad on 09/04/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import Foundation



struct Orderdetail {
    
    let OrderDetailID: Int
    let OrderID: Int
    let ItemID: Int
    let ItemName: String
     let AlternateName: String
    let ItemImage: String
    let Quantity: Int
    let Price: Double
    let TotalCost: Int
    let LOYALTYPoints: Int
   // let isComplementory: Bool
    let StatusID: Int
    let ItemDate: String
    let Mode: String
    var orderPrinterType: PrinterType?
    
    
    
}
struct CompanyInfo {
    var logo: UIImage = UIImage()
    var name: String = ""
    var phoneNumber: String = ""
    var valueAddedTaxNumber: String = ""
    var cashier: String = "-"
    var vin: String = "-"
    var reprint: String = "-"
    var snapchatLink: String = ""
    var instagranLink: String = ""
    
    
    
}


struct Cars {
    
    let CarID: Int
    let CustomerID: Int
    let Name: String
    let VinNo: String
    let MakeID: Int
    let ModelID: Int
    let MakeName: String
    let ModelName: String
    let RegistrationNo: String
    let CheckLitre: Int
    let EngineType: String
    let RecommendedAmount: String
     let StatusID: Int

//
//"BinaryImage": null,
//"LocationID": null,
//"UserID": 0
}
