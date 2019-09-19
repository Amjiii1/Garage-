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
    
    var discountAmount = 0.0 {
        didSet {
            self.discountAmount = self.discountAmount.myRounded()
            checkoutVC?.DiscountAmount.text = String(discountAmount)
            Constants.checkoutdiscount = discountAmount
            self.totalPrice =  Constants.subtotal - discountAmount // discount field
            Constants.checkouttax = self.totalPrice * Double(Constants.tax)!
            checkoutVC?.TaxAmount.text = String(format: "%.2f", Constants.checkouttax)
            self.totalPrice =  self.totalPrice + Constants.checkouttax
            Constants.checkoutGrandtotal =  self.totalPrice
  
        }
    }
    
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
        let balanceRounded = balance.myRounded()
        if balanceRounded >  0 {
            checkoutVC?.balancetxtf.text = String(format: "%.2f", balanceRounded)
            checkoutVC?.balancetxtf.textColor = UIColor.red
            checkoutVC?.balacelbl.text = "Balance"
           // checkoutVC?.cashBackLbl.text = "0"
        }
        else {
            checkoutVC?.balacelbl.text = "Return"
            checkoutVC?.balancetxtf.text = String(format: "%.2f", abs(balanceRounded))
            checkoutVC?.balancetxtf.textColor = UIColor.DefaultApp
           // checkoutVC?.cashBackLbl.text =  ("\(abs(balanceRounded))")
        }
//        if balance >  0 {
//            checkoutVC?.balancetxtf.text = ("\(balance)")
//
//
//        }
//        else {
//            checkoutVC?.balancetxtf.text = "0.0"
//           // checkoutVC?.balancetxtf.text = ("\(abs(balance))")
//
//        }
    }
    
    var totalPrice: Double = 0.0 {
        didSet {
            self.totalPrice = totalPrice.myRounded()
            checkoutVC?.checkoutoutlet.setTitle(String(format: "%.2f SAR", totalPrice), for: .normal)
            checkoutVC?.grandtotalLbl.text = String(format: "%.2f", abs(totalPrice))
            checkoutVC?.balancetxtf.text = String(format: "%.2f", abs(totalPrice)) // as in start balance is same as total
        }
    }

    var originalAmount = 0.0 {
        didSet {
            self.originalAmount = originalAmount.myRounded()
        }
    }
//
    private func fetchDiscount() -> Discount? {
        do{
            let fReq: NSFetchRequest = Discount.fetchRequest()
            fReq.fetchLimit = 1
            let results = try DataController.context.fetch(fReq)
            print(results)
            return results.first
        }
        catch {
            print("error in retrieving")
        }
        return nil
    }

    private func resetlblBalance() {
        if let tendered = checkoutVC?.tenderedbalance.text, let doubleTendered = Double(tendered) {
            amountTendered = doubleTendered
        }
    }

//
    func calculateAndUpdateUI() {
        let discount = fetchDiscount()

        if let discount = discount {
            if let discountType = DiscountTypeString(rawValue: discount.typeOfDiscount) {

                switch discountType {

                case DiscountTypeString.Amount:
                    discountAmount = discount.value
                     print(discountAmount)

                case DiscountTypeString.Percentage:
                    let discountper = discount.value
                    let total = Constants.subtotal * (discountper / 100)
                    discountAmount = total
                    print(discountAmount)
                case DiscountTypeString.Trend:
                    print("Trend")
                }
            }
        }
        else {
            discountAmount = 0
//            if let originalTotal = checkoutVC?.subTotalLbl.text , let originalTotalDouble = Double(originalTotal) {
//                totalPrice = originalTotalDouble
//            }
        }
        resetlblBalance()
    }

    deinit {
        print("CheckoutViewModel deinit called")
    }
}

