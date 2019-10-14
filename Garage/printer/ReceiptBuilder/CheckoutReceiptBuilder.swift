//
//  CheckoutReceiptBuilder.swift
//  Garage
//
//  Created by Amjad on 13/06/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import Foundation


class CheckoutReceiptBuilder: ReceiptBuilder {
    
    
    private var orderDetails: Orderdetail!
    private var cartItems: [ReceiptModel]!
    
    private var receiptConfigurationModel: ReceiptConfigurationModel!
    private var companyInfo: CompanyInfo!
    
    private var receiptSize: CGSize = CGSize(width: 0.0, height: 100.0)
    
    
    private let paddingFromLeft: Double = Double(Constants._4inchScale * 0.08) //0.08
   
    // Fonts' height with respect to thir attributes
    private var sfProDisplay_semiBoldFontAttributes_90_height: Double!
    private var sfProDisplay_mediumFontAttributes_27_height: Double!
    private var sfProDisplay_boldFontAttributes_27_height: Double!
    private var sfProDisplay_heavyFontAttributes_37_height: Double!
    private var sfProDisplay_semiBoldFontAttributes_30_height: Double!
    private var sfProDisplay_heavyFontAttributes_30_height: Double!
    private var sfProDisplay_mediumFontAttributes_30_height : Double!
    private var sfProDisplay_mediumFontAttributes_32_height : Double!
    
    private var geezaPro_boldFontAttributes_27_height: Double!
    private var geezaPro_boldFontAttributes_30_height: Double!
    
    
    required init(orderDetails: Orderdetail, cartItems: [ReceiptModel], receiptConfigurationModel: ReceiptConfigurationModel, companyInfo: CompanyInfo) {
        super.init()
        self.orderDetails = orderDetails
        self.cartItems = cartItems
        self.receiptConfigurationModel = receiptConfigurationModel
        self.companyInfo = companyInfo
        
        sfProDisplay_semiBoldFontAttributes_90_height = Double("Test".size(withAttributes: sfProDisplay_semiBoldFontAttributes_90).height)
        sfProDisplay_mediumFontAttributes_27_height = Double("Test".size(withAttributes: sfProDisplay_mediumFontAttributes_27).height)
        sfProDisplay_boldFontAttributes_27_height = Double("Test".size(withAttributes: sfProDisplay_boldFontAttributes_27).height)
        sfProDisplay_heavyFontAttributes_37_height = Double("Test".size(withAttributes: sfProDisplay_heavyFontAttributes_37).height)
        sfProDisplay_semiBoldFontAttributes_30_height = Double("Test".size(withAttributes: sfProDisplay_semiBoldFontAttributes_30).height)
        sfProDisplay_heavyFontAttributes_30_height = Double("Test".size(withAttributes: sfProDisplay_heavyFontAttributes_30).height)
        sfProDisplay_mediumFontAttributes_30_height = Double("Test".size(withAttributes: sfProDisplay_mediumFontAttributes_30).height)
        sfProDisplay_mediumFontAttributes_32_height = Double("Test".size(withAttributes: sfProDisplay_mediumFontAttributes_32).height)
        geezaPro_boldFontAttributes_27_height = Double("تجربة".size(withAttributes: geezaPro_boldFontAttributes_27).height)
        geezaPro_boldFontAttributes_30_height = Double("تجربة".size(withAttributes: geezaPro_boldFontAttributes_30).height)
        
    }
    
    
    // MARK:- Private Methods
    
    /// Draws small separator
    /// - Parameters:
    ///     - yCoordinate: Double
    /// - Returns: Void
    private func drawLinks(at yCoordinate: Double) {
        let attachment = NSTextAttachment()
        var xCoordinate = paddingFromLeft*1.6
        let padding = paddingFromLeft*1.6
        
        /// snapchat link and logo
        if  !companyInfo.snapchatLink.isEmpty {
            attachment.image = UIImage(named: "snapchatg.png")!
            var attributedString = NSAttributedString(attachment: attachment) as! NSMutableAttributedString
            drawInRectWithString(mutableString: attributedString, frame: CGRect(x: xCoordinate, y: yCoordinate, width: Double((attachment.image?.size.width)!), height: Double((attachment.image?.size.height)!)))
            xCoordinate = xCoordinate + Double((attachment.image?.size.width)!)
            
            attributedString = NSMutableAttributedString(string: companyInfo.snapchatLink, attributes: sfProDisplay_mediumFontAttributes_30)
            drawInRectWithString(mutableString: attributedString, frame: CGRect(x: xCoordinate + 10, y: yCoordinate - 8 , width: Double(attributedString.size().width), height: sfProDisplay_mediumFontAttributes_30_height))
        }
        
        /// instagram link and logo
        
        if !companyInfo.instagranLink.isEmpty {
            var attributedString = NSMutableAttributedString(string: companyInfo.instagranLink, attributes: sfProDisplay_mediumFontAttributes_30)
            
            let attributedStringWidth: Double = Double(attributedString.string.size(withAttributes: sfProDisplay_mediumFontAttributes_30).width)
            
            xCoordinate = Double(receiptSize.width) - padding - attributedStringWidth
            
            drawInRectWithString(mutableString: attributedString, frame: CGRect(x: xCoordinate, y: yCoordinate - 8, width: Double(attributedString.size().width), height: sfProDisplay_mediumFontAttributes_30_height))
            
            attachment.image = UIImage(named: "insta.png")!
            attributedString = NSAttributedString(attachment: attachment) as! NSMutableAttributedString
            
            xCoordinate = xCoordinate - Double((attachment.image?.size.width)!) - 10
            drawInRectWithString(mutableString: attributedString, frame: CGRect(x: xCoordinate, y: yCoordinate, width: Double((attachment.image?.size.width)!), height: Double((attachment.image?.size.height)!)))
        }
        
    }
    
    /// Draws small separator
    /// - Parameters:
    ///     - yCoordinate: Double
    /// - Returns: Void
    private func drawSmallSeparator(at yCoordinate: Double) {
        let smallSeparator = NSTextAttachment()
        smallSeparator.image = getSeparatorSmall()
        let attributedString1 = NSAttributedString(attachment: smallSeparator) as! NSMutableAttributedString
        drawInRectWithString(mutableString: attributedString1, frame: CGRect(x: Double((receiptSize.width-(smallSeparator.image?.size.width)!)/2), y: yCoordinate, width: Double(receiptSize.width), height: 5.0))
    }
    
    /// Draws date and time
    /// - Parameters:
    ///     - date: NSDate
    ///     - yCoordinate: Double
    /// - Returns: Void
    private func drawDateAndTime(date: NSDate, at yCoordinate: Double) {
        let receiptWidth = self.receiptSize.width
        let dateString = FormatHelper.getFormattedDate(date: date, dateFormat: DateFormat.shortDate)
        let timeString = FormatHelper.getFormattedTime(date: date, timeFormat: TimeFormat.hour12)
        let timeStringSize: CGSize = timeString.size(withAttributes: sfProDisplay_mediumFontAttributes_27)
        var attributedString = NSMutableAttributedString(string: "\(dateString)", attributes: sfProDisplay_mediumFontAttributes_27)
        drawInRectWithString(mutableString: attributedString, frame: CGRect(x: paddingFromLeft, y: yCoordinate, width: Double(attributedString.size().width), height: sfProDisplay_mediumFontAttributes_27_height))
        attributedString = NSMutableAttributedString(string: "\(timeString)", attributes: sfProDisplay_mediumFontAttributes_27)
        drawInRectWithString(mutableString: attributedString, frame: CGRect(x: Double((receiptWidth*0.92)-timeStringSize.width), y: yCoordinate, width: Double(attributedString.size().width), height: sfProDisplay_mediumFontAttributes_27_height))
    }
    
    /// Draws order details i.e. transaction number, order number, order type etc
    /// - Parameters:
    ///     - yCoordinate: DoubleConstants.checkoutcustm
    /// - Returns: Void
    private func drawOrderDetails(at yCoordinate: Double) {
        let paperSize = self.receiptSize
        print(paperSize)
        var attributedString = NSMutableAttributedString(string: "\(Constants.checkoutmechanic)", attributes: sfProDisplay_boldFontAttributes_27
            
            
        )
        //  drawInRectWithString(mutableString: attributedString, frame: CGRect(x: paddingFromLeft, y: yCoordinate, width: Double(paperSize.width), height: Double(sfProDisplay_mediumFontAttributes_27_height)))
        drawInRectWithString(mutableString: attributedString, frame: CGRect(x: paddingFromLeft, y: yCoordinate, width: Double(attributedString.size().width), height: sfProDisplay_heavyFontAttributes_37_height))
        
        attributedString = NSMutableAttributedString(string: "\(Constants.checkoutbayname)", attributes: sfProDisplay_mediumFontAttributes_27)
        //        drawInRectWithString(mutableString: attributedString, frame: CGRect(x: Double(paperSize.width*0.70), y: yCoordinate, width: Double(paperSize.width), height: sfProDisplay_boldFontAttributes_27_height))
        //
        //
        //        attributedString = NSMutableAttributedString(string: "\(cartItem.Price!.myRounded(toPlaces: 2)) SR", attributes: sfProDisplay_boldFontAttributes_27)
        let attributedStringWidth1 = attributedString.string.size(withAttributes: sfProDisplay_boldFontAttributes_27).width
        if L102Language.currentAppleLanguage() == "ar" {
            
            drawInRectWithString(mutableString: attributedString, frame: CGRect(x: Double(attributedString.size().width) - paddingFromLeft - Double(attributedStringWidth1), y: yCoordinate, width: Double(paperSize.width), height: sfProDisplay_boldFontAttributes_27_height))
        } else {
            drawInRectWithString(mutableString: attributedString, frame: CGRect(x: Double(paperSize.width) - paddingFromLeft - Double(attributedStringWidth1), y: yCoordinate, width: Double(paperSize.width), height: sfProDisplay_boldFontAttributes_27_height))
        }
        
        
        
        
        attributedString = NSMutableAttributedString(string: "\(Constants.checkoutcarmake)", attributes: sfProDisplay_mediumFontAttributes_27)
        //  drawInRectWithString(mutableString: attributedString, frame: CGRect(x: paddingFromLeft, y: yCoordinate + 45, width: Double(paperSize.width), height: sfProDisplay_mediumFontAttributes_27_height))
        drawInRectWithString(mutableString: attributedString, frame: CGRect(x: paddingFromLeft, y: yCoordinate + 45, width: Double(attributedString.size().width), height: sfProDisplay_heavyFontAttributes_37_height))
        
        attributedString = NSMutableAttributedString(string: "\(Constants.checkoutcarmodel)", attributes: sfProDisplay_mediumFontAttributes_27)
        //  drawInRectWithString(mutableString: attributedString, frame: CGRect(x: Double(paperSize.width*0.70), y: yCoordinate + 45, width: Double(paperSize.width), height: sfProDisplay_boldFontAttributes_27_height))
        let attributedStringWidth2 = attributedString.string.size(withAttributes: sfProDisplay_boldFontAttributes_27).width
        if L102Language.currentAppleLanguage() == "ar" {
            drawInRectWithString(mutableString: attributedString, frame: CGRect(x: Double(attributedString.size().width) - paddingFromLeft - Double(attributedStringWidth2), y: yCoordinate + 45, width: Double(paperSize.width), height: sfProDisplay_boldFontAttributes_27_height))
          
        } else {
            drawInRectWithString(mutableString: attributedString, frame: CGRect(x: Double(paperSize.width) - paddingFromLeft - Double(attributedStringWidth2), y: yCoordinate + 45, width: Double(paperSize.width), height: sfProDisplay_boldFontAttributes_27_height))
           
        }
        
        
        if receiptConfigurationModel.showTable {
            attributedString = NSMutableAttributedString(string: "Km \(Constants.checkoutcustm)", attributes: sfProDisplay_mediumFontAttributes_27)
            
            // drawInRectWithString(mutableString: attributedString, frame: CGRect(x: paddingFromLeft, y: yCoordinate + 90, width: Double(paperSize.width), height: sfProDisplay_mediumFontAttributes_27_height))
            drawInRectWithString(mutableString: attributedString, frame: CGRect(x: paddingFromLeft, y: yCoordinate + 90, width: Double(attributedString.size().width), height: sfProDisplay_heavyFontAttributes_37_height))
        }
        
        if let orderTaker = orderDetails.orderPrinterType {
            attributedString = NSMutableAttributedString(string: "\(Constants.checkoutyear)", attributes: sfProDisplay_mediumFontAttributes_27)
            // drawInRectWithString(mutableString: attributedString, frame: CGRect(x: Double(paperSize.width*0.70), y: yCoordinate + 90, width: Double(paperSize.width), height: sfProDisplay_boldFontAttributes_27_height))
            let attributedStringWidth3 = attributedString.string.size(withAttributes: sfProDisplay_boldFontAttributes_27).width
            if L102Language.currentAppleLanguage() == "ar" {
               drawInRectWithString(mutableString: attributedString, frame: CGRect(x: Double(attributedString.size().width) - paddingFromLeft - Double(attributedStringWidth3), y: yCoordinate + 90, width: Double(paperSize.width), height: sfProDisplay_boldFontAttributes_27_height))
            } else {
               drawInRectWithString(mutableString: attributedString, frame: CGRect(x: Double(paperSize.width) - paddingFromLeft - Double(attributedStringWidth3), y: yCoordinate + 90, width: Double(paperSize.width), height: sfProDisplay_boldFontAttributes_27_height))
            }
           
        }
    }
 
    
    
    
}


extension CheckoutReceiptBuilder: CheckoutReceiptPrintable {
    
    func getHeaderForCheckout() -> UIImage {
        var yCoordinate: Double = 0
        
        var paperSize = CGSize(width: self.receiptSize.width, height: 0)
        let logo = NSTextAttachment()
        var name = ""
        var phoneNumber = ""
        var VAT = ""
        var cashier = ""
        
        if receiptConfigurationModel.showLogo {
            logo.image = companyInfo.logo
            paperSize.height = paperSize.height + (logo.image?.size.height)!
        }
        
        if receiptConfigurationModel.showCompanyName {
            name = companyInfo.name
            paperSize.height = paperSize.height + CGFloat(sfProDisplay_mediumFontAttributes_32_height) + 10
        }
        
        if receiptConfigurationModel.showCompanyName {
            name = companyInfo.name
            paperSize.height = paperSize.height + CGFloat(sfProDisplay_mediumFontAttributes_30_height) + 10
        }
        
        if receiptConfigurationModel.showPhone {
            phoneNumber = companyInfo.phoneNumber
            paperSize.height = paperSize.height + CGFloat(sfProDisplay_mediumFontAttributes_30_height) + 10
        }
        
        
        if receiptConfigurationModel.showPhone {
            VAT = companyInfo.valueAddedTaxNumber
            paperSize.height = paperSize.height + CGFloat(sfProDisplay_mediumFontAttributes_30_height) + 10
        }
        
        if receiptConfigurationModel.showEmail {
            cashier = companyInfo.cashier
            paperSize.height = paperSize.height + CGFloat(sfProDisplay_mediumFontAttributes_30_height) + 10
        }
        
        if Constants.checkoutstatus == 103 {
            paperSize.height = paperSize.height + 110  //80
        } else if Constants.checkoutstatus == 104 {
            paperSize.height = paperSize.height + 40
        }
        
        let tempImage = UIImage()
        UIGraphicsBeginImageContext(paperSize)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(UIColor.white.cgColor)
        let tempRect = CGRect(x: 0, y: 0, width: paperSize.width, height: paperSize.height)
        tempImage.draw(in: tempRect)
        context?.fill(tempRect)
        
        if Constants.checkoutstatus == 103 {
            
            let attributedString = NSMutableAttributedString(string: "DUPLICATE", attributes: sfProDisplay_heavyFontAttributes_37boldD)
            drawInRectWithString(mutableString: attributedString, frame: CGRect(x: Double((receiptSize.width-attributedString.size().width)/1.8), y: yCoordinate, width: Double(attributedString.size().width), height: sfProDisplay_mediumFontAttributes_32_height+20))
            yCoordinate = yCoordinate + sfProDisplay_mediumFontAttributes_30_height + 40   //10
        }
        
        if name != "" {
            //            yCoordinate = yCoordinate + 20
            let attributedString = NSMutableAttributedString(string: "\(Constants.checkoutorderNo)", attributes: sfProDisplay_mediumFontAttributes_32)
             if L102Language.currentAppleLanguage() == "ar" {
                drawInRectWithString(mutableString: attributedString, frame: CGRect(x: Double((attributedString.size().width-(logo.image?.size.width)!)/7), y: yCoordinate, width: Double((logo.image?.size.width)!), height: Double((logo.image?.size.height)!)))
             } else {
                drawInRectWithString(mutableString: attributedString, frame: CGRect(x: Double((receiptSize.width-(logo.image?.size.width)!)/7), y: yCoordinate, width: Double((logo.image?.size.width)!), height: Double((logo.image?.size.height)!)))
            }
            
        
            //attributedString.accessibilityLanguage
        }
        
        if receiptConfigurationModel.showLogo {
            let attributedString = NSAttributedString(attachment: logo) as! NSMutableAttributedString
            drawInRectWithString(mutableString: attributedString, frame: CGRect(x: Double((receiptSize.width-(logo.image?.size.width)!)/2), y: yCoordinate, width: Double(attributedString.size().width), height: Double((logo.image?.size.height)!)))
            yCoordinate = yCoordinate + Double((logo.image?.size.height)!) + 10
        }
        
        if name != "" {
            yCoordinate = yCoordinate + 20
            let attributedString = NSMutableAttributedString(string: name, attributes: sfProDisplay_mediumFontAttributes_32)
            drawInRectWithString(mutableString: attributedString, frame: CGRect(x: Double((receiptSize.width-attributedString.size().width)/2), y: yCoordinate, width: Double(attributedString.size().width), height: sfProDisplay_mediumFontAttributes_32_height))
            yCoordinate = yCoordinate + sfProDisplay_mediumFontAttributes_32_height + 10
        }
        
        if phoneNumber != "" {
            let attributedString = NSMutableAttributedString(string: "Phone No: \(phoneNumber)", attributes: sfProDisplay_mediumFontAttributes_27)
            drawInRectWithString(mutableString: attributedString, frame: CGRect(x: Double((receiptSize.width-attributedString.size().width)/2), y: yCoordinate, width: Double(attributedString.size().width), height: sfProDisplay_mediumFontAttributes_30_height))
            yCoordinate = yCoordinate + sfProDisplay_mediumFontAttributes_30_height + 10
        }
        
        
        if VAT != "" {
            let attributedString = NSMutableAttributedString(string: "VAT: \(VAT)", attributes: sfProDisplay_mediumFontAttributes_32)
            drawInRectWithString(mutableString: attributedString, frame: CGRect(x: Double((receiptSize.width-attributedString.size().width)/2), y: yCoordinate, width: Double(attributedString.size().width), height: sfProDisplay_mediumFontAttributes_32_height))
            yCoordinate = yCoordinate + sfProDisplay_mediumFontAttributes_30_height + 10
        }
        
        if cashier != "" {
            let attributedString = NSMutableAttributedString(string: "Cashier: \(cashier)", attributes: sfProDisplay_mediumFontAttributes_32)
            drawInRectWithString(mutableString: attributedString, frame: CGRect(x: Double((receiptSize.width-attributedString.size().width)/2), y: yCoordinate, width: Double(attributedString.size().width), height: sfProDisplay_mediumFontAttributes_32_height))
            yCoordinate = yCoordinate + sfProDisplay_mediumFontAttributes_30_height + 10
        }
        
        
        let attributedString = NSMutableAttributedString(string: "VIN: \(companyInfo.vin)", attributes: sfProDisplay_mediumFontAttributes_32)
        drawInRectWithString(mutableString: attributedString, frame: CGRect(x: Double((receiptSize.width-attributedString.size().width)/2), y: yCoordinate, width: Double(attributedString.size().width), height: sfProDisplay_mediumFontAttributes_32_height))
        
        
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    
    func getItemDetailsWithAmount() -> UIImage {
        
        var modifiersCount = 0
        var modifiersCount2 = 0
        
        for cartItem in  Checkoutstruct.sentitems {
            modifiersCount = modifiersCount + (cartItem.Name?.count)!
            modifiersCount2 = modifiersCount2 + Checkoutstruct.sentitems.count
            
        }
        print(modifiersCount) // 25
        print(Checkoutstruct.sentitems.count) // 16
        
        let paperSize = CGSize(width: receiptSize.width, height: CGFloat(Checkoutstruct.sentitems.count * 120) + CGFloat(modifiersCount * 1) - 40)
        // print(paperSize.height)
        var yCoordinate: Double = 0
        
        let tempImage = UIImage()
        UIGraphicsBeginImageContext(paperSize)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(UIColor.white.cgColor)
        let tempRect = CGRect(x: 0, y: 0, width: paperSize.width, height: paperSize.height)
        tempImage.draw(in: tempRect)
        context?.fill(tempRect)
        
        for i in 0..<Checkoutstruct.sentitems.count { //checkout Items
            let cartItem = Checkoutstruct.sentitems[i]
            let nameOnReceipt = cartItem.AlternateName ?? "-"
            
            var attributedString = NSMutableAttributedString(string: "\(cartItem.Quantity!) x ", attributes: sfProDisplay_heavyFontAttributes_37bold)
            
            let xCoordinate: Double = Double(attributedString.size().width)
            print(cartItem.Name!.characters.count)
            attributedString.append(NSMutableAttributedString(string: "\(cartItem.Name!)", attributes: sfProDisplay_semiBoldFontAttributes_30))
            drawInRectWithString(mutableString: attributedString, frame: CGRect(x: paddingFromLeft, y: yCoordinate, width: Double(attributedString.size().width), height: sfProDisplay_heavyFontAttributes_37_height))
            
            attributedString = NSMutableAttributedString(string: "\(cartItem.Price!.myRounded(toPlaces: 2)) SR", attributes: sfProDisplay_boldFontAttributes_27)
            let attributedStringWidth = attributedString.string.size(withAttributes: sfProDisplay_boldFontAttributes_27).width
            drawInRectWithString(mutableString: attributedString, frame: CGRect(x: Double(paperSize.width) - paddingFromLeft - Double(attributedStringWidth), y: yCoordinate, width: Double(attributedString.size().width), height: sfProDisplay_boldFontAttributes_27_height))
            
            yCoordinate = yCoordinate + 20
            
            if nameOnReceipt != "" {
                attributedString = NSMutableAttributedString(string: "\n\(nameOnReceipt)", attributes: geezaPro_boldFontAttributes_30)
                drawInRectWithString(mutableString: attributedString, frame: CGRect(x: paddingFromLeft+xCoordinate, y: yCoordinate, width: Double(attributedString.size().width), height: Double(attributedString.size().height)))
                yCoordinate = yCoordinate + geezaPro_boldFontAttributes_30_height + 40
            } else {
                yCoordinate = yCoordinate + sfProDisplay_heavyFontAttributes_37_height
            }
            
            /// Modifiers
            
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
            
            if i != (Checkoutstruct.sentitems.count - 1) {
                yCoordinate = yCoordinate + 20
                //   drawSmallSeparator(at: yCoordinate)
                //yCoordinate = yCoordinate + 40
            }
        }
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    func getSubTotal() -> UIImage {
        // let discountPercent = String(format: "%g", (Constants.percent))
        let englishTitles = ["Sub Total", "Discount", "VAT (\(Constants.percent)%)"]
        let arabicTitles = ["المجموع", "الخصم", "ضريبة القيمة المضافة"]
        let amounts = [Constants.subtotal, Constants.checkoutdiscount, Constants.checkouttax] as [Any]
        
        let paperSize = CGSize(width: receiptSize.width, height: CGFloat(3 * 140) - 40)
        
        var yCoordinate: Double = 0
        
        let tempImage = UIImage()
        UIGraphicsBeginImageContext(paperSize)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(UIColor.white.cgColor)
        let tempRect = CGRect(x: 0, y: 0, width: paperSize.width, height: paperSize.height)
        tempImage.draw(in: tempRect)
        context?.fill(tempRect)
        
        drawSmallSeparator(at: yCoordinate)
        
        yCoordinate = yCoordinate + 50
        
        for i in 0..<englishTitles.count {
            let englishTitle = englishTitles[i]
            let arabicTitle = arabicTitles[i]
            var attributedString = NSMutableAttributedString(string: "\(englishTitle)", attributes: sfProDisplay_semiBoldFontAttributes_30)
            
            drawInRectWithString(mutableString: attributedString, frame: CGRect(x: paddingFromLeft, y: yCoordinate, width: Double(attributedString.size().width), height: sfProDisplay_semiBoldFontAttributes_30_height))
            print(paddingFromLeft)
            let amount = String(format: "%.2f", (amounts[i] as! CVarArg))
            attributedString = NSMutableAttributedString(string: "\(amount) SR", attributes: sfProDisplay_boldFontAttributes_27)
            
            let attributedStringWidth = attributedString.string.size(withAttributes: sfProDisplay_boldFontAttributes_27).width
            drawInRectWithString(mutableString: attributedString, frame: CGRect(x: Double(paperSize.width) - paddingFromLeft - Double(attributedStringWidth), y: yCoordinate, width: Double(attributedString.size().width), height: sfProDisplay_boldFontAttributes_27_height))
             print(paddingFromLeft)
            attributedString = NSMutableAttributedString(string: "\n\(arabicTitle)", attributes: geezaPro_boldFontAttributes_30)
            drawInRectWithString(mutableString: attributedString, frame: CGRect(x: paddingFromLeft, y: yCoordinate, width: Double(attributedString.size().width), height: Double(attributedString.size().height)))
            yCoordinate = yCoordinate + geezaPro_boldFontAttributes_30_height + 40
             print(paddingFromLeft)
            yCoordinate = yCoordinate + 40
        }
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    func getGrandTotal() -> UIImage {
        var paymentVia = ""
        
        if Constants.checkoutstatus == 103 { // For Reprint
            Constants.paymentflag = Constants.PaymentModes
            if Constants.paymentflag == 1 {
                paymentVia = "Cash"
            } else if Constants.paymentflag == 2 {
                paymentVia = "\(Constants.CardType)"
            } else if Constants.paymentflag == 3 {
                paymentVia = "\(Constants.CardType)"
            }
            
            
        } else {
        
        if Constants.paymentflag == 1 {
             paymentVia = "Cash"
        } else if Constants.paymentflag == 2 {
            paymentVia = "\(cardtype)"
        } else if Constants.paymentflag == 3 {
            print(Constants.CardType)
            paymentVia = "\(Constants.CardTypecheckout)"
        }
        }
        
        
        
        var paperSize = CGSize(width: receiptSize.width, height: 180)
        
        if Constants.paymentflag == 3 {    // For adding vash and card field
            paperSize.height = paperSize.height + 80
        } else {
            paperSize.height = paperSize.height + 30
        }
        
        var yCoordinate: Double = 0
        
        let tempImage = UIImage()
        UIGraphicsBeginImageContext(paperSize)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(UIColor.white.cgColor)
        let tempRect = CGRect(x: 0, y: 0, width: paperSize.width, height: paperSize.height)
        tempImage.draw(in: tempRect)
        context?.fill(tempRect)
        
        drawSmallSeparator(at: yCoordinate)
        
        yCoordinate = yCoordinate + 30
        
        /// Grand Total
        let grandTotal = String(format: "%.2f", (Constants.checkoutGrandtotal))
        var attributedString = NSMutableAttributedString(string: "Grand Total", attributes: sfProDisplay_heavyFontAttributes_37bold)
        drawInRectWithString(mutableString: attributedString, frame: CGRect(x: paddingFromLeft, y: yCoordinate, width: Double(attributedString.size().width), height: sfProDisplay_heavyFontAttributes_37_height))
        
        attributedString = NSMutableAttributedString(string: "\(grandTotal) SR", attributes: sfProDisplay_heavyFontAttributes_37bold)
        let attributedStringWidth = attributedString.string.size(withAttributes: sfProDisplay_heavyFontAttributes_37bold).width
        drawInRectWithString(mutableString: attributedString, frame: CGRect(x: Double(paperSize.width) - paddingFromLeft - Double(attributedStringWidth), y: yCoordinate, width: Double(attributedString.size().width), height: sfProDisplay_heavyFontAttributes_30_height))
        
        yCoordinate = yCoordinate + sfProDisplay_heavyFontAttributes_30_height + 20
        
        attributedString = NSMutableAttributedString(string: "الإجمالي", attributes: sfProDisplay_boldFontAttributes_27)
        drawInRectWithString(mutableString: attributedString, frame: CGRect(x: paddingFromLeft, y: yCoordinate, width: Double(attributedString.size().width), height: geezaPro_boldFontAttributes_30_height))
        
            yCoordinate = yCoordinate + geezaPro_boldFontAttributes_30_height + 30
        
        
        /// Payment details
        
        if paymentVia != "" {
            if Constants.paymentflag == 3 { // For adding cash and card field with individual amount
                attributedString = NSMutableAttributedString(string: "Payment - Cash", attributes: sfProDisplay_mediumFontAttributes_30)
                // drawInRectWithString(mutableString: attributedString, frame: CGRect(x: paddingFromLeft, y: yCoordinate, width: Double(attributedString.size().width), height: sfProDisplay_mediumFontAttributes_30_height))
                drawInRectWithString(mutableString: attributedString, frame: CGRect(x: paddingFromLeft, y: yCoordinate, width: Double(attributedString.size().width), height: sfProDisplay_heavyFontAttributes_37_height))
                 if Constants.checkoutstatus == 104 {   // reprint or checkout
              attributedString = NSMutableAttributedString(string: "\(Constants.CashAmountcheckout) SR", attributes: sfProDisplay_mediumFontAttributes_30)
                 } else {
                    attributedString = NSMutableAttributedString(string: "\(Constants.CashAmount) SR", attributes: sfProDisplay_mediumFontAttributes_30)
                    
                }
                
                
                 //            drawInRectWithString(mutableString: attributedString, frame: CGRect(x: Double(paperSize.width) - paddingFromLeft - Double(attributedStringWidth), y: yCoordinate, width: Double(attributedString.size().width), height: sfProDisplay_mediumFontAttributes_30_height))
                let attributedStringWidth3 = attributedString.string.size(withAttributes: sfProDisplay_boldFontAttributes_27).width
                 if L102Language.currentAppleLanguage() == "ar" {
                    drawInRectWithString(mutableString: attributedString, frame: CGRect(x: Double(attributedString.size().width) - paddingFromLeft - Double(attributedStringWidth3), y: yCoordinate, width: Double(paperSize.width), height: sfProDisplay_boldFontAttributes_27_height))
                 } else {
                    drawInRectWithString(mutableString: attributedString, frame: CGRect(x: Double(paperSize.width) - paddingFromLeft - Double(attributedStringWidth3), y: yCoordinate, width: Double(paperSize.width), height: sfProDisplay_boldFontAttributes_27_height))
                }
        
                print(Double(paperSize.width) - paddingFromLeft - Double(attributedStringWidth))
                
                yCoordinate = yCoordinate + geezaPro_boldFontAttributes_30_height + 30

            }
            attributedString = NSMutableAttributedString(string: "Payment - \(paymentVia)", attributes: sfProDisplay_mediumFontAttributes_30)
            // drawInRectWithString(mutableString: attributedString, frame: CGRect(x: paddingFromLeft, y: yCoordinate, width: Double(attributedString.size().width), height: sfProDisplay_mediumFontAttributes_30_height))
            drawInRectWithString(mutableString: attributedString, frame: CGRect(x: paddingFromLeft, y: yCoordinate, width: Double(attributedString.size().width), height: sfProDisplay_heavyFontAttributes_37_height))
            
             if Constants.paymentflag == 3 {
                
                
                
                if Constants.checkoutstatus == 104 {
                    attributedString = NSMutableAttributedString(string: "\(Constants.CardAmountcheckout) SR", attributes: sfProDisplay_mediumFontAttributes_30)
                } else {
                
                
            attributedString = NSMutableAttributedString(string: "\(Constants.CardAmount) SR", attributes: sfProDisplay_mediumFontAttributes_30)
            }
                
            }  else {
                 attributedString = NSMutableAttributedString(string: "\(grandTotal) SR", attributes: sfProDisplay_mediumFontAttributes_30)
            }
            //            drawInRectWithString(mutableString: attributedString, frame: CGRect(x: Double(paperSize.width) - paddingFromLeft - Double(attributedStringWidth), y: yCoordinate, width: Double(attributedString.size().width), height: sfProDisplay_mediumFontAttributes_30_height))
            
            let attributedStringWidth3 = attributedString.string.size(withAttributes: sfProDisplay_boldFontAttributes_27).width
             if L102Language.currentAppleLanguage() == "ar" {
                drawInRectWithString(mutableString: attributedString, frame: CGRect(x: Double(attributedString.size().width) - paddingFromLeft - Double(attributedStringWidth3), y: yCoordinate, width: Double(paperSize.width), height: sfProDisplay_boldFontAttributes_27_height))
             } else {
                drawInRectWithString(mutableString: attributedString, frame: CGRect(x: Double(paperSize.width) - paddingFromLeft - Double(attributedStringWidth3), y: yCoordinate, width: Double(paperSize.width), height: sfProDisplay_boldFontAttributes_27_height))
            }
            
            print(Double(paperSize.width) - paddingFromLeft - Double(attributedStringWidth))
        }
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    func getCheckoutFooter() -> UIImage {
        
        let paperSize = CGSize(width: receiptSize.width, height: 140.0)
        
        var yCoordinate: Double = 0
        
        let tempImage = UIImage()
        UIGraphicsBeginImageContext(paperSize)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(UIColor.white.cgColor)
        let tempRect = CGRect(x: 0, y: 0, width: paperSize.width, height: paperSize.height)
        tempImage.draw(in: tempRect)
        context?.fill(tempRect)
        
        // Start: Small Separator
        drawSmallSeparator(at: yCoordinate)
        // End: Small Separator
        
        yCoordinate = yCoordinate + 20
        
        let attributedString = NSMutableAttributedString(string: Constants.Footer, attributes: sfProDisplay_mediumFontAttributes_27)
        let attributedStringSize = attributedString.string.size(withAttributes: sfProDisplay_mediumFontAttributes_27)
        drawInRectWithString(mutableString: attributedString, frame: CGRect(x: Double(paperSize.width - attributedStringSize.width)/2, y: yCoordinate, width: Double(attributedString.size().width), height: sfProDisplay_mediumFontAttributes_27_height))
        
        yCoordinate = yCoordinate + 40
        
        drawLinks(at: yCoordinate)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    func setWidthOfReceipt(width: CGFloat) {
        receiptSize.width = width
    }
    
    func getTransactionDetails() -> UIImage {
        let paperSize = CGSize(width: receiptSize.width, height: 440) //300/420
        
        var yCoordinate: Double = 0
        
        let tempImage = UIImage()
        UIGraphicsBeginImageContext(paperSize)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(UIColor.white.cgColor)
        let tempRect = CGRect(x: 0, y: 0, width: paperSize.width, height: paperSize.height)
        tempImage.draw(in: tempRect)
        context?.fill(tempRect)
        let attachment = NSTextAttachment()
        
        // Start: Transation Number (on top)
        
        
        //        }
        
        
        
        
        
        
        
        attachment.image = UIImage(named: "plt2.png")!
        let attributedStrings = NSAttributedString(attachment: attachment) as! NSMutableAttributedString
        let attributedStringSize2 = attributedStrings.string.size(withAttributes: sfProDisplay_semiBoldFontAttributes_90)
        drawInRectWithString(mutableString: attributedStrings, frame: CGRect(x: Double((paperSize.width-attributedStringSize2.width)/6), y: yCoordinate, width: Double(attributedStrings.size().width), height: Double(sfProDisplay_semiBoldFontAttributes_90_height + 150))) //150
        yCoordinate = yCoordinate + sfProDisplay_mediumFontAttributes_30_height - 5 //-5
        
        let attributedString = NSMutableAttributedString(string: Constants.checkoutplatenmb4, attributes: geezaPro_boldFontAttributes_30bold)
        let attributedStringSize = attributedString.string.size(withAttributes: geezaPro_boldFontAttributes_30bold)
        drawInRectWithString(mutableString: attributedString, frame: CGRect(x: Double((paperSize.width-attributedStringSize.width)/3.6), y: yCoordinate, width: Double(attributedString.size().width), height: Double(sfProDisplay_semiBoldFontAttributes_90_height)))
        let attributedString1 = NSMutableAttributedString(string: Constants.checkoutplatenmb3, attributes: geezaPro_boldFontAttributes_30bold)
        let attributedStringSize1 = attributedString1.string.size(withAttributes: geezaPro_boldFontAttributes_30bold)
        drawInRectWithString(mutableString: attributedString1, frame: CGRect(x: Double((paperSize.width-attributedStringSize1.width)/1.6), y: yCoordinate, width: Double(attributedString1.size().width), height: Double(sfProDisplay_semiBoldFontAttributes_90_height)))
        yCoordinate = yCoordinate + sfProDisplay_mediumFontAttributes_30_height + 50
        let attributedString2 = NSMutableAttributedString(string: Constants.checkoutplatenmb2, attributes: sfProDisplay_semiBoldFontAttributes_30bold)
        let attributedStringSize4 = attributedString2.string.size(withAttributes: sfProDisplay_semiBoldFontAttributes_30bold)
        drawInRectWithString(mutableString: attributedString2, frame: CGRect(x: Double((paperSize.width-attributedStringSize4.width)/3.6), y: yCoordinate, width: Double(attributedString2.size().width), height: Double(sfProDisplay_semiBoldFontAttributes_90_height)))
        let attributedString3 = NSMutableAttributedString(string: Constants.checkoutplatenmb1, attributes: sfProDisplay_semiBoldFontAttributes_30bold)
        let attributedStringSize3 = attributedString3.string.size(withAttributes: sfProDisplay_semiBoldFontAttributes_30bold)
        drawInRectWithString(mutableString: attributedString3, frame: CGRect(x: Double((paperSize.width-attributedStringSize3.width)/1.6), y: yCoordinate, width: Double(attributedString3.size().width), height: Double(sfProDisplay_semiBoldFontAttributes_90_height)))
        
        //        let attributedString = NSMutableAttributedString(string: "\(Constants.checkoutplatenmb)", attributes: sfProDisplay_semiBoldFontAttributes_90)
        //        let attributedStringSize = attributedString.string.size(withAttributes: sfProDisplay_semiBoldFontAttributes_90)
        //        drawInRectWithString(mutableString: attributedString, frame: CGRect(x: Double((paperSize.width-attributedStringSize.width)/2), y: yCoordinate, width: Double(attributedString.size().width), height: Double(sfProDisplay_semiBoldFontAttributes_90_height)))
        // End: Transation Number (on top)
        
        yCoordinate = Double(sfProDisplay_semiBoldFontAttributes_90_height + 180)  //30 //160
        
        
        
        
        
        
        
        
        
        
        // Start: Small Separator
        drawSmallSeparator(at: yCoordinate)
        // End: Small Separator
        
        yCoordinate = yCoordinate + 10
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        print(Constants.currentdate)
        if Constants.checkoutstatus == 103 {
            Constants.currentdate = Constants.Checkoutdate
        }
        
        let dateString2 = dateFormatter.date(from: Constants.currentdate)
        // Start: Data and time (i.e 11/12/18        09:00 PM)
        drawDateAndTime(date: dateString2! as NSDate, at: yCoordinate)
        // End: Data and time (i.e 11/12/18        09:00 PM)
        
        yCoordinate = yCoordinate + 40
        
        // Start: Small Separator
        drawSmallSeparator(at: yCoordinate)
        // End: Small Separator
        
        yCoordinate = yCoordinate + 30
        
        // Start: Order Details i.e. order number, type etc
        drawOrderDetails(at: yCoordinate)
        // End: Order Details i.e. order number, type etc
        
        yCoordinate = yCoordinate + 30
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    func createReceiptImage() -> UIImage {
        var image = getHeaderForCheckout()
        
        image = mergeImageTopToBottom(topImage: image, bottomImage: getTransactionDetails())
        image = mergeImageTopToBottom(topImage: image, bottomImage: getWhiteImage(size: CGSize(width: receiptSize.width, height: 30)))
        image = mergeImageTopToBottom(topImage: image, bottomImage: getSeparator())
        image = mergeImageTopToBottom(topImage: image, bottomImage: getWhiteImage(size: CGSize(width: receiptSize.width, height: 30)))
        
        image = mergeImageTopToBottom(topImage: image, bottomImage: getItemDetailsWithAmount())
        image = mergeImageTopToBottom(topImage: image, bottomImage: getWhiteImage(size: CGSize(width: receiptSize.width, height: 15)))
        
        image = mergeImageTopToBottom(topImage: image, bottomImage: getSubTotal())
        image = mergeImageTopToBottom(topImage: image, bottomImage: getWhiteImage(size: CGSize(width: receiptSize.width, height: 15)))
        
        image = mergeImageTopToBottom(topImage: image, bottomImage: getGrandTotal())
        
        image = mergeImageTopToBottom(topImage: image, bottomImage: getCheckoutFooter())
        
        return image
    }
    
    
}
