//
//  CheckoutViewModel.swift
//  Garage
//
//  Created by Amjad on 14/06/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import Foundation
import CoreData

class CheckoutViewModel {
    weak var checkoutVC: CheckOutPopView?
    
    var cashAmountTender = 0.0
    
    var cardAmountTender = 0.0
    
  //  var discountAmount = 0.0 {
//        didSet {
//          //  self.discountAmount = self.discountAmount.myRounded()
//            checkoutVC?.discountLbl.text = String(discountAmount)
//            self.totalPrice = self.originalAmount - discountAmount
//        }
//    }
    
    var amountTendered = 0.0 {
        didSet (fromOldValue) {
            print("current amount is \(amountTendered) old was \(fromOldValue)")
            if let grandtotalText = checkoutVC?.grandtotalLbl.text, let grand = Double(grandtotalText) {
                let balance = grand - amountTendered
                self.newBalance(balance: balance)
            }
        }
    }
    
    private func newBalance(balance: Double) {
        if balance >  0 {
            checkoutVC?.balancetxtf.text = ("\(balance)")
    
           
        }
        else {
            checkoutVC?.balancetxtf.text = "0.0"
           // checkoutVC?.balancetxtf.text = ("\(abs(balance))")
            
        }
    }
    
//    var totalPrice: Double = 0.0 {
//        didSet {
//            self.totalPrice = totalPrice.myRounded()
//            checkoutVC?.lblCheckoutTotal.text = ("\(totalPrice)")
//            checkoutVC?.lblCheckoutGrandTotal.text = ("\(totalPrice)")
//            checkoutVC?.lblBalance.text = ("\(totalPrice)") // as in start balance is same as total
//        }
//    }
//
//    var originalAmount = 0.0 {
//        didSet {
//            self.originalAmount = originalAmount.myRounded()
//        }
//    }
//
//    private func fetchDiscount() -> Discount? {
//        do{
//            let fReq: NSFetchRequest = Discount.fetchRequest()
//            fReq.fetchLimit = 1
//            let results = try DataController.context.fetch(fReq)
//            return results.first
//        }
//        catch {
//            print("error in retrieving")
//        }
//        return nil
//    }
//
//    private func resetlblBalance() {
//        if let tendered = checkoutVC?.txtAmountTendered.text, let doubleTendered = Double(tendered) {
//            amountTendered = doubleTendered
//        }
//    }
//
//    private func newBalance(balance: Double) {
//        let balanceRounded = balance.myRounded()
//        if balanceRounded >  0 {
//            checkoutVC?.lblBalance.text = ("\(balanceRounded)")
//            checkoutVC?.lblBalance.textColor = UIColor.bgColors.marachinoRed
//            checkoutVC?.lblBalanceHeading.text = "Balance"
//            checkoutVC?.cashBackLbl.text = "0"
//        }
//        else {
//            checkoutVC?.lblBalanceHeading.text = "Return"
//            checkoutVC?.lblBalance.text = ("\(abs(balanceRounded))")
//            checkoutVC?.lblBalance.textColor = UIColor.bgColors.lightishBlue
//            checkoutVC?.cashBackLbl.text =  ("\(abs(balanceRounded))")
//        }
//    }
//
//    func calculateAndUpdateUI() {
//        let discount = fetchDiscount()
//
//        if let discount = discount {
//            if let discountType = DiscountTypeString(rawValue: discount.typeOfDiscount) {
//
//                switch discountType {
//
//                case DiscountTypeString.Amount:
//                    discountAmount = discount.value
//
//                case DiscountTypeString.Percentage:
//                    let discountper = discount.value
//                    let total = originalAmount * (discountper / 100)
//                    discountAmount = total
//
//                case DiscountTypeString.Trend:
//                    print("Trend")
//                }
//            }
//        }
//        else {
//            discountAmount = 0
//            if let originalTotal = checkoutVC?.subTotalLbl.text , let originalTotalDouble = Double(originalTotal) {
//                totalPrice = originalTotalDouble
//            }
//        }
//        resetlblBalance()
//    }
//
//    deinit {
//        print("CheckoutViewModel deinit called")
//    }
}

