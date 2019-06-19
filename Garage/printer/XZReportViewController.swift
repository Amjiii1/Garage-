//
//  XZReportViewController.swift
//  Garage
//
//  Created by Amjad on 25/07/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class XZReportViewController: UIViewController,Epos2PtrReceiveDelegate, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var xReportOutlet: UIButton!
    
    @IBOutlet weak var zReportOutlet: UIButton!
    
    
    
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
    let dateFormatter : DateFormatter = DateFormatter()
    var XReport = [XReportModel]()
    
    var Status = 0
    var dates: String = ""
    var report: String = ""
    var flag: Int32 = 12
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.popoverPresentationController?.backgroundColor = UIColor.white
        Constants.Printer = UserDefaults.standard.string(forKey: "printer") ?? ""
        // Do any additional setup after loading the view.
        
    }
    
    
    @IBAction func XreportBtn(_ sender: Any) {
        //        connectPrinter()
        //        if flag == 2 {
        //           alert(view: self, title: "Printer has something wrong! not connected", message: "Do you want to Continue")
        //        } else {
        if Constants.Printer != "" {
            
            Status = 1
            Xreportdata()
            Status = 0
        } else {
            UIUtility.showAlertInController(title: "Alert", message: "Printer is not Connected", viewController: self)
        }
    }
    //   }
    
    
    @IBAction func ZreportBtn(_ sender: Any) {
        //        if !connectPrinter() {
        //            alert(view: self, title: "Printer has something wrong! not connected", message: "Do you want to Continue")
        //        } else {
        
        if Constants.Printer != "" {
            
            if Status == 1 {
                print("X-Report")
            } else if Status == 0 {
                Xreportdata()
            }
        } else {
            UIUtility.showAlertInController(title: "Alert", message: "Printer is not Connected", viewController: self)
        }
        
        //        }
        
    }
    
    func alert(view: XZReportViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Yes", style: .default, handler: { action in
            self.Status = 1
            self.Xreportdata()
            self.Status = 0
            
            //            if self.Status == 1 {
            //                print("X-Report")
            //            } else if self.Status == 0 {
            //                self.Xreportdata()
            //            }
            
        })
        
        alert.addAction(defaultAction)
        let cancel = UIAlertAction(title: "No", style: .destructive, handler: { action in
            
        })
        alert.addAction(cancel)
        DispatchQueue.main.async(execute: {
            view.present(alert, animated: true)
        })
    }
    
    //    func setupsettingsq(){
    //        let screenSize = UIScreen.main.bounds.width
    //        let screenheight = UIScreen.main.bounds.size.height
    //        print(screenheight)
    //        var storyboard: UIStoryboard!
    //        var popController: UIViewController!
    //        storyboard = UIStoryboard(name: "SettingsViewController", bundle: nil)
    //        popController = storyboard.instantiateViewController(withIdentifier: "SettingViewControllerVc") as! SettingsViewController
    //        popController.modalPresentationStyle = .popover
    //        let popOverVC = popController.popoverPresentationController
    //        popOverVC?.delegate = self
    //        popOverVC?.sourceView = self.view
    //        popOverVC?.permittedArrowDirections = UIPopoverArrowDirection(rawValue:0)
    //        popOverVC?.sourceRect = CGRect(x: screenSize, y: screenheight*0.80, width: 0, height: 0)
    //        popController.preferredContentSize = CGSize(width: screenSize, height: screenheight*0.80)
    //        self.present(popController, animated: true)
    //
    //   }
    
    
    private func Xreportdata() {
        var url: String = ""
        
        if Status == 1 {
            url = "\(CallEngine.baseURL)\(CallEngine.xReport)\(Constants.sessions)"
            report = "xreport"
            
        }
        else if Status == 0 {
            url = "\(CallEngine.baseURL)\(CallEngine.zReport)\(Constants.sessions)"
            report = "zreport"
        }
        xReportOutlet.isUserInteractionEnabled = false
        zReportOutlet.isUserInteractionEnabled = false
        Alamofire.request(url).response { [weak self] (response) in
            if response == nil {
                DispatchQueue.main.async {
                    UIUtility.showAlertInController(title: "Alert", message: Constants.interneterror, viewController: self!)
                    self!.xReportOutlet.isUserInteractionEnabled = true
                    self!.zReportOutlet.isUserInteractionEnabled = true
                }
            }
            guard self != nil else { return }
            if let error = response.error {
                UIUtility.showAlertInController(title: "Alert", message: Constants.interneterror, viewController: self!)
            } else {
                do {
                    let json = try JSON(data: response.data!)
                    print("🌎 Response : ", json)
                    let status = json[Constants.Status].intValue
                    let desc = json[Constants.Description].stringValue
                    
                    if (status == 1) {
                        print(self!.Status)
                        let reports = json[self!.report].arrayValue
                        
                        for xreports in reports {
                            let totalSales = xreports[Constants.TotalSales].floatValue
                            let minusDiscount = xreports[Constants.MinusDiscount].floatValue
                            let minusVoid = xreports[Constants.MinusVoid].floatValue
                            let minusComplimentory = xreports[Constants.MinusComplimentory].floatValue
                            let minusReturn = xreports[Constants.MinusReturn].floatValue
                            let minusTax = xreports[Constants.MinusTax].floatValue
                            let netSales = xreports[Constants.NetSales].floatValue
                            let plusGratuity = xreports[Constants.PlusGratuity].floatValue
                            let plusCharges = xreports[Constants.PlusCharges].floatValue
                            let totalTendered = xreports[Constants.TotalTendered].floatValue
                            let cash = xreports[Constants.Cash].floatValue
                            let card = xreports[Constants.Card].floatValue
                            let loyality = xreports[Constants.Loyality].floatValue
                            let giftCard = xreports[Constants.GiftCard].floatValue
                            let coupons = xreports[Constants.Coupons].floatValue
                            let totalTransactionType = xreports[Constants.TotalTransactionType].floatValue
                            let totalCashOrders = xreports[Constants.TotalCashOrders].intValue
                            let totalCardOrders = xreports[Constants.TotalCardOrders].intValue
                            let totatMultiPaymentOrders = xreports[Constants.TotatMultiPaymentOrders].intValue
                            let totalVoidOrders = xreports[Constants.TotalVoidOrders].intValue
                            let totalReturnOrders = xreports[Constants.TotalReturnOrders].intValue
                            let totalOrders = xreports[Constants.TotalOrders].intValue
                            let date = xreports[Constants.Date].stringValue
                            let newxreports = XReportModel(TotalSales: totalSales, MinusDiscount: minusDiscount, MinusVoid: minusVoid, MinusComplimentory: minusComplimentory, MinusReturn: minusReturn, MinusTax: minusTax, NetSales: netSales, PlusGratuity: plusGratuity, PlusCharges: plusCharges, TotalTendered: totalTendered, Cash: cash, Card: card, Loyality: loyality, GiftCard: giftCard, Coupons: coupons,TotalTransactionType: totalTransactionType, TotalCashOrders: totalCashOrders, TotalCardOrders: totalCardOrders, TotatMultiPaymentOrders: totatMultiPaymentOrders, TotalVoidOrders: totalVoidOrders, TotalReturnOrders: totalReturnOrders, TotalOrders: totalOrders, date: date)
                            self?.XReport.append(newxreports)
                            //                            DispatchQueue.main.async {
                            //                                self?.colectionview.reloadData()
                            //                            }
                        }
                        self!.runPrinterReceiptSequence()
                        self!.xReportOutlet.isUserInteractionEnabled = true
                        self!.zReportOutlet.isUserInteractionEnabled = true
                        self!.dismiss(animated: true, completion: nil)
                    }
                    else  if (status == 0) {
                        UIUtility.showAlertInController(title: "Alert", message: desc, viewController: self!)
                        self!.xReportOutlet.isUserInteractionEnabled = true
                        self!.zReportOutlet.isUserInteractionEnabled = true
                    }
                        
                    else  if (status == 1000) {
                        UIUtility.showAlertInController(title: "Alert", message: Constants.wrong, viewController: self!)
                        self!.xReportOutlet.isUserInteractionEnabled = true
                        self!.zReportOutlet.isUserInteractionEnabled = true
                    }
                        
                    else  if (status == 1001) {
                        ToastView.show(message: Constants.invalid, controller: self!)
                        UIUtility.showAlertInController(title: "Alert", message: Constants.invalid, viewController: self!)
                        self!.xReportOutlet.isUserInteractionEnabled = true
                        self!.zReportOutlet.isUserInteractionEnabled = true
                    }
                        
                    else {
                        UIUtility.showAlertInController(title: "Alert", message: desc, viewController: self!)
                        self!.xReportOutlet.isUserInteractionEnabled = true
                        self!.zReportOutlet.isUserInteractionEnabled = true
                    }
                    
                    
                    
                } catch {
                    debugPrint("🔥 Network Error : ", error)
                    UIUtility.showAlertInController(title: "Alert", message: "Network Error", viewController: self!)
                    self!.xReportOutlet.isUserInteractionEnabled = true
                    self!.zReportOutlet.isUserInteractionEnabled = true
                    
                }
            }
        }
    }
    
    
    func runPrinterReceiptSequenceEx() -> Bool {
        
        if !printData() {
            finalizePrinterObject()
            return false
        }
        return true
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
        
        
        if !printData() {
            finalizePrinterObject()
            return false
        }
        
        return true
    }
    
    func createReceiptData() -> Bool {
        for data in XReport {
            
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
            
            result = printer!.addTextAlign(EPOS2_ALIGN_CENTER.rawValue)
            if result != EPOS2_SUCCESS.rawValue {
                MessageView.showErrorEpos(result, method:"addTextAlign")
                return false;
            }
            textData.append("\n")
            textData.append(report.uppercased())
            textData.append("\n")
            textData.append(Constants.LocationName)
            textData.append("\n\n")
            textData.append("--------------------------------------------\n")
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let date = Date()
            let dateString = dateFormatter.string(from: date)
            textData.append("User: \(Constants.FirstName)        Date: \(data.date!)\n\n")
            textData.append("Print Date: \(dateString)\n")
            //   textData.append("00km                       \(Constants.checkoutyear)\n")
            
            textData.append("--------------------------------------------\n\n")
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
            //            result = printer!.addTextSize(2, height:1)
            //            if result != EPOS2_SUCCESS.rawValue {
            //                MessageView.showErrorEpos(result, method:"addTextSize")
            //                return false
            //            }
            
            
            
            print(data.TotalSales)
            textData.append("TotalSales                         \(data.TotalSales!.myRrounded(toPlaces: 2))\n")
            textData.append("MinusDiscount                       \(data.MinusDiscount!.myRrounded(toPlaces: 2))\n")
            textData.append("MinusVoid                           \(data.MinusVoid!.myRrounded(toPlaces: 2))\n")
            textData.append("MinusComplimentory                  \(data.MinusComplimentory!.myRrounded(toPlaces: 2))\n")
            textData.append("MinusReturn                         \(data.MinusReturn!.myRrounded(toPlaces: 2))\n")
            textData.append("MinusTax                           \(data.MinusTax!.myRrounded(toPlaces: 2))\n")
            textData.append("--------------------------------------------\n")
            textData.append("NetSales                          \(data.NetSales!.myRrounded(toPlaces: 2))\n")
            textData.append("PlusGratuity                        \(data.PlusGratuity!.myRrounded(toPlaces: 2))\n")
            textData.append("PlusCharges                         \(data.PlusCharges!.myRrounded(toPlaces: 2))\n")
            textData.append("--------------------------------------------\n")
            textData.append("TotalTendered                      \(data.TotalTendered!.myRrounded(toPlaces: 2))\n")
            textData.append("Cash                               \(data.Cash!.myRrounded(toPlaces: 2))\n")
            textData.append("Card                                \(data.Card!.myRrounded(toPlaces: 2))\n")
            textData.append("Loyality                            \(data.Loyality!.myRrounded(toPlaces: 2))\n")
            textData.append("GiftCard                            \(data.GiftCard!.myRrounded(toPlaces: 2))\n")
            textData.append("Coupons                             \(data.Coupons!.myRrounded(toPlaces: 2))\n")
            textData.append("--------------------------------------------\n")
            textData.append("TotalTransactionType              \(data.TotalTransactionType!.myRrounded(toPlaces: 2))\n")
            textData.append("--------------------------------------------\n")
            textData.append("TotalCashOrders                     \(data.TotalCashOrders!)\n")
            textData.append("TotalCardOrders                     \(data.TotalCardOrders!)\n")
            textData.append("TotatMultiPaymentOrders             \(data.TotatMultiPaymentOrders!)\n")
            textData.append("TotalVoidOrders                     \(data.TotalVoidOrders!)\n")
            textData.append("TotalReturnOrders                   \(data.TotalReturnOrders!)\n")
            textData.append("--------------------------------------------\n")
            textData.append("TotalOrders                         \(data.TotalOrders!)\n")
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
            
            //}
            textData.append("--------------------------------------------\n")
            result = printer!.addText(textData as String)
            if result != EPOS2_SUCCESS.rawValue {
                MessageView.showErrorEpos(result, method:"addText")
                return false;
            }
            textData.setString("")
            
            
            
            // Section 4 : Advertisement
            textData.append(Constants.Footer)
            textData.append("\n")
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
            
            //  return true
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
            flag = result
            return false
        }
        
        
        result = printer!.beginTransaction()
        if result != EPOS2_SUCCESS.rawValue {
            // MessageView.showErrorEpos(result, method:"beginTransaction")
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
            print("UnAvailable")
        }
        
        if status!.connection == EPOS2_FALSE {
            return false
            print("UnAvailable")
        }
        else if status!.online == EPOS2_FALSE {
            print("UnAvailable")
            return false
        }
        else {
            // print available
            print("Available")
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
