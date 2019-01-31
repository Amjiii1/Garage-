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
    static var Status = "Status"
    static var Description = "Description"
    static var SuperUserID = "SuperUserID"
    static var SuperUser = 0
    static var Data = "Data"
  
    
    
  
    
     
    
}

struct product {
    
//    let : Int
    let ItemName: String
}






struct  Cardetails {
    let description: String
    let model: String
    let make: String
    let vin: String
    let year: String
    let cars: [[String: Any]]
   
    
    init(json: [String: Any]) {
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

    
    
    
















