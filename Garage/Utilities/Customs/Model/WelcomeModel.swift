//
//  WelcomeModel.swift
//  Garage
//
//  Created by Amjad  on 10/01/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit

class WelcomeModel: NSObject {
     // static let shared = WelcomeModel()
    
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
    

    
    init?(OrdersList: [String: Any]) {
        guard let TranscNO = OrdersList["TransactionNo"] as? Int,
        let maker = OrdersList["MakerName"] as? String,
        let model = OrdersList["ModelName"] as? String,
        let plate = OrdersList["RegistrationNo"] as? String,
        let Orderid = OrdersList["OrderID"] as? Int,
        let Orderno = OrdersList["OrderNo"] as? Int,
        let Serial = OrdersList["SNo"] as? Int,
        let Carid = OrdersList["CarID"] as? Int,
        let Customerid = OrdersList["CustomerID"] as? Int,
        let Makeid = OrdersList["MakeID"] as? Int,
        let Modelid = OrdersList["ModelID"] as? Int,
        let Year = OrdersList["Year"] as? Int,
        let Locationid = OrdersList["LocationID"] as? Int,
        let Vinno = OrdersList["VinNo"] as? String,
        let Enginetype = OrdersList["EngineType"] as? String,
        let bayName = OrdersList["BayName"] as? String,
        let bayID = OrdersList["BayID"] as? Int
        
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
