//
//  ReceiptPrintable.swift
//  Garage
//
//  Created by Amjad on 13/06/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import Foundation
import UIKit

protocol ReceiptPrintable: class {
    func setWidthOfReceipt(width: CGFloat)
    func getTransactionDetails()-> UIImage
    func createReceiptImage()-> UIImage
}

protocol KitchenReceiptPrintable: ReceiptPrintable {
    func getItemDetails()-> UIImage
}

protocol CheckoutReceiptPrintable: ReceiptPrintable {
    func getHeaderForCheckout()-> UIImage
    func getItemDetailsWithAmount()-> UIImage
    func getSubTotal()-> UIImage
    func getGrandTotal()-> UIImage
    func getCheckoutFooter()-> UIImage
    
}

protocol PackagingReceiptPrintable: ReceiptPrintable {
    
}


