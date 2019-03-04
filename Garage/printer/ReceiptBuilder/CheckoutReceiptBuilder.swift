////
////  CheckoutReceiptBuilder.swift
////  Garage
////
////  Created by Amjad on 13/06/1440 AH.
////  Copyright © 1440 Amjad Ali. All rights reserved.
////
//
//import Foundation
//class CheckoutReceiptBuilder: ReceiptBuilder {
//
//    private var orderDetails: OrderDetailStruct!
//    private var cartItems: [CartItemStruct]!
//
//    private var receiptConfigurationModel: ReceiptConfigurationModel!
////    private var companyInfo: CompanyInfo!
//
//    private var receiptSize: CGSize = CGSize(width: 0.0, height: 100.0)
//    private let paddingFromLeft: Double = Double(ConstantValues._4inchScale * 0.08)
//
//    // Fonts' height with respect to thir attributes
//    private var sfProDisplay_semiBoldFontAttributes_90_height: Double!
//    private var sfProDisplay_mediumFontAttributes_27_height: Double!
//    private var sfProDisplay_boldFontAttributes_27_height: Double!
//    private var sfProDisplay_heavyFontAttributes_37_height: Double!
//    private var sfProDisplay_semiBoldFontAttributes_30_height: Double!
//    private var sfProDisplay_heavyFontAttributes_30_height: Double!
//    private var sfProDisplay_mediumFontAttributes_30_height : Double!
//    private var sfProDisplay_mediumFontAttributes_32_height : Double!
//
//    private var geezaPro_boldFontAttributes_27_height: Double!
//    private var geezaPro_boldFontAttributes_30_height: Double!
//
//    // MARK:- Constructor
//
//    required init(orderDetails: OrderDetailStruct, cartItems: [CartItemStruct], receiptConfigurationModel: ReceiptConfigurationModel, companyInfo: CompanyInfo) {
//        super.init()
//        self.orderDetails = orderDetails
//        self.cartItems = cartItems
//        self.receiptConfigurationModel = receiptConfigurationModel
//        self.companyInfo = companyInfo
//
//        sfProDisplay_semiBoldFontAttributes_90_height = Double("Test".size(withAttributes: sfProDisplay_semiBoldFontAttributes_90).height)
//        sfProDisplay_mediumFontAttributes_27_height = Double("Test".size(withAttributes: sfProDisplay_mediumFontAttributes_27).height)
//        sfProDisplay_boldFontAttributes_27_height = Double("Test".size(withAttributes: sfProDisplay_boldFontAttributes_27).height)
//        sfProDisplay_heavyFontAttributes_37_height = Double("Test".size(withAttributes: sfProDisplay_heavyFontAttributes_37).height)
//        sfProDisplay_semiBoldFontAttributes_30_height = Double("Test".size(withAttributes: sfProDisplay_semiBoldFontAttributes_30).height)
//        sfProDisplay_heavyFontAttributes_30_height = Double("Test".size(withAttributes: sfProDisplay_heavyFontAttributes_30).height)
//        sfProDisplay_mediumFontAttributes_30_height = Double("Test".size(withAttributes: sfProDisplay_mediumFontAttributes_30).height)
//        sfProDisplay_mediumFontAttributes_32_height = Double("Test".size(withAttributes: sfProDisplay_mediumFontAttributes_32).height)
//
//        geezaPro_boldFontAttributes_27_height = Double("تجربة".size(withAttributes: geezaPro_boldFontAttributes_27).height)
//        geezaPro_boldFontAttributes_30_height = Double("تجربة".size(withAttributes: geezaPro_boldFontAttributes_30).height)
//
//    }
//
//
//    // MARK:- Private Methods
//
//    /// Draws small separator
//    /// - Parameters:
//    ///     - yCoordinate: Double
//    /// - Returns: Void
//    private func drawLinks(at yCoordinate: Double) {
//        let attachment = NSTextAttachment()
//        var xCoordinate = paddingFromLeft*1.6
//        let padding = paddingFromLeft*1.6
//
//        /// snapchat link and logo
//        if  !companyInfo.snapchatLink.isEmpty {
//            attachment.image = UIImage(named: "x.png")!
//            var attributedString = NSAttributedString(attachment: attachment) as! NSMutableAttributedString
//            drawInRectWithString(mutableString: attributedString, frame: CGRect(x: xCoordinate, y: yCoordinate, width: Double((attachment.image?.size.width)!), height: Double((attachment.image?.size.height)!)))
//            xCoordinate = xCoordinate + Double((attachment.image?.size.width)!)
//
//            attributedString = NSMutableAttributedString(string: companyInfo.snapchatLink, attributes: sfProDisplay_mediumFontAttributes_30)
//            drawInRectWithString(mutableString: attributedString, frame: CGRect(x: xCoordinate + 10, y: yCoordinate - 8 , width: Double(attributedString.size().width), height: sfProDisplay_mediumFontAttributes_30_height))
//        }
//
//        /// instagram link and logo
//
//        if !companyInfo.instagranLink.isEmpty {
//            var attributedString = NSMutableAttributedString(string: companyInfo.instagranLink, attributes: sfProDisplay_mediumFontAttributes_30)
//
//            let attributedStringWidth: Double = Double(attributedString.string.size(withAttributes: sfProDisplay_mediumFontAttributes_30).width)
//
//            xCoordinate = Double(receiptSize.width) - padding - attributedStringWidth
//
//            drawInRectWithString(mutableString: attributedString, frame: CGRect(x: xCoordinate, y: yCoordinate - 8, width: Double(attributedString.size().width), height: sfProDisplay_mediumFontAttributes_30_height))
//
//            attachment.image = UIImage(named: "instagramLogo.png")!
//            attributedString = NSAttributedString(attachment: attachment) as! NSMutableAttributedString
//
//            xCoordinate = xCoordinate - Double((attachment.image?.size.width)!) - 10
//            drawInRectWithString(mutableString: attributedString, frame: CGRect(x: xCoordinate, y: yCoordinate, width: Double((attachment.image?.size.width)!), height: Double((attachment.image?.size.height)!)))
//        }
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
//        if receiptConfigurationModel.showTable {
//            attributedString = NSMutableAttributedString(string: "\(orderDetails.table)", attributes: sfProDisplay_mediumFontAttributes_27)
//            drawInRectWithString(mutableString: attributedString, frame: CGRect(x: paddingFromLeft, y: yCoordinate + 40, width: Double(paperSize.width), height: sfProDisplay_mediumFontAttributes_27_height))
//        }
//
//        if let orderTaker = orderDetails.orderTaker {
//            attributedString = NSMutableAttributedString(string: "\(orderTaker)", attributes: sfProDisplay_mediumFontAttributes_27)
//            drawInRectWithString(mutableString: attributedString, frame: CGRect(x: Double(paperSize.width*0.54), y: yCoordinate + 40, width: Double(paperSize.width), height: sfProDisplay_boldFontAttributes_27_height))
//        }
//    }
//}
//
//
//extension CheckoutReceiptBuilder: CheckoutReceiptPrintable {
//
//    func getHeaderForCheckout() -> UIImage {
//        var yCoordinate: Double = 0
//
//        var paperSize = CGSize(width: self.receiptSize.width, height: 0)
//        let logo = NSTextAttachment()
//        var name = ""
//        var phoneNumber = ""
//
//        if receiptConfigurationModel.showLogo {
//            logo.image = companyInfo.logo
//            paperSize.height = paperSize.height + (logo.image?.size.height)!
//        }
//
//        if receiptConfigurationModel.showCompanyName {
//            name = companyInfo.name
//            paperSize.height = paperSize.height + CGFloat(sfProDisplay_mediumFontAttributes_32_height) + 20
//        }
//
//        if receiptConfigurationModel.showCompanyName {
//            name = companyInfo.name
//            paperSize.height = paperSize.height + CGFloat(sfProDisplay_mediumFontAttributes_30_height) + 20
//        }
//
//        if receiptConfigurationModel.showPhone {
//            phoneNumber = companyInfo.phoneNumber
//            paperSize.height = paperSize.height + CGFloat(sfProDisplay_mediumFontAttributes_30_height) + 30
//        }
//
//        paperSize.height = paperSize.height + 60
//
//        let tempImage = UIImage()
//        UIGraphicsBeginImageContext(paperSize)
//        let context = UIGraphicsGetCurrentContext()
//        context?.setFillColor(UIColor.white.cgColor)
//        let tempRect = CGRect(x: 0, y: 0, width: paperSize.width, height: paperSize.height)
//        tempImage.draw(in: tempRect)
//        context?.fill(tempRect)
//
//        if receiptConfigurationModel.showLogo {
//            let attributedString = NSAttributedString(attachment: logo) as! NSMutableAttributedString
//            drawInRectWithString(mutableString: attributedString, frame: CGRect(x: Double((receiptSize.width-(logo.image?.size.width)!)/2), y: yCoordinate, width: Double((logo.image?.size.width)!), height: Double((logo.image?.size.height)!)))
//            yCoordinate = yCoordinate + Double((logo.image?.size.height)!) + 10
//        }
//
//        if name != "" {
//            yCoordinate = yCoordinate + 30
//            let attributedString = NSMutableAttributedString(string: name, attributes: sfProDisplay_mediumFontAttributes_32)
//            drawInRectWithString(mutableString: attributedString, frame: CGRect(x: Double((receiptSize.width-attributedString.size().width)/2), y: yCoordinate, width: Double(attributedString.size().width), height: sfProDisplay_mediumFontAttributes_32_height))
//            yCoordinate = yCoordinate + sfProDisplay_mediumFontAttributes_32_height + 30
//        }
//
//        if phoneNumber != "" {
//            let attributedString = NSMutableAttributedString(string: "Phone No: \(phoneNumber)", attributes: sfProDisplay_mediumFontAttributes_30)
//            drawInRectWithString(mutableString: attributedString, frame: CGRect(x: Double((receiptSize.width-attributedString.size().width)/2), y: yCoordinate, width: Double(attributedString.size().width), height: sfProDisplay_mediumFontAttributes_30_height))
//            yCoordinate = yCoordinate + sfProDisplay_mediumFontAttributes_30_height + 30
//        }
//
//        let attributedString = NSMutableAttributedString(string: "VAT # \(companyInfo.valueAddedTaxNumber)", attributes: sfProDisplay_mediumFontAttributes_32)
//        drawInRectWithString(mutableString: attributedString, frame: CGRect(x: Double((receiptSize.width-attributedString.size().width)/2), y: yCoordinate, width: Double(attributedString.size().width), height: sfProDisplay_mediumFontAttributes_32_height))
//
//
//        let newImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return newImage!
//    }
//
//    func getItemDetailsWithAmount() -> UIImage {
//
//        var modifiersCount = 0
//        for cartItem in cartItems {
//            modifiersCount = modifiersCount + cartItem.selectedModifiers.count
//        }
//
//        let paperSize = CGSize(width: receiptSize.width, height: CGFloat(cartItems.count * 160) + CGFloat(modifiersCount * 50) - 40)
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
//        for i in 0..<cartItems.count {
//            let cartItem = cartItems[i]
//            let nameOnReceipt = cartItem.item.alternateName ?? ""
//            var attributedString = NSMutableAttributedString(string: "\(String(format: "%g", cartItem.quantity)) x ", attributes: sfProDisplay_heavyFontAttributes_37)
//
//            let xCoordinate: Double = Double(attributedString.size().width)
//
//            attributedString.append(NSMutableAttributedString(string: "\(cartItem.item.name)", attributes: sfProDisplay_semiBoldFontAttributes_30))
//            drawInRectWithString(mutableString: attributedString, frame: CGRect(x: paddingFromLeft, y: yCoordinate, width: Double(paperSize.width), height: sfProDisplay_heavyFontAttributes_37_height))
//
//            attributedString = NSMutableAttributedString(string: "\(cartItem.item.price.myRounded(toPlaces: 2)) SR", attributes: sfProDisplay_boldFontAttributes_27)
//            let attributedStringWidth = attributedString.string.size(withAttributes: sfProDisplay_boldFontAttributes_27).width
//            drawInRectWithString(mutableString: attributedString, frame: CGRect(x: Double(paperSize.width) - paddingFromLeft - Double(attributedStringWidth), y: yCoordinate, width: Double(paperSize.width), height: sfProDisplay_boldFontAttributes_27_height))
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
//            /// Modifiers
//
//            for modifier in cartItem.selectedModifiers {
//                let attributedStringName = NSMutableAttributedString(string: "- \(modifier.name)", attributes: sfProDisplay_boldFontAttributes_27)
//                let attributedStringAlternateName = NSMutableAttributedString(string: "\(modifier.alternateName)", attributes: geezaPro_boldFontAttributes_27)
//
//                attributedString = NSMutableAttributedString(string: "+\(modifier.price.myRounded(toPlaces: 2)) SR", attributes: sfProDisplay_mediumFontAttributes_27)
//                let attributedStringWidth = attributedString.string.size(withAttributes: sfProDisplay_mediumFontAttributes_27).width
//                drawInRectWithString(mutableString: attributedString, frame: CGRect(x: Double(paperSize.width) - paddingFromLeft - Double(attributedStringWidth), y: yCoordinate, width: Double(paperSize.width), height: sfProDisplay_mediumFontAttributes_27_height))
//
//                attributedString = attributedStringName
//                if (attributedStringName.length + attributedStringAlternateName.length) <= 22 {
//                    attributedString.append(NSMutableAttributedString(string: " ", attributes: sfProDisplay_boldFontAttributes_27))
//                    attributedString.append(attributedStringAlternateName)
//                    drawInRectWithString(mutableString: attributedString, frame: CGRect(x: paddingFromLeft + xCoordinate, y: yCoordinate, width: Double(attributedString.size().width), height: Double(attributedString.size().height)))
//                    yCoordinate = yCoordinate + geezaPro_boldFontAttributes_27_height + 10
//                } else {
//                    attributedString.append(NSMutableAttributedString(string: "\n  ", attributes: sfProDisplay_boldFontAttributes_27))
//                    attributedString.append(attributedStringAlternateName)
//                    drawInRectWithString(mutableString: attributedStringName, frame: CGRect(x: paddingFromLeft + xCoordinate, y: yCoordinate, width: Double(attributedString.size().width), height: Double(attributedString.size().height)))
//                    yCoordinate = yCoordinate + sfProDisplay_boldFontAttributes_27_height + 60
//                }
//            }
//
//            if i != (cartItems.count - 1) {
//                yCoordinate = yCoordinate + 20
//                drawSmallSeparator(at: yCoordinate)
//                yCoordinate = yCoordinate + 40
//            }
//        }
//
//        let newImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return newImage!
//    }
//
//    func getSubTotal() -> UIImage {
//        let discountPercent = String(format: "%g", (orderDetails.paymentDetails?.discountPercent)!)
//        let englishTitles = ["Sub Total", "Discount", "VAT (\(discountPercent)%)"]
//        let arabicTitles = ["المجموع", "الخصم", "ضريبة القيمة المضافة"]
//        let amounts = [orderDetails.paymentDetails?.subTotal, orderDetails.paymentDetails?.discountValue, orderDetails.paymentDetails?.valueAddedTax]
//
//        let paperSize = CGSize(width: receiptSize.width, height: CGFloat(3 * 140) - 40)
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
//        drawSmallSeparator(at: yCoordinate)
//
//        yCoordinate = yCoordinate + 50
//
//        for i in 0..<englishTitles.count {
//            let englishTitle = englishTitles[i]
//            let arabicTitle = arabicTitles[i]
//            var attributedString = NSMutableAttributedString(string: "\(englishTitle)", attributes: sfProDisplay_semiBoldFontAttributes_30)
//
//            drawInRectWithString(mutableString: attributedString, frame: CGRect(x: paddingFromLeft, y: yCoordinate, width: Double(paperSize.width), height: sfProDisplay_semiBoldFontAttributes_30_height))
//
//            let amount = String(format: "%.2f", (amounts[i])!)
//            attributedString = NSMutableAttributedString(string: "\(amount) SR", attributes: sfProDisplay_boldFontAttributes_27)
//
//            let attributedStringWidth = attributedString.string.size(withAttributes: sfProDisplay_boldFontAttributes_27).width
//            drawInRectWithString(mutableString: attributedString, frame: CGRect(x: Double(paperSize.width) - paddingFromLeft - Double(attributedStringWidth), y: yCoordinate, width: Double(paperSize.width), height: sfProDisplay_boldFontAttributes_27_height))
//
//            attributedString = NSMutableAttributedString(string: "\n\(arabicTitle)", attributes: geezaPro_boldFontAttributes_30)
//            drawInRectWithString(mutableString: attributedString, frame: CGRect(x: paddingFromLeft, y: yCoordinate, width: Double(attributedString.size().width), height: Double(attributedString.size().height)))
//            yCoordinate = yCoordinate + geezaPro_boldFontAttributes_30_height + 40
//
//            yCoordinate = yCoordinate + 40
//        }
//
//        let newImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return newImage!
//    }
//
//    func getGrandTotal() -> UIImage {
//
//        let paymentVia = orderDetails.paymentDetails?.paymentVia ?? ""
//
//        var paperSize = CGSize(width: receiptSize.width, height: 180)
//
//        if paymentVia != "" {
//            paperSize.height = paperSize.height + 30
//        }
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
//        drawSmallSeparator(at: yCoordinate)
//
//        yCoordinate = yCoordinate + 30
//
//        /// Grand Total
//        let grandTotal = String(format: "%.2f", (orderDetails.paymentDetails?.grandTotal)!)
//        var attributedString = NSMutableAttributedString(string: "Grand Total", attributes: sfProDisplay_heavyFontAttributes_37)
//        drawInRectWithString(mutableString: attributedString, frame: CGRect(x: paddingFromLeft, y: yCoordinate, width: Double(paperSize.width), height: sfProDisplay_heavyFontAttributes_37_height))
//
//        attributedString = NSMutableAttributedString(string: "\(grandTotal) SR", attributes: sfProDisplay_heavyFontAttributes_30)
//        let attributedStringWidth = attributedString.string.size(withAttributes: sfProDisplay_heavyFontAttributes_30).width
//        drawInRectWithString(mutableString: attributedString, frame: CGRect(x: Double(paperSize.width) - paddingFromLeft - Double(attributedStringWidth), y: yCoordinate, width: Double(paperSize.width), height: sfProDisplay_heavyFontAttributes_30_height))
//
//        yCoordinate = yCoordinate + sfProDisplay_heavyFontAttributes_30_height + 30
//
//        attributedString = NSMutableAttributedString(string: "الإجمالي", attributes: geezaPro_boldFontAttributes_30)
//        drawInRectWithString(mutableString: attributedString, frame: CGRect(x: paddingFromLeft, y: yCoordinate, width: Double(paperSize.width), height: geezaPro_boldFontAttributes_30_height))
//
//        yCoordinate = yCoordinate + geezaPro_boldFontAttributes_30_height + 30
//
//        /// Payment details
//
//        if paymentVia != "" {
//            attributedString = NSMutableAttributedString(string: "Payment - \(paymentVia)", attributes: sfProDisplay_mediumFontAttributes_30)
//            drawInRectWithString(mutableString: attributedString, frame: CGRect(x: paddingFromLeft, y: yCoordinate, width: Double(attributedString.size().width), height: sfProDisplay_mediumFontAttributes_30_height))
//
//            attributedString = NSMutableAttributedString(string: "\(grandTotal) SR", attributes: sfProDisplay_mediumFontAttributes_30)
//            drawInRectWithString(mutableString: attributedString, frame: CGRect(x: Double(paperSize.width) - paddingFromLeft - Double(attributedStringWidth), y: yCoordinate, width: Double(attributedString.size().width), height: sfProDisplay_mediumFontAttributes_30_height))
//        }
//
//        let newImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return newImage!
//    }
//
//    func getCheckoutFooter() -> UIImage {
//
//        let paperSize = CGSize(width: receiptSize.width, height: 140.0)
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
//        // Start: Small Separator
//        drawSmallSeparator(at: yCoordinate)
//        // End: Small Separator
//
//        yCoordinate = yCoordinate + 20
//
//        let attributedString = NSMutableAttributedString(string: "Thank you for visiting", attributes: sfProDisplay_mediumFontAttributes_27)
//        let attributedStringSize = attributedString.string.size(withAttributes: sfProDisplay_mediumFontAttributes_27)
//        drawInRectWithString(mutableString: attributedString, frame: CGRect(x: Double(paperSize.width - attributedStringSize.width)/2, y: yCoordinate, width: Double(self.receiptSize.width), height: sfProDisplay_mediumFontAttributes_27_height))
//
//        yCoordinate = yCoordinate + 50
//
//        drawLinks(at: yCoordinate)
//
//        let newImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return newImage!
//    }
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
//        let attributedString = NSMutableAttributedString(string: "\(orderDetails.orderNumber)", attributes: sfProDisplay_semiBoldFontAttributes_90)
//        let attributedStringSize = attributedString.string.size(withAttributes: sfProDisplay_semiBoldFontAttributes_90)
//        drawInRectWithString(mutableString: attributedString, frame: CGRect(x: Double((paperSize.width-attributedStringSize.width)/2), y: yCoordinate, width: Double(attributedString.size().width), height: Double(sfProDisplay_semiBoldFontAttributes_90_height)))
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
//        drawDateAndTime(date: orderDetails.dateCreated, at: yCoordinate)
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
//    func createReceiptImage() -> UIImage {
//        var image = getHeaderForCheckout()
//
//        image = mergeImageTopToBottom(topImage: image, bottomImage: getTransactionDetails())
//
//        image = mergeImageTopToBottom(topImage: image, bottomImage: getWhiteImage(size: CGSize(width: receiptSize.width, height: 30)))
//        image = mergeImageTopToBottom(topImage: image, bottomImage: getSeparator())
//        image = mergeImageTopToBottom(topImage: image, bottomImage: getWhiteImage(size: CGSize(width: receiptSize.width, height: 30)))
//
//        image = mergeImageTopToBottom(topImage: image, bottomImage: getItemDetailsWithAmount())
//        image = mergeImageTopToBottom(topImage: image, bottomImage: getWhiteImage(size: CGSize(width: receiptSize.width, height: 15)))
//
//        image = mergeImageTopToBottom(topImage: image, bottomImage: getSubTotal())
//        image = mergeImageTopToBottom(topImage: image, bottomImage: getWhiteImage(size: CGSize(width: receiptSize.width, height: 15)))
//
//        image = mergeImageTopToBottom(topImage: image, bottomImage: getGrandTotal())
//
//        image = mergeImageTopToBottom(topImage: image, bottomImage: getCheckoutFooter())
//
//        return image
//    }
//
//
//}
