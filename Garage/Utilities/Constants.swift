//
//  Constants.swift
//  Garage
//
//  Created by Amjad Ali on 6/28/18.
//  Copyright © 2018 Amjad Ali. All rights reserved.
//

import Foundation


struct  Course {
    let message: Int
    
    init(json: [String: Any]) {
        message = (json["Status"] as? Int)!
    }
}


struct  login {
    let description: Int
    
    init(json: [String: Any]) {
      description  = (json["Status"] as? Int)!
    }
}


struct Constants {

    static let Searchapi = "http://garageapi.isalespos.com/api/car/search/\(Constants.platenmb)/null/POS-KXCBSH636726904049291864"
    static let Editapi = "http://garageapi.isalespos.com/api/Car/Edit"
    
    static let saveButtonImageName = "save-1"
    static let selectIconImage = "edit company code"
    static var platenmb = ""
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
    static var CarName = "CarName"
    static var CarDescription = "CarDescription"
    static var Color = "Color"
    static var ImagePath = "ImagePath"
    static var SessionID = "SessionID"
   
    
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

    
    
    
















