////
////  KitchenReceiptBuilder.swift
////  Garage
////
////  Created by Amjad on 13/06/1440 AH.
////  Copyright © 1440 Amjad Ali. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//class KitchenReceiptBuilder: ReceiptBuilder {
//
//    private var orderDetails: Orderdetail!
//    private var cartItems: [checkoutItems]!
//    private var receiptConfigurationModel: ReceiptConfigurationModel?
//    private var receiptSize: CGSize = CGSize(width: 0.0, height: 100.0)
//    private let paddingFromLeft: Double = Double(ConstantValues._4inchScale * 0.08)
//
//    // Fonts' height with respect to thir attributes
//    private var sfProDisplay_semiBoldFontAttributes_90_height: Double!
//    private var sfProDisplay_mediumFontAttributes_27_height: Double!
//    private var sfProDisplay_boldFontAttributes_27_height: Double!
//    private var sfProDisplay_heavyFontAttributes_37_height: Double!
//    private var sfProDisplay_semiBoldFontAttributes_30_height: Double!
//
//    private var geezaPro_boldFontAttributes_27_height: Double!
//    private var geezaPro_boldFontAttributes_30_height: Double!
//
//
//    // MARK:- Constructor
//
//    required init(orderDetails: Orderdetail, cartItems: [checkoutItems], receiptConfigurationModel: ReceiptConfigurationModel? = nil) {
//        super.init()
//        self.orderDetails = orderDetails
//        self.cartItems = cartItems
//        self.receiptConfigurationModel = receiptConfigurationModel
//
////        sfProDisplay_semiBoldFontAttributes_90_height = Double("Test".size(withAttributes: sfProDisplay_semiBoldFontAttributes_90).height)
////        sfProDisplay_mediumFontAttributes_27_height = Double("Test".size(withAttributes: sfProDisplay_mediumFontAttributes_27).height)
////        sfProDisplay_boldFontAttributes_27_height = Double("Test".size(withAttributes: sfProDisplay_boldFontAttributes_27).height)
////        sfProDisplay_heavyFontAttributes_37_height = Double("Test".size(withAttributes: sfProDisplay_heavyFontAttributes_37).height)
////        sfProDisplay_semiBoldFontAttributes_30_height = Double("Test".size(withAttributes: sfProDisplay_semiBoldFontAttributes_30).height)
////
////        geezaPro_boldFontAttributes_27_height = Double("تجربة".size(withAttributes: geezaPro_boldFontAttributes_27).height)
////        geezaPro_boldFontAttributes_30_height = Double("تجربة".size(withAttributes: geezaPro_boldFontAttributes_30).height)
//    }
//
//    // MARK:- Private Methods
//
//    /// Draws small separator
//    /// - Parameters:
//    ///     - yCoordinate: Double
//    /// - Returns: Void
//    private func drawSmallSeparator(at yCoordinate: Double) {
//        let smallSeparator = NSTextAttachment()
//        smallSeparator.image = getSeparatorSmall()
//        let attributedString1 = NSAttributedString(attachment: smallSeparator) as! NSMutableAttributedString
//        drawInRectWithString(mutableString: attributedString1, frame: CGRect(x: Double((receiptSize.width-(smallSeparator.image?.size.width)!)/2), y: yCoordinate, width: Double(receiptSize.width), height: 10.0))
//    }
//
//    /// Draws date and time
//    /// - Parameters:
//    ///     - date: NSDate
//    ///     - yCoordinate: Double
//    /// - Returns: Void
////    private func drawDateAndTime(date: NSDate, at yCoordinate: Double) {
////        let receiptWidth = self.receiptSize.width
////        let dateString = FormatHelper.getFormattedDate(date: date, dateFormat: DateFormat.shortDate)
////        let timeString = FormatHelper.getFormattedTime(date: date, timeFormat: TimeFormat.hour12)
////        let timeStringSize: CGSize = timeString.size(withAttributes: sfProDisplay_mediumFontAttributes_27)
////        var attributedString = NSMutableAttributedString(string: "\(dateString)", attributes: sfProDisplay_mediumFontAttributes_27)
////        drawInRectWithString(mutableString: attributedString, frame: CGRect(x: paddingFromLeft, y: yCoordinate, width: Double(receiptWidth), height: sfProDisplay_mediumFontAttributes_27_height))
////        attributedString = NSMutableAttributedString(string: "\(timeString)", attributes: sfProDisplay_mediumFontAttributes_27)
////        drawInRectWithString(mutableString: attributedString, frame: CGRect(x: Double((receiptWidth*0.92)-timeStringSize.width), y: yCoordinate, width: Double(receiptWidth), height: sfProDisplay_mediumFontAttributes_27_height))
////    }
//
//    /// Draws order details i.e. transaction number, order number, order type etc
//    /// - Parameters:
//    ///     - yCoordinate: Double
//    /// - Returns: Void
//    private func drawOrderDetails(at yCoordinate: Double) {
//        let paperSize = self.receiptSize
//        var attributedString = NSMutableAttributedString(string: "\(orderDetails.orderNumber)", attributes: sfProDisplay_mediumFontAttributes_27)
//        drawInRectWithString(mutableString: attributedString, frame: CGRect(x: paddingFromLeft, y: yCoordinate, width: Double(paperSize.width), height: Double(sfProDisplay_mediumFontAttributes_27_height)))
//
//        attributedString = NSMutableAttributedString(string: "\(orderDetails.orderType)", attributes: sfProDisplay_boldFontAttributes_27)
//        drawInRectWithString(mutableString: attributedString, frame: CGRect(x: Double(paperSize.width*0.54), y: yCoordinate, width: Double(paperSize.width), height: sfProDisplay_boldFontAttributes_27_height))
//
//        attributedString = NSMutableAttributedString(string: "\(orderDetails.table)", attributes: sfProDisplay_mediumFontAttributes_27)
//        drawInRectWithString(mutableString: attributedString, frame: CGRect(x: paddingFromLeft, y: yCoordinate + 40, width: Double(paperSize.width), height: sfProDisplay_mediumFontAttributes_27_height))
//
//        //        if let orderTaker = orderToPrint.orderTaker {
//        //            attributedString = NSMutableAttributedString(string: "\(orderTaker)", attributes: sfProDisplay_mediumFontAttributes_27)
//        //            drawInRectWithString(mutableString: attributedString, frame: CGRect(x: Double(paperSize.width*0.54), y: yCoordinate + 40, width: Double(paperSize.width), height: sfProDisplay_boldFontAttributes_27_height))
//        //        }
//    }
//
//}
//
//extension KitchenReceiptBuilder: KitchenReceiptPrintable {
//
//    func setWidthOfReceipt(width: CGFloat) {
//        receiptSize.width = width
//    }
//
//    func getItemDetails() -> UIImage {
//
////        var modifiersCount = 0
////        for cartItem in cartItems {
////            modifiersCount = modifiersCount + cartItem.selectedModifiers.count
////        }
//
//       // let paperSize = CGSize(width: receiptSize.width, height: CGFloat(cartItems.count * 160) + CGFloat(modifiersCount * 40) - 40)
//
//        var yCoordinate: Double = 0
//
////        let tempImage = UIImage()
////        UIGraphicsBeginImageContext(paperSize)
////        let context = UIGraphicsGetCurrentContext()
////        context?.setFillColor(UIColor.white.cgColor)
////        let tempRect = CGRect(x: 0, y: 0, width: paperSize.width, height: paperSize.height)
////        tempImage.draw(in: tempRect)
////        context?.fill(tempRect)
//
//        for i in 0..<cartItems.count {
//            let cartItem = cartItems[i]
//            let nameOnReceipt = cartItem.Name ?? ""
//            var attributedString = NSMutableAttributedString(string: "\(String(format: "%g", cartItem.Quantity)) x ", attributes: SFProDisplay_heavyFontAttributes_37)
//
//            let xCoordinate: Double = Double(attributedString.size().width)
//
//            attributedString.append(NSMutableAttributedString(string: "\(cartItem.item.name)", attributes: sfProDisplay_semiBoldFontAttributes_30))
//            drawInRectWithString(mutableString: attributedString, frame: CGRect(x: paddingFromLeft, y: yCoordinate, width: Double(paperSize.width), height: sfProDisplay_heavyFontAttributes_37_height))
//
//            yCoordinate = yCoordinate + 20
//
//            if nameOnReceipt != "" {
//                attributedString = NSMutableAttributedString(string: "\n\(nameOnReceipt)", attributes: geezaPro_boldFontAttributes_30)
//                drawInRectWithString(mutableString: attributedString, frame: CGRect(x: paddingFromLeft+xCoordinate, y: yCoordinate, width: Double(attributedString.size().width), height: Double(attributedString.size().height)))
//                yCoordinate = yCoordinate + geezaPro_boldFontAttributes_30_height + 40
//            } else {
//                yCoordinate = yCoordinate + sfProDisplay_heavyFontAttributes_37_height
//            }
//
//            yCoordinate = yCoordinate + 10
//
//            /// Modifiers
//
////            for modifier in cartItem.selectedModifiers {
////
////                let attributedStringName = NSMutableAttributedString(string: "\(modifier.name)", attributes: sfProDisplay_boldFontAttributes_27)
////                let attributedStringAlternateName = NSMutableAttributedString(string: " \(modifier.alternateName)", attributes: geezaPro_boldFontAttributes_27)
////
////                if modifier.mode == OrderMode.delete {
////                    attributedStringName.addAttributes([
////                        NSAttributedStringKey.strikethroughStyle: NSUnderlineStyle.styleSingle.rawValue,
////                        NSAttributedStringKey.strikethroughColor: UIColor.black], range: NSMakeRange(0, attributedStringName.length))
////                    attributedStringAlternateName.addAttributes([
////                        NSAttributedStringKey.strikethroughStyle: NSUnderlineStyle.styleSingle.rawValue,
////                        NSAttributedStringKey.strikethroughColor: UIColor.black], range: NSMakeRange(0, attributedStringAlternateName.length))
////                }
////
////                attributedString = NSMutableAttributedString(string: "- ", attributes: sfProDisplay_boldFontAttributes_27)
////                attributedString.append(attributedStringName)
////
////                if (attributedStringName.length + attributedStringAlternateName.length) <= 30 {
////                    attributedString.append(NSMutableAttributedString(string: " ", attributes: sfProDisplay_boldFontAttributes_27))
////                    attributedString.append(attributedStringAlternateName)
////                    drawInRectWithString(mutableString: attributedString, frame: CGRect(x: paddingFromLeft + xCoordinate, y: yCoordinate, width: Double(attributedString.size().width), height: Double(attributedString.size().height)))
////                    yCoordinate = yCoordinate + geezaPro_boldFontAttributes_27_height
////                } else {
////                    attributedString.append(NSMutableAttributedString(string: "\n ", attributes: sfProDisplay_boldFontAttributes_27))
////                    attributedString.append(attributedStringAlternateName)
////                    drawInRectWithString(mutableString: attributedStringName, frame: CGRect(x: paddingFromLeft + xCoordinate, y: yCoordinate, width: Double(attributedString.size().width), height: Double(attributedString.size().height)))
////                    yCoordinate = yCoordinate + sfProDisplay_boldFontAttributes_27_height + 60
////                }
////            }
////
////            if i != (cartItems.count - 1) {
////                yCoordinate = yCoordinate + 20
////                drawSmallSeparator(at: yCoordinate)
////                yCoordinate = yCoordinate + 40
////            }
////        }
//
//        let newImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return newImage!
//    }
//
//    func createReceiptImage() -> UIImage {
//        var image = getTransactionDetails()
//
//        if let receiptConfigurationModel = receiptConfigurationModel {
//            if receiptConfigurationModel.showKitchenHangingSpace {
//                let whiteImage = getWhiteImage(size: CGSize(width: receiptSize.width, height: 160))
//                image = mergeImageTopToBottom(topImage: whiteImage, bottomImage: image)
//            }
//        }
//
//        image = mergeImageTopToBottom(topImage: image, bottomImage: getWhiteImage(size: CGSize(width: receiptSize.width, height: 30)))
//        image = mergeImageTopToBottom(topImage: image, bottomImage: getSeparator())
//        image = mergeImageTopToBottom(topImage: image, bottomImage: getWhiteImage(size: CGSize(width: receiptSize.width, height: 30)))
//
//        image = mergeImageTopToBottom(topImage: image, bottomImage: getItemDetails())
//        return image
//    }
//
//    func getTransactionDetails()-> UIImage {
//
//        let paperSize = CGSize(width: receiptSize.width, height: 300.0)
//
//        var yCoordinate: Double = 0
//
//        let tempImage = UIImage()
//        UIGraphicsBeginImageContext(paperSize)
//        let context = UIGraphicsGetCurrentContext()
//        context?.setFillColor(UIColor.white.cgColor)
//        let tempRect = CGRect(x: 0, y: 0, width: paperSize.width, height: paperSize.height)
//        tempImage.draw(in: tempRect)
//        context?.fill(tempRect)
//
//        // Start: Transation Number (on top)
//
////        let attributedString = NSMutableAttributedString(string: "\(orderDetails.orderNumber)", attributes: sfProDisplay_semiBoldFontAttributes_90)
////        let attributedStringSize = attributedString.string.size(withAttributes: sfProDisplay_semiBoldFontAttributes_90)
////        drawInRectWithString(mutableString: attributedString, frame: CGRect(x: Double((paperSize.width-attributedStringSize.width)/2), y: yCoordinate, width: Double(paperSize.width), height: Double(sfProDisplay_semiBoldFontAttributes_90_height)))
//        // End: Transation Number (on top)
//
//        yCoordinate = Double(sfProDisplay_semiBoldFontAttributes_90_height + 30)
//
//        // Start: Small Separator
//        drawSmallSeparator(at: yCoordinate)
//        // End: Small Separator
//
//        yCoordinate = yCoordinate + 10
//
//        // Start: Data and time (i.e 11/12/18        09:00 PM)
//       // drawDateAndTime(date: orderDetails.dateCreated, at: yCoordinate)
//        // End: Data and time (i.e 11/12/18        09:00 PM)
//
//        yCoordinate = yCoordinate + 40
//
//        // Start: Small Separator
//        drawSmallSeparator(at: yCoordinate)
//        // End: Small Separator
//
//        yCoordinate = yCoordinate + 30
//
//        // Start: Order Details i.e. order number, type etc
//        drawOrderDetails(at: yCoordinate)
//        // End: Order Details i.e. order number, type etc
//
//        yCoordinate = yCoordinate + 30
//
//        let newImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return newImage!
//    }
//
//}
