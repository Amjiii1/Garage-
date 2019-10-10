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
    static var OrderID = "OrderID"  // historycontroller
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
    static var CheckLiters = "CheckLiters"
    static var NotesComment = "NotesComment" //historycontroller
    static var NotesStatus = "NotesStatus"
    static var NotesImages = "NotesImages" //historycontroller
    static var InspectionDetails = "InspectionDetails"  //historycontroller
    static var Date = "Date"  // used in zxreport
    //CheckoutApi
    static var CheckoutDetails = "CheckoutDetails"
    static var PaymentMode = "PaymentMode"
    static var AmountTotal = "AmountTotal"
    static var GrandTotal = "GrandTotal"
    static var AmountPaid = "AmountPaid"
    static var Tax = "Tax"
    static var WorkerID = "WorkerID"
    static var AssistantID = "AssistantID"
    static var SessionA = "Session"
    static var SubUserIDA = "SubUserID"
    static var VATNo = "VATNo"
    static var LocationNameA = "LocationName"
    static var FirstNameA = "FirstName"
    static var ReceiptInfo = "ReceiptInfo"
    static var CompanyPhonesA = "CompanyPhones"
    static var InstagramLinkA = "InstagramLink"
    static var SnapchatLinkA = "SnapchatLink"
    static var FooterA = "Footer"
    static var UserExistent = "User does Not Exist"
    static var Loginfailed = "Login failed! Try Again"
    static var loggedIn = "loggedIn"
    static var BusinessCodeSuccess = "BusinessCode Verified Successfully"
    static var BusinessCodeFailed = "BusinessCode Verified Failed!"
    
    
    
    //XZ-Report
    static var TotalSales = "TotalSales"
    static var MinusDiscount = "MinusDiscount"
    static var MinusVoid = "MinusVoid"
    static var MinusComplimentory = "MinusComplimentory"
    static var MinusReturn = "MinusReturn"
    static var MinusTax = "MinusTax"
    static var NetSales = "NetSales"
    static var PlusGratuity = "PlusGratuity"
    static var PlusCharges = "PlusCharges"
    static var TotalTendered = "TotalTendered"
    static var Cash = "Cash"
    static var Card = "Card"
    static var Loyality = "Loyality"
    static var GiftCard = "GiftCard"
    static var Coupons = "Coupons"
    static var TotalTransactionType = "TotalTransactionType"
    static var TotalCashOrders = "TotalCashOrders"
    static var TotalCardOrders = "TotalCardOrders"
    static var TotatMultiPaymentOrders = "TotatMultiPaymentOrders"
    static var TotalVoidOrders = "TotalVoidOrders"
    static var TotalReturnOrders = "TotalReturnOrders"
    static var TotalOrders = "TotalOrders"
    // service cart
    
    static var CategoriesList = "CategoriesList"
    static var SubCategoriesList = "SubCategoriesList"
    static var CategoryID = "CategoryID"
    static var Name = "Name"   // historyview
    static var AlternateName = "AlternateName"
    static var Image = "Image"
    static var DisplayOrder = "DisplayOrder"
    static var LastUpdatedDate = "LastUpdatedDate"
    static var ItemsList = "ItemsList"
    static var SubCategoryID = "SubCategoryID"
    static var ItemID = "ItemID"  // HistoryView controller
    static var Barcode = "Barcode"
    static var ItemType = "ItemType"
    static var Price = "Price"   // HistoryView controller
    
    // Settings's view
    
    static var General = "General"
    static var GeneralVCID = "GeneralVCID"
    static var Hardware = "Hardware"
    static var HardwareVCID = "HardwareVCID"
    static var Receipt = "Receipt"
    static var ReceiptVCID = "ReceiptVCID"
    static var QuickPay = "QuickPay"
    static var QuickPayVCID = "QuickPayVCID"
    static var Database = "Database"
    static var DatabaseVCID = "DatabaseVCID"
    static var Language = "Language"
    static var LanguageVCID = "LanguageVCID"
    static var Updates = "Updates"
    static var UpdatesVCID = "UpdatesVCID"
    
    
    //checkoutpop
    static var CheckoutPopUp = "CheckoutPopUp"
    static var CheckOutPopVc = "CheckOutPopVc"
    
    
    // checkoutView
    
    static var OrdersList = "OrdersList"    // HistoryView controller
    static var OrderItems = "OrderItems"    // HistoryView controller
    
    
    
    
    
    // historydetails
    static var historydetailview = "historydetailview"
    static var historydetailviewVc = "historydetailviewVc"
    
    
    // HistoryView controller
    static var CarModelName = "CarModelName"
    static var CarNoPlate = "CarNoPlate"
    static var ItemName = "ItemName"
   // static var AlternateName = "AlternateName"
    static var Quantity = "Quantity"
    static var OrderDetailID = "OrderDetailID"
    static var CarNotes = "CarNotes"
    static var NotesID = "NotesID"
    static var CheckList = "CheckList"
    static var CarInspectionID = "CarInspectionID"
    static var CarInspectionDetailID = "CarInspectionDetailID"
    static var Value = "Value"
    
    
    
    
    
    static var loginSucs = "Login Successfully"
    static var Status = "Status"   // used in servicecart
    static var Description = "Description"   // used in servicecart
//    static var wrong = "Something went wrong"
//    static var invalid = "Invalid sessions"
//    static var occured = "Error occured"
//    static var interneterror = "Login failed! Check internet"
    
    // viewcontrollers
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
    static var XZReportViewController = "XZReportViewController"
    static var XZReportViewControllerVc = "XZReportViewControllerVc"
    static var profilepop = "profilepop"
    static var language = 0
    static var savelang = "savelang"
    
    
    static var Subusers = "Subusers"
    static var SubusersVc = "SubusersVc"
    static var VoucherView = "VoucherView"
    static var LoyaltyView = "LoyaltyView"
    static var GiftCardView = "GiftCardView"
    static var CardView = "CardView"
    static var CashView = "CashView"
    static var superuserA = "superuser"
    
    //localization
    
    static let wait = NSLocalizedString("Pleasewait", comment: "")
    
    
    //localization
    
    
    
    static var paymentflag = 1
    static var carliterID = 0
    static var OrderNoData = 0
    static var CarIDData = 0
    static var CarNameData = ""
    static var MakeIDData = 0
    static var ModelIDData = 0
    static var ColorData = ""
    static var CustomerIDData = ""
    static var OrderIDData = 0
    static var transedit = 0
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
    static var checkoutGrandtotal: Double = 0.0.myRounded(toPlaces: 2)
    static var checkoutGrandtotalbacken: Double = 0.0.myRounded(toPlaces: 2)
    static var subtotal: Double = 0.0.myRounded(toPlaces: 2)
    static var checkoutQTY = 1.0
    static var checkouttax: Double = 0.0.myRounded(toPlaces: 2)
    static var checkoutdiscount: Double = 0.0.myRounded(toPlaces: 2)
    static var tax = "0"
    static var percent = 0
    static var historytrans = 0
    static var historydiscount: Double = 0.0
    static var historysubtotal: Double = 0.0
    static var historygrandtotal: Double = 0.0
    static var historytax: Double = 0.0
    static var checkoutorderid = 0
    static var checkoutcarid = 0
    static var checkoutPDF = 0
    static let _4inchScale:Float = 576
    static var Printer = ""//:CGFloat = 576
    static var printermac = ""
    static var checkoutplatenmb = ""
    static var ZKm = ""
    static var ZRegistr = ""
    static var Zdate = ""
    static var FilterName = ""
    
    static var checkoutplatenmb1 = ""
    static var checkoutplatenmb2 = ""
    static var checkoutplatenmb3 = ""
    static var checkoutplatenmb4 = ""
    static var Checkoutdate = ""
    static var CardType = ""
    static var CardTypecheckout = ""
    static var zebra = ""
    
    static var PaymentModes = 0
    static var CashAmount = 0.0
    static var CardAmount = 0.0
    
    static var CashAmountcheckout = 0.0
    static var CardAmountcheckout = 0.0
    
    static var checkoutvin = ""
    static var checkoutcarmake = ""
    static var checkoutcarmodel = ""
    static var checkoutbayname = ""
    static var checkoutyear = 0
    static var checkoutCheckL = 0
    static var checkoutcustm = "-"
    static var checkoutmechanic = "-"
    static var checkoutstatus = 0
    static var checkoutorderNo = 0
    static let smallPrinter:CGFloat = 384
    static let mediumPrinter:CGFloat = 576
    static var discountValue: Double = 0
    static var VAT = "-"
    static var receiptphone = "-"
    static var receiptloc = "-"
    static var mechanicrec = 0
    static var LocationName = "-"
    static var CompanyPhones = "-"
    static var InstagramLink = "-"
    static var SnapchatLink = "-"
    static var Footer = "-"
    static var FirstName = "-"
    
    
    
     static let boldWritingReceipt:String = "SFProDisplay-Bold"
    static let WritingReceipt:String = "SFProDisplay-Bold"
    static let smallWritingReceiptSize:CGFloat = 10 * 2
//    static let boldWritingReceipt:String = "SFProDisplay-Bold"
//    static let boldWritingReceipt:String = "SFProDisplay-Bold"
    
    
    
    
    
  
    
    
  
    
     
    
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

    
    
    
















