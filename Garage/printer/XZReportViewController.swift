//
//  XZReportViewController.swift
//  Garage
//
//  Created by Amjad on 25/07/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit

class XZReportViewController: UIViewController,Epos2PtrReceiveDelegate {

    
        var printer: Epos2Printer?
        var valuePrinterSeries: Epos2PrinterSeries = EPOS2_TM_M10
        var valuePrinterModel: Epos2ModelLang = EPOS2_MODEL_ANK
    
    let PAGE_AREA_HEIGHT: Int = 500
    let PAGE_AREA_WIDTH: Int = 500
    let FONT_A_HEIGHT: Int = 24
    let FONT_A_WIDTH: Int = 16
    let BARCODE_HEIGHT_POS: Int = 70
    let BARCODE_WIDTH_POS: Int = 110
      private var printerDetailsModel = PrinterDetailsModel()
    override func viewDidLoad() {
        super.viewDidLoad()
       self.navigationController?.isNavigationBarHidden = true
        Constants.Printer = UserDefaults.standard.string(forKey: "printer") ?? ""
        // Do any additional setup after loading the view.
    }
    

    @IBAction func XreportBtn(_ sender: Any) {
      //  self.runPrinterReceiptSequence()
        CallEngine.printXReport(completion: { (success, message) in
            print(message)
          //  Loader.stopLoading()
        })
    }
    
    
    @IBAction func ZreportBtn(_ sender: Any) {
    }
    
    
    
    
        func runPrinterReceiptSequence() -> Bool {
    
            if !initializePrinterObject() {
                return false
            }
    
            if !createReceiptData() {
                finalizePrinterObject()
                return false
            }
    
            if !printData() {
                finalizePrinterObject()
                return false
            }
    
            return true
        }
    
        func runPrinterCouponSequence() -> Bool {
    
            if !initializePrinterObject() {
                return false
            }
    
            if !createCouponData() {
                finalizePrinterObject()
                return false
            }
    
            if !printData() {
                finalizePrinterObject()
                return false
            }
    
            return true
        }
    
        func createReceiptData() -> Bool {
    
            var result = EPOS2_SUCCESS.rawValue
    
            let textData: NSMutableString = NSMutableString()
            let logoData = UIImage(named: "marngarage.png")
    
            if logoData == nil {
                return false
            }
    
            result = printer!.addTextAlign(EPOS2_ALIGN_CENTER.rawValue)
            if result != EPOS2_SUCCESS.rawValue {
                MessageView.showErrorEpos(result, method:"addTextAlign")
                return false;
            }
    
            result = printer!.add(logoData, x: 0, y:0,
                                  width:Int(logoData!.size.width),
                                  height:Int(logoData!.size.height),
                                  color:EPOS2_COLOR_1.rawValue,
                                  mode:EPOS2_MODE_MONO.rawValue,
                                  halftone:EPOS2_HALFTONE_DITHER.rawValue,
                                  brightness:Double(EPOS2_PARAM_DEFAULT),
                                  compress:EPOS2_COMPRESS_AUTO.rawValue)
    
            if result != EPOS2_SUCCESS.rawValue {
                MessageView.showErrorEpos(result, method:"addImage")
                return false
            }
    
    
            // Section 1 : Store information
            result = printer!.addFeedLine(1)
            if result != EPOS2_SUCCESS.rawValue {
                MessageView.showErrorEpos(result, method:"addFeedLine")
                return false
            }
            result = printer!.addTextAlign(EPOS2_ALIGN_CENTER.rawValue)
            if result != EPOS2_SUCCESS.rawValue {
                MessageView.showErrorEpos(result, method:"addTextAlign")
                return false;
            }
            textData.append(Constants.LocationName)
            textData.append("Phone No. \(Constants.CompanyPhones)\n")
            textData.append("\n")
            //textData.append("\(Constants.currentdate)\n")
            // textData.append("Majid Bin Abdul Aziz Road\n")
            textData.append("VAT# \(Constants.VAT)\n")
            textData.append("\n")
            textData.append("Plate No. \(Constants.checkoutplatenmb)\n")
            textData.append("\n")
            textData.append("VIN: \(Constants.checkoutvin)\n")
            textData.append("\n\n")
            textData.append("------------------------------\n")
            textData.append("\(Constants.currentdate)\n")
            textData.append("------------------------------\n")
            textData.append("\(Constants.checkoutcustm)                       \(Constants.checkoutbayname)\n")
            textData.append("\(Constants.checkoutcarmake)                      \(Constants.checkoutcarmodel)\n")
            textData.append("00km                       \(Constants.checkoutyear)\n")
    
            textData.append("------------------------------\n\n")
            result = printer!.addText(textData as String)
            if result != EPOS2_SUCCESS.rawValue {
                MessageView.showErrorEpos(result, method:"addText")
                return false;
            }
            textData.setString("")
    
            result = printer!.addTextAlign(EPOS2_ALIGN_CENTER.rawValue)
            if result != EPOS2_SUCCESS.rawValue {
                MessageView.showErrorEpos(result, method:"addTextAlign")
                return false;
            }
    
            // Section 2 : Purchaced items
            for receipt in Checkoutstruct.sentitems {
                textData.append("\(receipt.Quantity!)X \(receipt.Name!) ------------------ \(receipt.Price!) SR\n")
                //        textData.append("410 3 CUP BLK TEAPOT    9.99 R\n")
                //        textData.append("445 EMERIL GRIDDLE/PAN 17.99 R\n")
                //        textData.append("438 CANDYMAKER ASSORT   4.99 R\n")
                //        textData.append("474 TRIPOD              8.99 R\n")
                //        textData.append("433 BLK LOGO PRNTED ZO  7.99 R\n")
                //        textData.append("458 AQUA MICROTERRY SC  6.99 R\n")
                //        textData.append("493 30L BLK FF DRESS   16.99 R\n")
                //        textData.append("407 LEVITATING DESKTOP  7.99 R\n")
                //        textData.append("441 **Blue Overprint P  2.99 R\n")
                //        textData.append("476 REPOSE 4PCPM CHOC   5.49 R\n")
                //        textData.append("461 WESTGATE BLACK 25  59.99 R\n")
            }
            textData.append("\n")
            textData.append("------------------------------\n")
            result = printer!.addText(textData as String)
            if result != EPOS2_SUCCESS.rawValue {
                MessageView.showErrorEpos(result, method:"addText")
                return false;
            }
            textData.setString("")
    
    
            // Section 3 : Payment infomation
            textData.append("SUBTOTAL                 \( Constants.subtotal) SR\n");
             textData.append("Discount                   0.0 SR\n");
            textData.append("VAT(\(Constants.percent)%)                   \(Constants.checkouttax) SR\n\n");
            result = printer!.addText(textData as String)
            if result != EPOS2_SUCCESS.rawValue {
                MessageView.showErrorEpos(result, method:"addText")
                return false
            }
            textData.setString("")
    
            result = printer!.addTextSize(2, height:2)
            if result != EPOS2_SUCCESS.rawValue {
                MessageView.showErrorEpos(result, method:"addTextSize")
                return false
            }
    
            result = printer!.addText("TOTAL    \(Constants.checkoutGrandtotal) SR\n")
            if result != EPOS2_SUCCESS.rawValue {
                MessageView.showErrorEpos(result, method:"addText")
                return false;
            }
    
            result = printer!.addTextSize(1, height:1)
            if result != EPOS2_SUCCESS.rawValue {
                MessageView.showErrorEpos(result, method:"addTextSize")
                return false;
            }
    
            result = printer!.addFeedLine(1)
            if result != EPOS2_SUCCESS.rawValue {
                MessageView.showErrorEpos(result, method:"addFeedLine")
                return false;
            }
    
            textData.append("CASH                    \(Constants.checkoutGrandtotal)\n")
            textData.append("------------------------------\n")
            result = printer!.addText(textData as String)
            if result != EPOS2_SUCCESS.rawValue {
                MessageView.showErrorEpos(result, method:"addText")
                return false
            }
            textData.setString("")
    
            // Section 4 : Advertisement
            textData.append("** Have a safe drive **\n")
            //  textData.append("Sign Up and Save !\n")
            textData.append("Garage.sa\n")
            result = printer!.addText(textData as String)
            if result != EPOS2_SUCCESS.rawValue {
                MessageView.showErrorEpos(result, method:"addText")
                return false;
            }
            textData.setString("")
    
            result = printer!.addFeedLine(2)
            if result != EPOS2_SUCCESS.rawValue {
                MessageView.showErrorEpos(result, method:"addFeedLine")
                return false
            }
    
            //        result = printer!.addBarcode("01209457",
            //                                     type:EPOS2_BARCODE_CODE39.rawValue,
            //                                     hri:EPOS2_HRI_BELOW.rawValue,
            //                                     font:EPOS2_FONT_A.rawValue,
            //                                     width:barcodeWidth,
            //                                     height:barcodeHeight)
            //        if result != EPOS2_SUCCESS.rawValue {
            //            MessageView.showErrorEpos(result, method:"addBarcode")
            //            return false
            //        }
            //
            result = printer!.addCut(EPOS2_CUT_FEED.rawValue)
            if result != EPOS2_SUCCESS.rawValue {
                MessageView.showErrorEpos(result, method:"addCut")
                return false
            }
    
            return true
        }
    
        func createCouponData() -> Bool {
            let barcodeWidth = 2
            let barcodeHeight = 64
    
            var result = EPOS2_SUCCESS.rawValue
    
            if printer == nil {
                return false
            }
    
            let coffeeData = UIImage(named: "coffee1.png")
            let wmarkData = UIImage(named: "wmark1.png")
    
            if coffeeData == nil || wmarkData == nil {
                return false
            }
    
            result = printer!.addPageBegin()
            if result != EPOS2_SUCCESS.rawValue {
                MessageView.showErrorEpos(result, method:"addPageBegin")
                return false
            }
    
            result = printer!.addPageArea(0, y:0, width:PAGE_AREA_WIDTH, height:PAGE_AREA_HEIGHT)
            if result != EPOS2_SUCCESS.rawValue {
                MessageView.showErrorEpos(result, method:"addPageArea")
                return false
            }
    
            result = printer!.addPageDirection(EPOS2_DIRECTION_TOP_TO_BOTTOM.rawValue)
            if result != EPOS2_SUCCESS.rawValue {
                MessageView.showErrorEpos(result, method:"addPageDirection")
                return false
            }
    
            result = printer!.addPagePosition(0, y:Int(coffeeData!.size.height))
            if result != EPOS2_SUCCESS.rawValue {
                MessageView.showErrorEpos(result, method:"addPagePosition")
                return false
            }
    
            result = printer!.add(coffeeData, x:0, y:0,
                                  width:Int(coffeeData!.size.width),
                                  height:Int(coffeeData!.size.height),
                                  color:EPOS2_PARAM_DEFAULT,
                                  mode:EPOS2_PARAM_DEFAULT,
                                  halftone:EPOS2_PARAM_DEFAULT,
                                  brightness:3,
                                  compress:EPOS2_PARAM_DEFAULT)
            if result != EPOS2_SUCCESS.rawValue {
                MessageView.showErrorEpos(result, method:"addImage")
                return false
            }
    
            result = printer!.addPagePosition(0, y:Int(wmarkData!.size.height))
            if result != EPOS2_SUCCESS.rawValue {
                MessageView.showErrorEpos(result, method:"addPagePosition")
                return false
            }
    
            result = printer!.add(wmarkData, x:0, y:0,
                                  width:Int(wmarkData!.size.width),
                                  height:Int(wmarkData!.size.height),
                                  color:EPOS2_PARAM_DEFAULT,
                                  mode:EPOS2_PARAM_DEFAULT,
                                  halftone:EPOS2_PARAM_DEFAULT,
                                  brightness:Double(EPOS2_PARAM_DEFAULT),
                                  compress:EPOS2_PARAM_DEFAULT)
    
            if result != EPOS2_SUCCESS.rawValue {
                MessageView.showErrorEpos(result, method:"addImage")
                return false
            }
    
            result = printer!.addPagePosition(FONT_A_WIDTH * 4, y:(PAGE_AREA_HEIGHT / 2) - (FONT_A_HEIGHT * 2))
            if result != EPOS2_SUCCESS.rawValue {
                MessageView.showErrorEpos(result, method:"addPagePosition")
                return false
            }
    
            result = printer!.addTextSize(3, height:3)
            if result != EPOS2_SUCCESS.rawValue {
                MessageView.showErrorEpos(result, method:"addTextSize")
                return false
            }
    
            result = printer!.addTextStyle(EPOS2_PARAM_DEFAULT, ul:EPOS2_PARAM_DEFAULT, em:EPOS2_TRUE, color:EPOS2_PARAM_DEFAULT)
            if result != EPOS2_SUCCESS.rawValue {
                MessageView.showErrorEpos(result, method:"addTextStyle")
                return false
            }
    
            result = printer!.addTextSmooth(EPOS2_TRUE)
            if result != EPOS2_SUCCESS.rawValue {
                MessageView.showErrorEpos(result, method:"addTextSmooth")
                return false
            }
    
            result = printer!.addText("FREE Coffee\n")
            if result != EPOS2_SUCCESS.rawValue {
                MessageView.showErrorEpos(result, method:"addText")
                return false
            }
    
            result = printer!.addPagePosition((PAGE_AREA_WIDTH / barcodeWidth) - BARCODE_WIDTH_POS, y:Int(coffeeData!.size.height) + BARCODE_HEIGHT_POS)
            if result != EPOS2_SUCCESS.rawValue {
                MessageView.showErrorEpos(result, method:"addPagePosition")
                return false
            }
    
            result = printer!.addBarcode("01234567890", type:EPOS2_BARCODE_UPC_A.rawValue, hri:EPOS2_PARAM_DEFAULT, font: EPOS2_PARAM_DEFAULT, width:barcodeWidth, height:barcodeHeight)
            if result != EPOS2_SUCCESS.rawValue {
                MessageView.showErrorEpos(result, method:"addBarcode")
                return false
            }
    
            result = printer!.addPageEnd()
            if result != EPOS2_SUCCESS.rawValue {
                MessageView.showErrorEpos(result, method:"addPageEnd")
                return false
            }
    
            result = printer!.addCut(EPOS2_CUT_FEED.rawValue)
            if result != EPOS2_SUCCESS.rawValue {
                MessageView.showErrorEpos(result, method:"addCut")
                return false
            }
    
            return true
        }
    
        func printData() -> Bool {
            var status: Epos2PrinterStatusInfo?
    
            if printer == nil {
                return false
            }
    
            if !connectPrinter() {
                return false
            }
    
            status = printer!.getStatus()
            // dispPrinterWarnings(status)
    
            if !isPrintable(status) {
                MessageView.show(makeErrorMessage(status))
                printer!.disconnect()
                return false
            }
    
            let result = printer!.sendData(Int(EPOS2_PARAM_DEFAULT))
            if result != EPOS2_SUCCESS.rawValue {
                MessageView.showErrorEpos(result, method:"sendData")
                printer!.disconnect()
                return false
            }
    
            return true
        }
    
        func initializePrinterObject() -> Bool {
            printer = Epos2Printer(printerSeries: valuePrinterSeries.rawValue, lang: valuePrinterModel.rawValue)
    
            if printer == nil {
                return false
            }
            printer!.setReceiveEventDelegate(self)
    
            return true
        }
    
        func finalizePrinterObject() {
            if printer == nil {
                return
            }
    
            printer!.clearCommandBuffer()
            printer!.setReceiveEventDelegate(nil)
            printer = nil
        }
    
    
    
        func connectPrinter() -> Bool {
            var result: Int32 = EPOS2_SUCCESS.rawValue
    
            if printer == nil {
                return false
            }
      print(Constants.Printer)
            result = printer!.connect(Constants.Printer, timeout:Int(EPOS2_PARAM_DEFAULT))
            if result != EPOS2_SUCCESS.rawValue {
                MessageView.showErrorEpos(result, method:"connect")
                return false
            }
    
            result = printer!.beginTransaction()
            if result != EPOS2_SUCCESS.rawValue {
                MessageView.showErrorEpos(result, method:"beginTransaction")
                printer!.disconnect()
                return false
    
            }
            return true
        }
    
        func disconnectPrinter() {
            var result: Int32 = EPOS2_SUCCESS.rawValue
    
            if printer == nil {
                return
            }
    
            result = printer!.endTransaction()
            if result != EPOS2_SUCCESS.rawValue {
                DispatchQueue.main.async(execute: {
                    MessageView.showErrorEpos(result, method:"endTransaction")
                })
            }
    
            result = printer!.disconnect()
            if result != EPOS2_SUCCESS.rawValue {
                DispatchQueue.main.async(execute: {
                    MessageView.showErrorEpos(result, method:"disconnect")
                })
            }
    
            finalizePrinterObject()
        }
        func isPrintable(_ status: Epos2PrinterStatusInfo?) -> Bool {
            if status == nil {
                return false
            }
    
            if status!.connection == EPOS2_FALSE {
                return false
            }
            else if status!.online == EPOS2_FALSE {
                return false
            }
            else {
                // print available
            }
            return true
        }
    
        func onPtrReceive(_ printerObj: Epos2Printer!, code: Int32, status: Epos2PrinterStatusInfo!, printJobId: String!) {
            MessageView.showResult(code, errMessage: makeErrorMessage(status))
    
            //dispPrinterWarnings(status)
            //    updateButtonState(true)
    
            DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async(execute: {
                self.disconnectPrinter()
            })
        }
    
        //    func dispPrinterWarnings(_ status: Epos2PrinterStatusInfo?) {
        //        if status == nil {
        //            return
        //        }
        //
        //        //        textWarnings.text = ""
        //
        //        if status!.paper == EPOS2_PAPER_NEAR_END.rawValue {
        //          //  textWarnings.text = NSLocalizedString("warn_receipt_near_end", comment:"")
        //        }
        //
        //        if status!.batteryLevel == EPOS2_BATTERY_LEVEL_1.rawValue {
        //         //   textWarnings.text = NSLocalizedString("warn_battery_near_end", comment:"")
        //        }
        //    }
    
        func makeErrorMessage(_ status: Epos2PrinterStatusInfo?) -> String {
            let errMsg = NSMutableString()
            if status == nil {
                return ""
            }
    
            if status!.online == EPOS2_FALSE {
                errMsg.append(NSLocalizedString("err_offline", comment:""))
            }
            if status!.connection == EPOS2_FALSE {
                errMsg.append(NSLocalizedString("err_no_response", comment:""))
            }
            if status!.coverOpen == EPOS2_TRUE {
                errMsg.append(NSLocalizedString("err_cover_open", comment:""))
            }
            if status!.paper == EPOS2_PAPER_EMPTY.rawValue {
                errMsg.append(NSLocalizedString("err_receipt_end", comment:""))
            }
            if status!.paperFeed == EPOS2_TRUE || status!.panelSwitch == EPOS2_SWITCH_ON.rawValue {
                errMsg.append(NSLocalizedString("err_paper_feed", comment:""))
            }
            if status!.errorStatus == EPOS2_MECHANICAL_ERR.rawValue || status!.errorStatus == EPOS2_AUTOCUTTER_ERR.rawValue {
                errMsg.append(NSLocalizedString("err_autocutter", comment:""))
                errMsg.append(NSLocalizedString("err_need_recover", comment:""))
            }
            if status!.errorStatus == EPOS2_UNRECOVER_ERR.rawValue {
                errMsg.append(NSLocalizedString("err_unrecover", comment:""))
            }
    
            if status!.errorStatus == EPOS2_AUTORECOVER_ERR.rawValue {
                if status!.autoRecoverError == EPOS2_HEAD_OVERHEAT.rawValue {
                    errMsg.append(NSLocalizedString("err_overheat", comment:""))
                    errMsg.append(NSLocalizedString("err_head", comment:""))
                }
                if status!.autoRecoverError == EPOS2_MOTOR_OVERHEAT.rawValue {
                    errMsg.append(NSLocalizedString("err_overheat", comment:""))
                    errMsg.append(NSLocalizedString("err_motor", comment:""))
                }
                if status!.autoRecoverError == EPOS2_BATTERY_OVERHEAT.rawValue {
                    errMsg.append(NSLocalizedString("err_overheat", comment:""))
                    errMsg.append(NSLocalizedString("err_battery", comment:""))
                }
                if status!.autoRecoverError == EPOS2_WRONG_PAPER.rawValue {
                    errMsg.append(NSLocalizedString("err_wrong_paper", comment:""))
                }
            }
            if status!.batteryLevel == EPOS2_BATTERY_LEVEL_0.rawValue {
                errMsg.append(NSLocalizedString("err_battery_real_end", comment:""))
            }
    
            return errMsg as String
        }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
