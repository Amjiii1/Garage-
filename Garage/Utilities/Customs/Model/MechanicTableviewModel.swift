//
//  MechanicTableviewModel.swift
//  Garage
//
//  Created by Amjad on 10/05/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit

class MechanicTableviewModel: NSObject {

    var finishedTransactionNo: Int?
    var finishedMakerName: String?
    var finishedModelName: String?
    var finishedRegistrationNo: String?
    var finishedOrderID: Int?
    var finishedOrderNo: Int?
    var finishedSNo: Int?
    var finishedCarID: Int?
    var finishedCustomerID: Int?
    var finishedMakeID: Int?
    var finishedModelID: Int?
    var finishedYear: Int?
    var finishedLocationID: Int?
    var finishedVinNo: String?
    var finishedEngineType: String?
    var finishedBayName: String?
    var finishedBayID: Int?
    
    
    
    override init() {
        
    }
    
    
    init(finishedTransactionNo: Int, finishedMakerName: String, finishedModelName: String, finishedRegistrationNo: String, finishedOrderID: Int, finishedOrderNo: Int, finishedSNo: Int, finishedCarID: Int, finishedCustomerID: Int, finishedMakeID: Int, finishedModelID: Int, finishedYear: Int, finishedLocationID: Int, finishedVinNo: String, finishedEngineType: String?, finishedBayName: String, finishedBayID: Int){
        
        self.finishedTransactionNo = finishedTransactionNo
        self.finishedMakerName =  finishedMakerName
        self.finishedModelName =  finishedModelName
        self.finishedRegistrationNo =  finishedRegistrationNo
        self.finishedOrderID =  finishedOrderID
        self.finishedOrderNo =  finishedOrderNo
        self.finishedSNo =  finishedSNo
        self.finishedCarID =  finishedCarID
        self.finishedCustomerID =  finishedCustomerID
        self.finishedMakeID =  finishedMakeID
        self.finishedModelID =  finishedModelID
        self.finishedYear =  finishedYear
        self.finishedLocationID =  finishedLocationID
        self.finishedVinNo =  finishedVinNo
        self.finishedEngineType =  finishedEngineType
        self.finishedBayName =  finishedBayName
        self.finishedBayID =  finishedBayID
        
    }
    
    
    
    init?(DetailList: [String: Any]) {
        guard let finishedTranscNO = DetailList["TransactionNo"] as? Int,
            let finishedmaker = DetailList["MakerName"] as? String,
            let finishedmodel = DetailList["ModelName"] as? String,
            let finishedplate = DetailList["RegistrationNo"] as? String,
            let finishedOrderid = DetailList["OrderID"] as? Int,
            let finishedOrderno = DetailList["OrderNo"] as? Int,
            let finishedSerial = DetailList["SNo"] as? Int,
            let finishedCarid = DetailList["CarID"] as? Int,
            let finishedCustomerid = DetailList["CustomerID"] as? Int,
            let finishedMakeid = DetailList["MakeID"] as? Int,
            let finishedModelid = DetailList["ModelID"] as? Int,
            let finishedYear = DetailList["Year"] as? Int,
            let finishedLocationid = DetailList["LocationID"] as? Int,
            let finishedVinno = DetailList["VinNo"] as? String,
            let finishedEnginetype = DetailList["EngineType"] as? String,
            let finishedbayName = DetailList["BayName"] as? String,
            let finishedbayID = DetailList["BayID"] as? Int
            
            else { return }
        self.finishedTransactionNo = finishedTranscNO
        self.finishedMakerName = finishedmaker
        self.finishedModelName = finishedmodel
        self.finishedRegistrationNo = finishedplate
        self.finishedOrderID = finishedOrderid
        self.finishedOrderNo = finishedOrderno
        self.finishedSNo = finishedSerial
        self.finishedCarID = finishedCarid
        self.finishedCustomerID = finishedCustomerid
        self.finishedMakeID = finishedMakeid
        self.finishedModelID = finishedModelid
        self.finishedYear = finishedYear
        self.finishedLocationID = finishedLocationid
        self.finishedVinNo = finishedVinno
        self.finishedEngineType = finishedEnginetype
        self.finishedBayName = finishedbayName
        self.finishedBayID = finishedbayID
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}
