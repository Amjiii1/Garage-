//
//  CallEngine.swift
//  Garage
//
//  Created by Amjad on 03/04/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import Foundation

class CallEngine {
    
    
    static var LiveURL = "http://api-v1.isalesgarage.com/api/"
    static var localURL = "http://garageapi.isalespos.com/api/"
    static var baseURL =  localURL
    
    
    
    static let editCar = "Car/Edit"
    static let addCar = "Car/add"
    static let Welcomelistall = "orderlist/all/"
    static let Welcomelistassigned = "orderlist/assigned/"
    static let Welcomelistwaitlist = "orderlist/waitlist/"
    static let productapi = "products/list/"
    static let BusinessCodeapi = "login"
    static let LoginApi = "login/signin"
    static let MakelistApi = "car/makelist/0/"
    static let ModellistApi = "car/modellist/0/"
    static let SearchCarApi = "car/search/"
    static let HistoryApi = "order/history/"
    static let BayAssignApi = "bay/list/"
    static let OrderPunchApi = "order/new"
    static let LoadCardetailsapi = "order/load/"
    static let notesImguploadapi = "car/notes/image"
    static let OrderDetails = "order/details"
    static let OrderEdit = "order/edit"
    static let Unlist = "order/updatestatus/unlist"
    static let Assigned = "order/updatestatus/assigned"
    static let UnAssigned = "order/updatestatus/assigned"
    static let finishedOrderlist = "orderlist/service/all"
    static let WorkDone = "order/updatestatus/workdone"
    static let carinspection = "car/inspection/0"
    
    
    

 }
//http://api-v1.isalesgarage.com/api/login/POS-KXCBSH
