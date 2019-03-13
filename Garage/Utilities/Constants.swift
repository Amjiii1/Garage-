//
//  Constants.swift
//  Garage
//
//  Created by Amjad Ali on 6/28/18.
//  Copyright © 2018 Amjad Ali. All rights reserved.
//

import Foundation



final class Shared {
    static let shared = Shared()
    
    var companyName : String!
    
}

struct  Course {
    let message: Int
    
    init(json: [String: Any]) {message = (json["Status"] as? Int)!
    }
}


struct  login {
    let status: Int
   
    // let User: [String: Any]
    
    init(json: [String: Any]) {
      status  = (json["Status"] as? Int)!
     
        
   // User = (json["User"] as? [String: Any])!
    }
}


struct Constants {

   // static let Searchapi = "http://garageapi.isalespos.com/api/car/search/\(Constants.platenmb)/null/POS-KXCBSH636726904049291864"
    
    static let saveButtonImageName = "save-1"
    static let selectIconImage = "edit company code"
    static var platenmb = "0"
    static var vinnmb = "0"
    
    
    // postApi's
    static let Cars = "Cars"
    static let MakerName = "MakerName"
    static var VinNo = "VinNo"
    static var CustomerContact = "CustomerContact"
    static var CheckLitre = "CheckLitre"
    static var Year = "Year"
    static var RecommendedAmount = "RecommendedAmount"
    static var ModelName = "ModelName"
    static var RegistrationNo = "RegistrationNo"
    static var MakeID = "MakeID"
    static var ModelID = "ModelID"
    static var CarID = "CarID"
    static var CustomerID = "CustomerID"
    static var OrderID = "OrderID"
    static var CarName = "CarName"
    static var CarDescription = "CarDescription"
    static var Color = "Color"
    static var ImagePath = "ImagePath"
    static var SessionID = "SessionID"
    static var EngineType = "EngineType"
    static var OrderNo = "OrderNo"
    static var BayID = "BayID"
    static var type = "Type"
    static var OrderTakerID = "OrderTakerID"
    static var OrderPunchDt = "OrderPunchDt"
    static var StatusID = "StatusID"
    static var Items = "Items"
    static var NotesComment = "NotesComment"
    static var NotesStatus = "NotesStatus"
    static var NotesImages = "NotesImages"
    static var InspectionDetails = "InspectionDetails"
    static var Date = "Date"
    static var AmountTotal = "AmountTotal"
    static var GrandTotal = "GrandTotal"
    static var AmountPaid = "AmountPaid"
    static var Tax = "Tax"
    static var WorkerID = "WorkerID"
    static var AssistantID = "AssistantID"
    
    static var Status = "Status"
    static var Description = "Description"
    static var wrong = "Something went wrong"
    static var invalid = "Invalid sessions"
    static var occured = "Error occured"
    
    
    // viewcontrollers
    static var interneterror = "Login failed! Check internet"
    static var ReceptionalistView = "ReceptionalistView"
    static var ReceptionalistVc = "ReceptionalistVc"
    static var BayForWelcome = "BayForWelcome"
    static var BayForWelcomeVc = "BayForWelcomeVc"
    static var CarScan = "CarScan"
    static var carScannerVc = "carScannerVc"
    static var AddnewCar = "AddnewCar"
    static var addNewCarVc = "addNewCarVc"
    static var WelcomeView = "WelcomeView"
    static var WelcomeVc = "WelcomeVc"
    static var MechanicView = "MechanicView"
    static var MechanicVc = "MechanicVc"
    static var CheckoutView = "CheckoutView"
    static var CheckoutVc = "CheckoutVc"
    static var FooterView = "FooterViewWithTabs"
    static var PopOver = "PopOver"
    static var PopOverVc = "PopOverVc"
    static var ServiceCart = "ServiceCart"
    static var ServiceCartVc = "ServiceCartVc"
    static var HistoryCar = "HistoryCar"
    static var historycarVc = "historycarVc"
    static var Receiptpopover = "Receiptpopover"
    static var ReceiptpopVc = "ReceiptpopVc"
    static var notespopup = "notespopup"
    static var notesPopupVc = "notesPopupVc"
    static var CheckCarController = "CheckCarController"
    static var CheckCarControllerVc = "CheckCarControllerVc"
    static var Subusers = "Subusers"
    static var SubusersVc = "SubusersVc"
    static var VoucherView = "VoucherView"
    static var LoyaltyView = "LoyaltyView"
    static var GiftCardView = "GiftCardView"
    static var CardView = "CardView"
    static var CashView = "CashView"
    
    
    
    
    static var OrderNoData = 0
    static var CarIDData = 0
    static var CarNameData = ""
    static var MakeIDData = 0
    static var ModelIDData = 0
    static var ColorData = ""
    static var CustomerIDData = ""
    static var OrderIDData = 0
    static let User = "User"
    static var sessions = ""
    static var ordertracker = ""
    static var searchedplatenmb = ""
    static var currenttime = ""
    static var bayid = 0
     static var bayname = "B0"
    static var SubUserID = 0
    static var FullName = "A"
    static var history = 0
    static var currentdate = ""
    static var totalprice: Double = 0
    static var counterQTY = 1
    static var carmakeid = 2
    static var editOrderid = 0
    static var flagEdit = 0
    static var BMake = ""
    static var Bplate = ""
    static var mode = "Add"
    static var modeupdate = "Update"
    static var bayflag = 0
    static var orderidmechanic = 0
    static var caridmechanic = 0
    static var comment = String()
    static var SuperUserID = "SuperUserID"
    static var SuperUser = 0
    static var Data = "Data"
    static var checklistbtn = 0
    static var checkflag = 0
    static var editcheckout = 0
    static var orderstatus = 0
    static var workerflag = 0
    static var checkoutGrandtotal = 0.0
    static var subtotal = 0.0
    static var checkoutQTY = 1.0
    static var checkouttax = 0.0
    static var tax = "0"
    static var percent = 0
    static var checkoutorderid = 0
    static var checkoutcarid = 0
    static let _4inchScale:Float = 576
    static var Printer = ""//:CGFloat = 576
    static var checkoutplatenmb = ""
    static var checkoutvin = ""
    static var checkoutcarmake = ""
    static var checkoutcarmodel = ""
    static var checkoutbayname = ""
    static var checkoutyear = 0
    static var checkoutcustm = 0
    
    
  
    
    
  
    
     
    
}

struct product {
    
//    let : Int
    let ItemName: String
}



enum ConnectionMedium: Int {
    case bluetooth = 1
    case localAreaNetwork
}






struct  Cardetails {
    let description: String
    let status: Int
    let model: String
    let make: String
    let vin: String
    let year: String
    let cars: [[String: Any]]
   
    
    init(json: [String: Any]) {
        status = (json["Status"] as? Int)!
        description = json["Description"] as? String ?? ""
        model = json["ModelName"] as? String ?? ""
        make = json["MakerName"] as? String ?? ""
        vin = json["VinNo"] as? String ?? ""
        year = json["Year"] as? String ?? ""
        cars = (json["Cars"] as? [[String: Any]])!
       
    }
}


struct  EditCar {
    let response: String
    let status: String
    
    init(json: [String: Any]) {
        response = json["Description"] as? String ?? ""
        status = json["1"] as? String ?? ""
        
    }
}

    
    
    
















