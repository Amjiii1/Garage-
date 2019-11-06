//
//  SearchPrinterHelper.swift
//  Garage
//
//  Created by Amjad on 10/07/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit



protocol SearchPrinterHelperDelegate {
    func discoverdPrinters(printers: Set<PrinterDetailsModel>?)
}


class SearchPrinterHelper: NSObject {
    var delegate: SearchPrinterHelperDelegate?
    
    /// Variable for Epsion Printer
    private var epsonPrinter: EpsonPrinterHelper?
    
    /// Variable for Star Printer
    //    var starPrinter: StarPrinterHelper?
    
    private var printerConnectionMedium: ConnectionMedium?
    private var printers: Set<PrinterDetailsModel> = Set<PrinterDetailsModel>()
    
        fileprivate var callbackCount = 0
        //it should match no of supported manufacturers
        final fileprivate var requiredCallbackCount = 1
    
    private func configurePrinters() {
        //        callbackCount = 0
        epsonPrinter = EpsonPrinterHelper()
        epsonPrinter?.delegate = self
        
        //        starPrinter = StarPrinterHelper()
        //        starPrinter?.delegate = self
    }
    
    // MARK:- Public Method
    
    /// Starts seraching for printers on given medium
    ///
    /// - parameters:
    ///   - medium: ConnectionMedium (An enum declared in ConstantValues.swift)
    /// - returns: Void
    func searchPrinter(on medium: ConnectionMedium) {
        printerConnectionMedium = medium
        switch medium {
        case ConnectionMedium.localAreaNetwork:
            Loader.startLoading()
            configurePrinters()
            epsonPrinter?.startSearchingOnLAN(completion: { (isSuccess, message) in
                print("Epson printer found = \(message)")
                Loader.stopLoading()
            })
            //            starPrinter?.startSearchingOnLAN(completion: { (isSuccess, message) in
            //                print("starPrinter.startSearchingOnLAN")
            //            })
            break
        case ConnectionMedium.bluetooth:
            Loader.startLoading()
            configurePrinters()
            epsonPrinter?.startSearchingOnBluetooth(completion: { (isSuccess, message) in
                Loader.stopLoading()
            })
            break
        }
    }
}




extension SearchPrinterHelper: EpsonPrinterHelperDelegate {
    func didDiscover(epsonPrinter target: Epos2DeviceInfo) {
        let printerDetail = PrinterDetailsModel()
        printerDetail.target = target.target
        printerDetail.model = target.deviceName
        printerDetail.ipAddress = target.ipAddress
        printerDetail.macAddress = target.macAddress
        printerDetail.manufacturer = PrinterManufacturer.epson
        printers.insert(printerDetail)
      //  delegate?.discoverdPrinters(printers: printers)
                callbackCount = callbackCount + 1
                if callbackCount == requiredCallbackCount {
                    delegate?.discoverdPrinters(printers: printers)
                }
    }
    
}

//extension SearchPrinterHelper: StarPrinterHelperDelegate {
//    func didDiscover(starPrinters portInfoArray: [PortInfo]) {
//        for printer in portInfoArray {
//            let printerDetail = PrinterDetailsModel()
//            printerDetail.target = printer.portName
//            printerDetail.model = printer.modelName
//            printerDetail.ipAddress = printer.portName
//            printerDetail.portName = printer.portName
//            printerDetail.macAddress = printer.macAddress
//            printerDetail.manufacturer = PrinterManufacturer.star
//            printers.insert(printerDetail)
//        }
//        delegate?.discoverdPrinters(printers: printers)
//    }
//}

