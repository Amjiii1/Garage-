//
//  CallEngine.swift
//  Garage
//
//  Created by Amjad on 03/04/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import Foundation
import Alamofire

class CallEngine {
    
//    static var LiveURL = "http://api-v1.isalesgarage.com/api/"
//    static var localURL = "http://garageapi.isalespos.com/api/"
    
    static var GlocalURL = "http://api-uat.garage.sa/api/"
    static var GliveURL = "http://api-live.garage.sa/api/"
        static var baseURL =    GlocalURL
    
    
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
    static let Notespost = "notes/add/"
    static let checklistpost = "order/carinspection/"
    static let checkoutDone = "orderlist/checkout/done/"
    static let checkoutHold = "orderlist/checkout/checkout/"
    static let checkoutwork = "orderlist/checkout/work/"
    static let subusers = "subusers/list/"
    static let checkout = "order/checkout"
    static let xReport = "report/x/"
    static let zReport = "report/z/"
    static let carScan = "car/scan/plateno"
    static let Printerletter = "order/printletter/"
    
    
    static var timeout = 30.0
   //  private var printer: Epos2Printer?
    
    
    
    
    
//    class func printXReport(completion: @escaping (_ savedChanges: Bool,_ message:String) -> Void){
//
//        //        let URL = "\(baseURL)\(xReport)\(Defaults.getUserSession())"
//        //let session = UserInfo.sharedInstance.Session
//
//        let URL = "\(baseURL)\(xReport)\(Constants.sessions)"
//        print(URL)
//
//        var mutableURLRequest = URLRequest(url: NSURL(string: URL)! as URL)
//        mutableURLRequest.timeoutInterval = timeout
//        mutableURLRequest.httpMethod = "GET"
//
//        Alamofire.request(mutableURLRequest)
//            .validate()
//            .responseData { response in
//
//                do {
//
//                    let json = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers)
//                    var responseObject = json as! [String:Any]
//                    let status = responseObject["Status"] as! Int
//                    if status == 1 {
//                        if let resp = responseObject["xreport"] as? [[String:Any]] {
//
//
//
//                            if(resp.count > 0) {
//                                //                                for report in resp {
//                                //                                let xreport = Utilities.getXReport(reponseObject: report)
//                                //                                Utilities.printXReport(xReport: xreport)
//                                //                                }
//                                //   for report in resp { //for i in 0...3  {  //
//                                for report in resp {
//                                    let zReport = UIUtility.getXReport(reponseObject: report)
//                                    report.values
//
//                                    //let report =   Utilities.printXReport(xReport: zReport)
//
//                                    let printer =   PrintJobHelper.getPrinterForCheckoutPrinting()
//                                    if(printer != nil) {
//                                        print(printer)
//                                        let printerQueue = PrinterQueue(xReport: true)
//
//                                        //PrintJobHelper.printerQueue(Printer: xReport)
//
////                                        printerQueue.xReportObject = zReport
////                                         printerQueue.currentPrinter = _Printer(printer: printer!)
////                                        AvailableItems.sharedInstance.printerQueue.append(printerQueue)
//                                    }
//                                }
//                                // }
//                                completion(true,"Success")
//                            }
//                            else {
//                                completion(true,"No orders found to be printed")
//                            }
//                        }
//                        else {
//
//                            completion(false,"Wrong Response")
//                        }
//                    }
//                    else {
//                        if let desc = responseObject["Description"] as? String {
//                            completion(false,desc)
//                        }
//                        else {
//                            completion(false,"Fetch failed")
//                        }
//                    }
//
//
//                }
//                catch (let exception){
//                    print(exception)
//                    completion(false,"Internet issue")
//                }
//
//
//        }
//
//    }
    
    
    
    
    
    
    
    
    
    

 }


//http://api-v1.isalesgarage.com/api/login/POS-KXCBSH
