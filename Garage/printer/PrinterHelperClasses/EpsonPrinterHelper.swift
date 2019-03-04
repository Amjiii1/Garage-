////
////  EpsonPrinterHelper.swift
////  Garage
////
////  Created by Amjad on 13/06/1440 AH.
////  Copyright © 1440 Amjad Ali. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//
//@objc
//protocol EpsonPrinterHelperDelegate {
//    func didDiscover(epsonPrinter target: Epos2DeviceInfo)
//}
//
///// This class is responsible for detecting Epson Printer (on Bluetooth or LAN) and Printing Receipts
//class EpsonPrinterHelper: NSObject {
//
//    // Instance Variables
//
//    private var printerList: [Epos2DeviceInfo] = []
//    private var filterOption: Epos2FilterOption = Epos2FilterOption()
//
//    private var printer: Epos2Printer?
//    private var epos2ErrorStatus: Epos2ErrorStatus.RawValue!
//
//    private var printerModelLanguage: Epos2ModelLang = EPOS2_MODEL_ANK
//    private var printerPaperWidth: CGFloat = ConstantValues.smallPrinter
//
//    private var printerDetailsModel = PrinterDetailsModel()
//
//    var delegate: EpsonPrinterHelperDelegate?
//    private weak var printerContextDelegate: PrinterContextDelegate?
//
//    // MARK:- Methods related to printer discovery
//
//    /// Starts seraching for printers
//    ///
//    /// - Parameters:
//    ///   - completion: @escaping (Bool, String) -> ()
//    /// - Returns: Void
//    private func startDiscovering(completion: @escaping (Bool, String) -> ()) {
//        Epos2Discovery.stop()
//        filterOption.deviceType = EPOS2_TYPE_PRINTER.rawValue
//        epos2ErrorStatus = Epos2Discovery.start(filterOption, delegate: self)
//        if epos2ErrorStatus != EPOS2_ERR_PROCESSING.rawValue {
//            if epos2ErrorStatus == EPOS2_SUCCESS.rawValue {
//                completion(true, self.getEposErrorText(epos2ErrorStatus))
//            } else {
//                completion(false, self.getEposErrorText(epos2ErrorStatus))
//            }
//        }
//    }
//
//    /// Stops seraching for printers
//    ///
//    /// - Parameters:
//    ///   - completion: @escaping (Bool, String) -> ()
//    /// - Returns: Void
//    private func stopDiscovering(completion: @escaping (Bool, String) -> ()) {
//        while true {
//            epos2ErrorStatus = Epos2Discovery.stop()
//            if epos2ErrorStatus != EPOS2_ERR_PROCESSING.rawValue {
//                if epos2ErrorStatus == EPOS2_SUCCESS.rawValue {
//                    completion(true, self.getEposErrorText(epos2ErrorStatus))
//                } else {
//                    completion(false, self.getEposErrorText(epos2ErrorStatus))
//                }
//                break
//            }
//        }
//    }
//
//    // MARK:- Methods related to Printer Initialization and Deinitialization
//
//    /// Initializes and sets setReceiveEventDelegate delegate
//    /// - Parameters:
//    ///     - modelName: String?
//    /// - Returns: Bool (true for successfully initialization)
//    private func initializePrinterObject(modelName: String) -> Bool {
//        if let printerSeries = getPrinterSeries(printerSeriesName: modelName) {
//            printer = Epos2Printer(printerSeries: printerSeries.rawValue, lang: printerModelLanguage.rawValue)
//            if printer == nil {
//                return false
//            }
//            printer!.setReceiveEventDelegate(self)
//        }
//        return true
//    }
//
//    /// Deinitializes printer's object, removes setReceiveEventDelegate and clear command buffer
//    /// - Returns: Void
//    private func deinitializePrinterObject() {
//        if printer == nil {
//            return
//        }
//        printer!.clearCommandBuffer()
//        printer!.setReceiveEventDelegate(nil)
//        printer = nil
//    }
//
//    // MARK:- Methods related to Printer Series and Printablility
//
//    /// Returns the Epos2Printer Series
//    /// - Parameters:
//    ///     - printerSeries: String?
//    /// - Returns: Epos2PrinterSeries?
//    private func getPrinterSeries(printerSeriesName printerSeries: String)-> Epos2PrinterSeries? {
//        if printerSeries.contains("m30") || printerSeries.contains("M30") {
//            printerPaperWidth = ConstantValues.mediumPrinter
//            return EPOS2_TM_M30
//        } else if printerSeries.contains("p20") || printerSeries.contains("P20") {
//            printerPaperWidth = ConstantValues.smallPrinter
//            return EPOS2_TM_P20
//        }
//        return EPOS2_TM_M10
//    }
//
//    /// Checks on behalf of Epos2PrinterStatusInfo if it is printable
//    /// - Parameters:
//    ///     - status: Epos2PrinterStatusInfo?
//    /// - Returns: Bool (true if printable)
//    private func isPrintable(_ status: Epos2PrinterStatusInfo?) -> Bool {
//        if status == nil {
//            return false
//        }
//        if status!.connection == EPOS2_FALSE || status!.online == EPOS2_FALSE {
//            return false
//        } else {
//            return true
//        }
//    }
//
//    // MARK:- Methods related to Receipt Creation and Printing
//
//    /// Calls methods of Printer Initialization and printing receipt and kicks drawer
//    /// - Parameters:
//    ///     - printerDetailsModel: PrinterDetailsModel
//    ///     - imageToPrint: UIImage
//    ///     - isKickDrawer: Bool
//    /// - Returns: @escaping (Bool, String) -> ()
//    private func runPrinterReceiptSequence(printerDetailsModel: PrinterDetailsModel, imageToPrint: UIImage, isKickDrawer: Bool, completion: @escaping (Bool, String) -> ()) {
//
//        // Printer initialization
//
//        if !initializePrinterObject(modelName: printerDetailsModel.model) {
//            completion(false, "Error Occured during printer initialization")
//            return
//        }
//
//        // Receipt Creation
//
//        createReceipt(imageToPrint: imageToPrint, isKickDrawer: isKickDrawer) { (isSuccess, message) in
//            if !isSuccess {
//                self.deinitializePrinterObject()
//                completion(isSuccess, message)
//                return
//            }
//        }
//
//        // Receipt printing
//
//        printReceiptImage(completion: { (isSuccess, message) in
//            if !isSuccess {
//                self.deinitializePrinterObject()
//            }
//            completion(isSuccess, message)
//            return
//        })
//    }
//
//    /// Prints receipt
//    ///
//    /// - Returns: @escaping (Bool, String) -> ()
//    private func printReceiptImage(completion: @escaping (Bool, String) -> ()) {
//        var status: Epos2PrinterStatusInfo?
//        if printer == nil {
//            completion(false, "Printer object is nil")
//            return
//        }
//        connectPrinter { (isSuccess, message) in
//            if !isSuccess {
//                completion(isSuccess, message)
//                return
//            }
//        }
//        if let printer = printer {
//            status = printer.getStatus()
//            print("WARNINGS: \(getPrinterWarning(by: status))")
//            if isPrintable(status) == false {
//                printer.disconnect()
//                completion(false, makeErrorMessage(status))
//                return
//            }
//            let result = printer.sendData(Int(EPOS2_PARAM_DEFAULT))
//            if result != EPOS2_SUCCESS.rawValue {
//                completion(false, getErrorResultText(by: result))
//                return
//            }
//            completion(true, "Data Printed Successfully")
//        } else {
//            completion(false, "printer object is nil")
//        }
//    }
//
//    /// Creates receipt for printing and kicks drawer (at printing)
//    /// - Parameters:
//    ///     - imageToPrint: UIImage
//    ///     - isKickDrawer: Bool
//    /// - Returns: @escaping (Bool, String) -> ()
//    private func createReceipt(imageToPrint: UIImage, isKickDrawer: Bool, completion: @escaping (Bool, String) -> ()) {
//        var result = EPOS2_SUCCESS.rawValue
//        result = printer!.addTextAlign(EPOS2_ALIGN_CENTER.rawValue)
//        if result != EPOS2_SUCCESS.rawValue {
//            completion(false, getErrorResultText(by: result))
//            return
//        }
//        result = printer!.add(imageToPrint, x: 0, y:0,
//                              width:Int(imageToPrint.size.width),
//                              height:Int(imageToPrint.size.height),
//                              color:EPOS2_COLOR_1.rawValue,
//                              mode:EPOS2_MODE_MONO.rawValue,
//                              halftone:EPOS2_HALFTONE_DITHER.rawValue,
//                              brightness:Double(EPOS2_PARAM_DEFAULT),
//                              compress:EPOS2_COMPRESS_AUTO.rawValue)
//        if result != EPOS2_SUCCESS.rawValue {
//            completion(false, getErrorResultText(by: result))
//            return
//        }
//
//        result = printer!.addFeedLine(1)
//        if result != EPOS2_SUCCESS.rawValue {
//            completion(false, getErrorResultText(by: result))
//            return
//        }
//
//        result = printer!.addCut(EPOS2_CUT_FEED.rawValue)
//        if result != EPOS2_SUCCESS.rawValue {
//            completion(false, getErrorResultText(by: result))
//            return
//        }
//
//        if isKickDrawer {
//            self.printer?.addPulse(EPOS2_DRAWER_2PIN.rawValue, time: EPOS2_PULSE_100.rawValue)
//        }
//        return completion(true, "Receipt Created Successfully")
//    }
//
//    // MARK:- Methods related to Printer Connection
//
//    /// Connects printer
//    /// - Parameters:
//    ///     - completion
//    ///         - Bool: Flag
//    ///         - String: Message
//    /// - Returns: Void
//    func connectPrinter(completion: (Bool, String) -> ()){
//        var result: Int32 = EPOS2_SUCCESS.rawValue
//        if printer == nil {
//            completion(false, "Printer object is nil")
//            return
//        }
//        result = printer!.connect(printerDetailsModel.target, timeout: Int(EPOS2_PARAM_DEFAULT))
//        if result != EPOS2_SUCCESS.rawValue {
//            completion(false, self.getEposErrorText(result))
//            return
//        }
//
//        result = printer!.beginTransaction()
//        if result != EPOS2_SUCCESS.rawValue {
//            printer!.disconnect()
//            completion(false, self.getEposErrorText(result))
//            return
//        }
//        return completion(true, "Printer Connected Successfully")
//    }
//
//    /// Disconnects printer
//    /// - Returns: Void
//    private func disconnectPrinter() {
//        var result: Int32 = EPOS2_SUCCESS.rawValue
//
//        if printer == nil {
//            return
//        }
//        result = printer!.endTransaction()
//        if result != EPOS2_SUCCESS.rawValue {
//            print(getEposErrorText(result))
//            return
//        }
//        result = printer!.disconnect()
//        if result != EPOS2_SUCCESS.rawValue {
//            print(getEposErrorText(result))
//            return
//        }
//        deinitializePrinterObject()
//    }
//}
//
//
//// MARK:- Implementing Epos2DiscoveryDelegate methods
//extension EpsonPrinterHelper: Epos2DiscoveryDelegate {
//    func onDiscovery(_ deviceInfo: Epos2DeviceInfo!) {
//        print(deviceInfo)
//        printerList.append(deviceInfo)
//        delegate?.didDiscover(epsonPrinter: deviceInfo)
//    }
//}
//
//// MARK:- Implementing Epos2PtrReceiveDelegate methods
//extension EpsonPrinterHelper: Epos2PtrReceiveDelegate {
//    func onPtrReceive(_ printerObj: Epos2Printer!, code: Int32, status: Epos2PrinterStatusInfo!, printJobId: String!) {
//        print(printerObj)
//        print(code)
//        print(status)
//        print(printJobId)
//
//        let _ = getPrinterWarning(by: status)
//
//        self.printer?.clearCommandBuffer()
//        self.printer?.setReceiveEventDelegate(nil)
//        self.printer!.endTransaction()
//
//        //        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async(execute: {
//        //
//        //        })
//        self.printerContextDelegate?.didPrint()
//        self.printerContextDelegate = nil
//    }
//}
//
//
//// MARK:- Implementing Discoverable methods
//extension EpsonPrinterHelper: Discoverable {
//    func startSearchingOnLAN(completion: @escaping (Bool, String) -> ()) {
//        startDiscovering { (isSuccess, message) in
//            completion(isSuccess, message)
//        }
//    }
//
//    func startSearchingOnBluetooth(completion: @escaping (Bool, String) -> ()) {
//        startDiscovering { (isSuccess, message) in
//            completion(isSuccess, message)
//        }
//    }
//
//    func stopSearching(completion: @escaping (Bool, String) -> ()) {
//        stopDiscovering { (isSuccess, message) in
//            completion(isSuccess, message)
//        }
//    }
//}
//
//// MARK:- Implementing Printable methods
//extension EpsonPrinterHelper: Printable {
//
//    func printReceipt(printerDetailsModel: PrinterDetailsModel, imageToPrint: UIImage, isKickDrawer: Bool, printerContextDelegate: PrinterContextDelegate, completion: @escaping (Bool, String) -> ()) {
//        self.printerDetailsModel = printerDetailsModel
//        self.printerContextDelegate = printerContextDelegate
//        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async(execute: {
//            self.runPrinterReceiptSequence(printerDetailsModel: printerDetailsModel, imageToPrint: imageToPrint, isKickDrawer: isKickDrawer) { (isSuccess, message) in
//                completion(isSuccess, message)
//            }
//        })
//
//    }
//}
//
//extension EpsonPrinterHelper {
//
//    private func getPrinterWarning(by status: Epos2PrinterStatusInfo?)-> String {
//        if status == nil {
//            return ""
//        }
//
//        if status!.paper == EPOS2_PAPER_NEAR_END.rawValue {
//            return NSLocalizedString("warn_receipt_near_end", comment:"")
//        }
//
//        if status!.batteryLevel == EPOS2_BATTERY_LEVEL_1.rawValue {
//            return NSLocalizedString("warn_battery_near_end", comment:"")
//        }
//        return ""
//    }
//
//    private func getEposErrorText(_ error: Int32) -> String {
//        var errText = ""
//        switch (error) {
//        case EPOS2_SUCCESS.rawValue:
//            errText = "SUCCESS"
//            break
//        case EPOS2_ERR_PARAM.rawValue:
//            errText = "ERR_PARAM"
//            break
//        case EPOS2_ERR_CONNECT.rawValue:
//            errText = "Unable to connect to printer" //"ERR_CONNECT"
//            break
//        case EPOS2_ERR_TIMEOUT.rawValue:
//            errText = "ERR_TIMEOUT"
//            break
//        case EPOS2_ERR_MEMORY.rawValue:
//            errText = "ERR_MEMORY"
//            break
//        case EPOS2_ERR_ILLEGAL.rawValue:
//            errText = "ERR_ILLEGAL"
//            break
//        case EPOS2_ERR_PROCESSING.rawValue:
//            errText = "ERR_PROCESSING"
//            break
//        case EPOS2_ERR_NOT_FOUND.rawValue:
//            errText = "ERR_NOT_FOUND"
//            break
//        case EPOS2_ERR_IN_USE.rawValue:
//            errText = "ERR_IN_USE"
//            break
//        case EPOS2_ERR_TYPE_INVALID.rawValue:
//            errText = "ERR_TYPE_INVALID"
//            break
//        case EPOS2_ERR_DISCONNECT.rawValue:
//            errText = "ERR_DISCONNECT"
//            break
//        case EPOS2_ERR_ALREADY_OPENED.rawValue:
//            errText = "ERR_ALREADY_OPENED"
//            break
//        case EPOS2_ERR_ALREADY_USED.rawValue:
//            errText = "ERR_ALREADY_USED"
//            break
//        case EPOS2_ERR_BOX_COUNT_OVER.rawValue:
//            errText = "ERR_BOX_COUNT_OVER"
//            break
//        case EPOS2_ERR_BOX_CLIENT_OVER.rawValue:
//            errText = "ERR_BOXT_CLIENT_OVER"
//            break
//        case EPOS2_ERR_UNSUPPORTED.rawValue:
//            errText = "ERR_UNSUPPORTED"
//            break
//        case EPOS2_ERR_FAILURE.rawValue:
//            errText = "ERR_FAILURE"
//            break
//        default:
//            errText = String(format:"%d", error)
//            break
//        }
//        return errText
//    }
//
//    private func getEposBtErrorText(_ error: Int32) -> String {
//        var errText = ""
//        switch (error) {
//        case EPOS2_BT_SUCCESS.rawValue:
//            errText = "SUCCESS"
//            break
//        case EPOS2_BT_ERR_PARAM.rawValue:
//            errText = "ERR_PARAM"
//            break
//        case EPOS2_BT_ERR_UNSUPPORTED.rawValue:
//            errText = "ERR_UNSUPPORTED"
//            break
//        case EPOS2_BT_ERR_CANCEL.rawValue:
//            errText = "ERR_CANCEL"
//            break
//        case EPOS2_BT_ERR_ALREADY_CONNECT.rawValue:
//            errText = "ERR_ALREADY_CONNECT"
//            break;
//        case EPOS2_BT_ERR_ILLEGAL_DEVICE.rawValue:
//            errText = "ERR_ILLEGAL_DEVICE"
//            break
//        case EPOS2_BT_ERR_FAILURE.rawValue:
//            errText = "ERR_FAILURE"
//            break
//        default:
//            errText = String(format:"%d", error)
//            break
//        }
//        return errText
//    }
//
//    private func getErrorResultText(by resultCode: Int32) -> String {
//        var result = ""
//        switch (resultCode) {
//        case EPOS2_CODE_SUCCESS.rawValue:
//            result = "PRINT_SUCCESS"
//            break
//        case EPOS2_CODE_PRINTING.rawValue:
//            result = "PRINTING"
//            break
//        case EPOS2_CODE_ERR_AUTORECOVER.rawValue:
//            result = "ERR_AUTORECOVER"
//            break
//        case EPOS2_CODE_ERR_COVER_OPEN.rawValue:
//            result = "ERR_COVER_OPEN"
//            break
//        case EPOS2_CODE_ERR_CUTTER.rawValue:
//            result = "ERR_CUTTER"
//            break
//        case EPOS2_CODE_ERR_MECHANICAL.rawValue:
//            result = "ERR_MECHANICAL"
//            break
//        case EPOS2_CODE_ERR_EMPTY.rawValue:
//            result = "ERR_EMPTY"
//            break
//        case EPOS2_CODE_ERR_UNRECOVERABLE.rawValue:
//            result = "ERR_UNRECOVERABLE"
//            break
//        case EPOS2_CODE_ERR_FAILURE.rawValue:
//            result = "ERR_FAILURE"
//            break
//        case EPOS2_CODE_ERR_NOT_FOUND.rawValue:
//            result = "ERR_NOT_FOUND"
//            break
//        case EPOS2_CODE_ERR_SYSTEM.rawValue:
//            result = "ERR_SYSTEM"
//            break
//        case EPOS2_CODE_ERR_PORT.rawValue:
//            result = "ERR_PORT"
//            break
//        case EPOS2_CODE_ERR_TIMEOUT.rawValue:
//            result = "ERR_TIMEOUT"
//            break
//        case EPOS2_CODE_ERR_JOB_NOT_FOUND.rawValue:
//            result = "ERR_JOB_NOT_FOUND"
//            break
//        case EPOS2_CODE_ERR_SPOOLER.rawValue:
//            result = "ERR_SPOOLER"
//            break
//        case EPOS2_CODE_ERR_BATTERY_LOW.rawValue:
//            result = "ERR_BATTERY_LOW"
//            break
//        case EPOS2_CODE_ERR_TOO_MANY_REQUESTS.rawValue:
//            result = "ERR_TOO_MANY_REQUESTS"
//            break
//        case EPOS2_CODE_ERR_REQUEST_ENTITY_TOO_LARGE.rawValue:
//            result = "ERR_REQUEST_ENTITY_TOO_LARGE"
//            break
//        default:
//            result = String(format:"%d", resultCode)
//            break
//        }
//        return result
//    }
//
//    func makeErrorMessage(_ status: Epos2PrinterStatusInfo?) -> String {
//        let errMsg = NSMutableString()
//        if status == nil {
//            return ""
//        }
//        if status!.online == EPOS2_FALSE {
//            errMsg.append("Printer is offline beacuse ")
//        }
//        if status!.connection == EPOS2_FALSE {
//            errMsg.append("Printer is not responding")
//        }
//        if status!.coverOpen == EPOS2_TRUE {
//            errMsg.append("Cover is open")
//        }
//        if status!.paper == EPOS2_PAPER_EMPTY.rawValue {
//            errMsg.append("Receipt paper ended")
//        }
//        if status!.paperFeed == EPOS2_TRUE || status!.panelSwitch == EPOS2_SWITCH_ON.rawValue {
//            errMsg.append(NSLocalizedString("err_paper_feed", comment:""))
//        }
//        if status!.errorStatus == EPOS2_MECHANICAL_ERR.rawValue || status!.errorStatus == EPOS2_AUTOCUTTER_ERR.rawValue {
//            errMsg.append("Cutter is not working")
//            //errMsg.append(NSLocalizedString("err_need_recover", comment:""))
//        }
//        if status!.errorStatus == EPOS2_UNRECOVER_ERR.rawValue {
//            errMsg.append(NSLocalizedString("err_unrecover", comment:""))
//        }
//
//        if status!.errorStatus == EPOS2_AUTORECOVER_ERR.rawValue {
//            if status!.autoRecoverError == EPOS2_HEAD_OVERHEAT.rawValue {
//                errMsg.append(NSLocalizedString("err_overheat", comment:""))
//                errMsg.append(NSLocalizedString("err_head", comment:""))
//            }
//            if status!.autoRecoverError == EPOS2_MOTOR_OVERHEAT.rawValue {
//                errMsg.append(NSLocalizedString("err_overheat", comment:""))
//                errMsg.append(NSLocalizedString("err_motor", comment:""))
//            }
//            if status!.autoRecoverError == EPOS2_BATTERY_OVERHEAT.rawValue {
//                errMsg.append(NSLocalizedString("err_overheat", comment:""))
//                errMsg.append(NSLocalizedString("err_battery", comment:""))
//            }
//            if status!.autoRecoverError == EPOS2_WRONG_PAPER.rawValue {
//                errMsg.append("Paper roll not inserted properly")
//            }
//        }
//        if status!.batteryLevel == EPOS2_BATTERY_LEVEL_0.rawValue {
//            errMsg.append(NSLocalizedString("err_battery_real_end", comment:""))
//        }
//        return errMsg as String
//    }
//}
