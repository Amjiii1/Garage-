////
////  SearchPrinterHelper.swift
////  Garage
////
////  Created by Amjad on 13/06/1440 AH.
////  Copyright © 1440 Amjad Ali. All rights reserved.
////
//
//import Foundation
//
//
//
//protocol SearchPrinterHelperDelegate {
//    func discoverdPrinters(printers: Set<PrinterDetailsModel>?)
//}
//
//class SearchPrinterHelper: NSObject {
//
//    var delegate: SearchPrinterHelperDelegate?
//
//    /// Variable for Epsion Printer
//    private var epsonPrinter: EpsonPrinterHelper?
//
//    /// Variable for Star Printer
//    //var starPrinter: StarPrinterHelperClass?
//
//    private var printerConnectionMedium: ConnectionMedium?
//    private var printers: Set<PrinterDetailsModel> = Set<PrinterDetailsModel>()
//
//    fileprivate var callbackCount = 0
//    final fileprivate var requiredCallbackCount = 1
//
//    private func configurePrinters() {
//        callbackCount = 0
//        epsonPrinter = EpsonPrinterHelper()
//        epsonPrinter?.delegate = self
//
//    }
//
//    // MARK:- Public Method
//
//    /// Starts seraching for printers on given medium
//    ///
//    /// - parameters:
//    ///   - medium: ConnectionMedium (An enum declared in ConstantValues.swift)
//    /// - returns: Void
//    func searchPrinter(on medium: ConnectionMedium) {
//        printerConnectionMedium = medium
//        switch medium {
//        case ConnectionMedium.localAreaNetwork:
//            Loader.startLoading()
//            configurePrinters()
//            epsonPrinter?.startSearchingOnLAN(completion: { (isSuccess, message) in
//                print(message)
//                Loader.stopLoading()
//            })
//            break
//        case ConnectionMedium.bluetooth:
//            Loader.startLoading()
//            configurePrinters()
//            epsonPrinter?.startSearchingOnBluetooth(completion: { (isSuccess, message) in
//                Loader.stopLoading()
//            })
//            break
//        }
//    }
//
//
//}
//
//extension SearchPrinterHelper: EpsonPrinterHelperDelegate {
//    func didDiscover(epsonPrinter target: Epos2DeviceInfo) {
//        let printerDetail = PrinterDetailsModel()
//        printerDetail.target = target.target
//        printerDetail.model = target.deviceName
//        printerDetail.ipAddress = target.ipAddress
//        printerDetail.macAddress = target.macAddress
//        printerDetail.manufacturer = PrinterManufacturer.epson
//        printers.insert(printerDetail)
//        callbackCount = callbackCount + 1
//        if callbackCount == requiredCallbackCount {
//            delegate?.discoverdPrinters(printers: printers)
//        }
//    }
//
//}
////
