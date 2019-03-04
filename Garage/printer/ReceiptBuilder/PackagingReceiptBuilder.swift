////
////  PackagingReceiptBuilder.swift
////  Garage
////
////  Created by Amjad on 13/06/1440 AH.
////  Copyright © 1440 Amjad Ali. All rights reserved.
////
//
//import Foundation
//class PackagingReceiptBuilder: ReceiptBuilder {
//
//    private var orderToPrint: checkoutItems!
//    private var receiptSize: CGSize = CGSize(width: 0.0, height: 100.0)
//    private let paddingFromLeft: Double = Double(Constants._4inchScale * 0.08)
//
//    // Fonts' height with respect to thir attributes
//    private var sfProDisplay_semiBoldFontAttributes_90_height: Double!
//    private var sfProDisplay_mediumFontAttributes_27_height: Double!
//
//
//    // create our NSTextAttachment
//    var smallSeparator = NSTextAttachment()
//
//
//    // MARK:- Constructor
//
//    required init(orderToPrint: Orderdetail) {
//        super.init()
//        self.orderToPrint = orderToPrint
//
//        sfProDisplay_semiBoldFontAttributes_90_height = Double("Test".size(withAttributes: sfProDisplay_semiBoldFontAttributes_90).height)
//        sfProDisplay_mediumFontAttributes_27_height = Double("Test".size(withAttributes: sfProDisplay_mediumFontAttributes_27).height)
//
//    }
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
//    private func drawDateAndTime(date: NSDate, at yCoordinate: Double) {
//        let receiptWidth = self.receiptSize.width
//        let dateString = FormatHelper.getFormattedDate(date: date, dateFormat: DateFormat.shortDate)
//        let timeString = FormatHelper.getFormattedTime(date: date, timeFormat: TimeFormat.hour12)
//        let timeStringSize: CGSize = timeString.size(withAttributes: sfProDisplay_mediumFontAttributes_27)
//        var attributedString = NSMutableAttributedString(string: "\(dateString)", attributes: sfProDisplay_mediumFontAttributes_27)
//        drawInRectWithString(mutableString: attributedString, frame: CGRect(x: paddingFromLeft, y: yCoordinate, width: Double(receiptWidth), height: sfProDisplay_mediumFontAttributes_27_height))
//        attributedString = NSMutableAttributedString(string: "\(timeString)", attributes: sfProDisplay_mediumFontAttributes_27)
//        drawInRectWithString(mutableString: attributedString, frame: CGRect(x: Double((receiptWidth*0.92)-timeStringSize.width), y: yCoordinate, width: Double(receiptWidth), height: sfProDisplay_mediumFontAttributes_27_height))
//    }
//}
//
//extension PackagingReceiptBuilder: PackagingReceiptPrintable {
//
//    func setWidthOfReceipt(width: CGFloat) {
//        receiptSize.width = width
//    }
//
//    func getTransactionDetails() -> UIImage {
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
//        var attributedString = NSMutableAttributedString(string: "\(orderToPrint.orderNumber)", attributes: sfProDisplay_semiBoldFontAttributes_90)
//        var attributedStringSize = attributedString.string.size(withAttributes: sfProDisplay_semiBoldFontAttributes_90)
//        drawInRectWithString(mutableString: attributedString, frame: CGRect(x: Double((paperSize.width-attributedStringSize.width)/2), y: yCoordinate, width: Double(paperSize.width), height: Double(sfProDisplay_semiBoldFontAttributes_90_height)))
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
//        drawDateAndTime(date: orderToPrint.dateCreated, at: yCoordinate)
//        // End: Data and time (i.e 11/12/18        09:00 PM)
//
//        yCoordinate = yCoordinate + 40
//
//        // Start: Small Separator
//        drawSmallSeparator(at: yCoordinate)
//        // End: Small Separator
//
//        yCoordinate = yCoordinate + 50
//
//        attributedString = NSMutableAttributedString(string: "Thank you for visiting", attributes: sfProDisplay_mediumFontAttributes_27)
//        attributedStringSize = attributedString.string.size(withAttributes: sfProDisplay_mediumFontAttributes_27)
//        drawInRectWithString(mutableString: attributedString, frame: CGRect(x: Double(paperSize.width - attributedStringSize.width)/2, y: yCoordinate, width: Double(self.receiptSize.width), height: sfProDisplay_mediumFontAttributes_27_height))
//
//        let newImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return newImage!
//    }
//
//    func createReceiptImage() -> UIImage {
//        return getTransactionDetails()
//    }
//
//
//}
