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
    var RegistrationNoP1: String?
    var RegistrationNoP2: String?
    var RegistrationNoP3: String?
    var RegistrationNoP4: String?
    var CheckoutDate: String?
    var MechanicName: String?
    var OrderID: Int?
    var OrderNo: Int?
    var SNo: Int?
    var CarID: Int?
    var CustomerID: String?
    var MakeID: Int?
    var ModelID: Int?
    var Year: Int?
    var LocationID: Int?
    var VinNo: String?
    var EngineType: String?
    var BayName: String?
    var BayID: Int?
    var Status: Int?
    var PaymentMode: Int?
    var CardType: String?
    var CashAmount: Double?
    var CardAmount: Double?
    
  
    
    
    
    
    override init() {
        
    }
    
    
    init(TransactionNo: Int, MakerName: String, ModelName: String, RegistrationNo: String, RegistrationNoP1: String, RegistrationNoP2: String, RegistrationNoP3: String,RegistrationNoP4: String, CheckoutDate: String, MechanicName: String, OrderID: Int, OrderNo: Int, SNo: Int, CarID: Int, CustomerID: String, MakeID: Int, ModelID: Int, Year: Int, LocationID: Int, VinNo: String, EngineType: String?, BayName: String, BayID: Int, Status: Int, PaymentMode: Int, CardType: String, CashAmount: Double, CardAmount: Double){
        
        self.TransactionNo = TransactionNo
        self.MakerName =  MakerName
        self.ModelName =  ModelName
        self.RegistrationNo =  RegistrationNo
        self.RegistrationNoP1 =  RegistrationNoP1
        self.RegistrationNoP2 =  RegistrationNoP2
        self.RegistrationNoP3 =  RegistrationNoP3
        self.RegistrationNoP4 =  RegistrationNoP4
        self.CheckoutDate =  CheckoutDate
        self.MechanicName =  MechanicName
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
        self.Status =  Status
        self.PaymentMode =  PaymentMode
        self.CardType =  CardType
        self.CashAmount =  CashAmount
        self.CardAmount =  CardAmount
        
        
        
    }
    
    
    
    init?(checkoutlist: [String: Any]) {
        guard let TranscNO = checkoutlist["TransactionNo"] as? Int,
            let maker = checkoutlist["MakerName"] as? String,
            let model = checkoutlist["ModelName"] as? String,
            let plate = checkoutlist["RegistrationNo"] as? String,
            let plate1 = checkoutlist["RegistrationNoP1"] as? String,
            let plate2 = checkoutlist["RegistrationNoP2"] as? String,
            let plate3 = checkoutlist["RegistrationNoP3"] as? String,
            let plate4 = checkoutlist["RegistrationNoP4"] as? String,
            let checkoutDate = checkoutlist["CheckoutDate"] as? String,
            let mechanicName = checkoutlist["MechanicName"] as? String,
            let Orderid = checkoutlist["OrderID"] as? Int,
            let Orderno = checkoutlist["OrderNo"] as? Int,
            let Serial = checkoutlist["SNo"] as? Int,
            let Carid = checkoutlist["CarID"] as? Int,
            let Customerid = checkoutlist["CheckLitre"] as? String,
            let Makeid = checkoutlist["MakeID"] as? Int,
            let Modelid = checkoutlist["ModelID"] as? Int,
            let Year = checkoutlist["Year"] as? Int,
            let Locationid = checkoutlist["LocationID"] as? Int,
            let Vinno = checkoutlist["VinNo"] as? String,
            let Enginetype = checkoutlist["EngineType"] as? String,
            let bayName = checkoutlist["BayName"] as? String,
            let bayID = checkoutlist["BayID"] as? Int,
             let status = checkoutlist["Status"] as? Int,
            let paymentMode = checkoutlist["PaymentMode"] as? Int,
            let cardType = checkoutlist["CardType"] as? String,
           let cashAmount = checkoutlist["CashAmount"] as? Double,
           let cardAmount = checkoutlist["CardAmount"] as? Double
        
            else { return }
        self.TransactionNo = TranscNO
        self.MakerName = maker
        self.ModelName = model
        self.RegistrationNo = plate
         self.RegistrationNoP1 = plate1
         self.RegistrationNoP2 = plate2
         self.RegistrationNoP3 = plate3
         self.RegistrationNoP4 = plate4
         self.CheckoutDate = checkoutDate
         self.MechanicName = mechanicName
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
        self.Status = status
        self.PaymentMode = paymentMode
        self.CardType = cardType
        self.CashAmount = cashAmount
        self.CardAmount = cardAmount
    
    
    
    
    
    
}
}
