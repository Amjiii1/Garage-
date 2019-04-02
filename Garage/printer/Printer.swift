//
//  Printer.swift
//  Garage
//
//  Created by Amjad on 25/07/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit

class Printer: NSObject {
    
    @objc dynamic var id:Int = 0
    @objc dynamic var model = ""
    @objc dynamic var IPAddress = ""
    @objc dynamic var printReceipts:Bool = true
    @objc dynamic var cashDrawer:Bool = false
    @objc dynamic var kitchenPrinter:Bool = false
    @objc dynamic var divert:Bool = false
    @objc dynamic var alertnative:Printer!
    @objc dynamic var copies:Int = 1
    @objc dynamic var alias = ""
    @objc dynamic var macAddress = ""
    @objc dynamic var BDaddress = ""
    @objc dynamic var portName = ""
    @objc dynamic var star:Bool = false
    @objc dynamic var target:String = ""
    @objc dynamic var portSetting = ""
    @objc dynamic var bluetooth:Bool = true
    @objc dynamic var serverPrinter:Bool = true

    class _Printer: NSObject {
        var id:Int = 0
        var model = ""
        var IPAddress = ""
        var printReceipts:Bool = true
        var cashDrawer:Bool = false
        var kitchenPrinter:Bool = false
        var divert:Bool = false
        var alertnative:_Printer!
        var copies:Int = 1
        var alias = ""
        var macAddress = ""
        var BDaddress = ""
        var portName = ""
        var star:Bool = false
        var target:String = ""
        var portSetting = ""
        var bluetooth:Bool = true
        var serverPrinter:Bool = true
        
        override init(){
            super.init()
            
        }
        init(printer:Printer)
        {
            self.model = printer.model
            self.IPAddress = printer.IPAddress
            self.printReceipts = printer.printReceipts
            self.cashDrawer = printer.cashDrawer
            self.kitchenPrinter = printer.kitchenPrinter
            self.divert = printer.divert
            if (printer.alertnative != nil) {
                let _alternative = _Printer(printer: printer.alertnative)
                self.alertnative = _alternative
            }
            self.copies = printer.copies
            self.alias = printer.alias
            self.macAddress = printer.macAddress
            self.BDaddress = printer.BDaddress
            self.portName = printer.portName
            self.star = printer.star
            self.target = printer.target
            self.portSetting = printer.portSetting
            self.serverPrinter = printer.serverPrinter
            self.id = printer.id
        }
        
        init(model:String = "",
             IPAddress:String = "",
             printReceipts:Bool = true,
             cashDrawer:Bool = false,
             kitchenPrinter:Bool = false,
             divert:Bool = false,
             alertnative:_Printer!,
             copies:Int = 1,
             alias:String = "",
             macAddress:String = "",
             BDaddress:String = "",
             portName:String = "",
             star:Bool = false,
             target:String = "",
             portSetting:String = "",
             bluetooth:Bool = true,
             serverPrinter:Bool = true,
             id:Int )
        {
            self.model = model
            self.IPAddress = IPAddress
            self.printReceipts = printReceipts
            self.cashDrawer = cashDrawer
            self.kitchenPrinter = kitchenPrinter
            self.divert = divert
            self.alertnative = alertnative
            self.copies = copies
            self.alias = alias
            self.macAddress = macAddress
            self.BDaddress = BDaddress
            self.portName = portName
            self.star = star
            self.target = target
            self.portSetting = portSetting
            self.bluetooth = bluetooth
            self.serverPrinter = serverPrinter
            self.id = id
        }
    }
        
}
