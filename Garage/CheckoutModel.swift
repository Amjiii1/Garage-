//
//  CheckoutModel.swift
//  Garage
//
//  Created by Amjad on 30/05/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit

class CheckoutModel: NSObject {

    var TransactionNo: Int?
    var MakerName: String?
    var ModelName: String?
    var RegistrationNo: String?
    var OrderID: Int?
    var OrderNo: Int?
    var SNo: Int?
    var CarID: Int?
    var CustomerID: Int?
    var MakeID: Int?
    var ModelID: Int?
    var Year: Int?
    var LocationID: Int?
    var VinNo: String?
    var EngineType: String?
    var BayName: String?
    var BayID: Int?
    
    
    
    
    override init() {
        
    }
    
    
    init(TransactionNo: Int, MakerName: String, ModelName: String, RegistrationNo: String, OrderID: Int, OrderNo: Int, SNo: Int, CarID: Int, CustomerID: Int, MakeID: Int, ModelID: Int, Year: Int, LocationID: Int, VinNo: String, EngineType: String?, BayName: String, BayID: Int){
        
        self.TransactionNo = TransactionNo
        self.MakerName =  MakerName
        self.ModelName =  ModelName
        self.RegistrationNo =  RegistrationNo
        self.OrderID =  OrderID
        self.OrderNo =  OrderNo
        self.SNo =  SNo
        self.CarID =  CarID
        self.CustomerID =  CustomerID
        self.MakeID =  MakeID
        self.ModelID =  ModelID
        self.Year =  Year
        self.LocationID =  LocationID
        self.VinNo =  VinNo
        self.EngineType =  EngineType
        self.BayName =  BayName
        self.BayID =  BayID
        
    }
    
    
    
    init?(checkoutlist: [String: Any]) {
        guard let TranscNO = checkoutlist["TransactionNo"] as? Int,
            let maker = checkoutlist["MakerName"] as? String,
            let model = checkoutlist["ModelName"] as? String,
            let plate = checkoutlist["RegistrationNo"] as? String,
            let Orderid = checkoutlist["OrderID"] as? Int,
            let Orderno = checkoutlist["OrderNo"] as? Int,
            let Serial = checkoutlist["SNo"] as? Int,
            let Carid = checkoutlist["CarID"] as? Int,
            let Customerid = checkoutlist["CustomerID"] as? Int,
            let Makeid = checkoutlist["MakeID"] as? Int,
            let Modelid = checkoutlist["ModelID"] as? Int,
            let Year = checkoutlist["Year"] as? Int,
            let Locationid = checkoutlist["LocationID"] as? Int,
            let Vinno = checkoutlist["VinNo"] as? String,
            let Enginetype = checkoutlist["EngineType"] as? String,
            let bayName = checkoutlist["BayName"] as? String,
            let bayID = checkoutlist["BayID"] as? Int
            
            else { return }
        self.TransactionNo = TranscNO
        self.MakerName = maker
        self.ModelName = model
        self.RegistrationNo = plate
        self.OrderID = Orderid
        self.OrderNo = Orderno
        self.SNo = Serial
        self.CarID = Carid
        self.CustomerID = Customerid
        self.MakeID = Makeid
        self.ModelID = Modelid
        self.Year = Year
        self.LocationID = Locationid
        self.VinNo = Vinno
        self.EngineType = Enginetype
        self.BayName = bayName
        self.BayID = bayID
    
    
    
    
    
    
}
}
