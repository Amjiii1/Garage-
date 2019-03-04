////
////  PrintOrderStructs.swift
////  Garage
////
////  Created by Amjad on 13/06/1440 AH.
////  Copyright © 1440 Amjad Ali. All rights reserved.
////
//
//import Foundation
///// This struct is the order's object which is then sent to be printed (Kitchen and Checkout)
//struct OrderDetailStruct {
//    var transactionId: String
//    var orderNumber: Int64
//    var dateCreated: NSDate
//    var orderTaker: String?
//    var orderType: String
//    var table: String
//    var paymentDetails: PaymentDetails?
//    var orderPrinterType: PrinterType?
//    var subUserID: Int64
//}
//
//struct PaymentDetails {
//    var subTotal: Double = 0
//    var discountValue: Double = 0
//    var discountPercent: Double = 0
//    var valueAddedTax: Double = 0
//    var grandTotal: Double = 0
//    var paymentVia: String = ""
//}
//
//struct CompanyInfo {
//   // var logo: UIImage = UIImage()
//    var name: String = ""
//    var phoneNumber: String = ""
//    var valueAddedTaxNumber: String = ""
//    var snapchatLink: String = ""
//    var instagranLink: String = ""
//}
//
///// ----------------
//
//struct CartItemStruct {
//    var id: Int16
//
//    var quantity: Float
//    var totalPrice: Double
//    var totalPriceVAT: Double
//    var discount: Double
//    var isComplimentary: Bool
//    var clientDateStamp: NSDate
//
//    var item: ItemStruct
//    var selectedModifiers: [ModifierStruct]
//
//    var modificationMode: ModificationMode
//    var state: OrderState
//    var status: OrderStatus
//    var printStatus: PrintStatus
//}
//
//struct ItemStruct {
//    var itemID: Int
//    var name: String
//    var alternateName: String?
//    var price: Double
//    var priceWithVAT: Double
//    var subcategory: Subcategory?
//}
//
//
//struct ModifierStruct: Hashable {
//    var modifierId: Int
//    var name: String
//    var alternateName: String
//    var quantity: Double
//    var price: Double
//    var priceWithVAT: Double
//    var isComplimentary: Bool
//
//    var modificationMode: ModificationMode
//    var state: OrderState
//    var status: OrderStatus
//
//    var printStatus: PrintStatus
//}
