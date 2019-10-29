//
//  GeneralViewController.swift
//  Garage
//
//  Created by Amjad on 21/06/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit




class GeneralViewController: UIViewController {

    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
}
    
                                          
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    @IBOutlet weak var ZebraTable: UITableView!
//
//
//    @IBOutlet weak var ip: UITextField!
//
//    @IBOutlet weak var port: UITextField!
//
//    @IBOutlet weak var PrintBtn: UIButton!
//
//
//
//
//    var performingDemo = false
//
//
//
//
//    var printers : [DiscoveredPrinter]? {
//        didSet
//        {
//            if printers != nil
//            {
//                self.ZebraTable.reloadData()
//            }
//        }
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        do{
//            var arr = try NetworkDiscoverer.localBroadcast(withTimeout: 30)
//            if arr != nil
//            {
//                self.printers = arr  as! [DiscoveredPrinter]
//            }else{
//                self.printers = nil
//            }
//        }catch(let err)
//        {
//            print(err.localizedDescription)
//        }
//
//        if Added() {
//            ip.addTarget(self, action: #selector(printertypelabelChange(_:)), for: .editingChanged)
//        }  else {
//            ip.addTarget(self, action: #selector(printertypelabelChange(_:)), for: .editingChanged)
//
//        }
//        port.text = "6101"
//        /// ip.text = UserDefaults.standard.string(forKey: "Zprinter")!
//
//        // Do any additional setup after loading the view.
//         self.performingDemo = false;
//
//    }
//
//
//
//
//
//    fileprivate func Added() -> Bool {
//        ip.text = UserDefaults.standard.string(forKey: "Zprinter")
//
//        return UserDefaults.standard.bool(forKey: "Zprinter")
//    }
//
//    @objc func printertypelabelChange(_ textField: UITextField) {
//
//        if ip.text!.characters.count != 0 {
//            print("added")
//        }
//        else {
//            print("deleted")
//        }
//
//    }
//
//
//
//
//
//
//
//    @IBAction func PrintPressed(_ sender: Any) {
//        //ZebraPrinter()
//
//    }
//
//
//
//
////    func getLanguageName(_ language: PrinterLanguage) -> String? {
////        if language == PRINTER_LANGUAGE_ZPL {
////            return "ZPL"
////        } else  {
////            return "CPCL"
////        }
////
////    }
////
////
////
////    func printTestLabel(_ language: PrinterLanguage, onConnection connection: (ZebraPrinterConnection & NSObjectProtocol)) -> Bool {
////        var testLabel = ""
////        var err : NSError?//can't type capital n which letter let me know I will do, it nSError = nSError same? n is capital, wait ok sure
////        if language == PRINTER_LANGUAGE_ZPL {
////            testLabel = "^XA^FWI,^CF0,30,^FT400,30^FDDate: 21/12/2019^FS,^CF0,30,^FT400,90^FDPlate: ABC-1234^FS,^CF0,30,^FT400,140^FDKm: 13230^FS,^CF0,40,^FT400,190^FDMarn Garage^FS,^CF0,20,^XZ"
////            let data = testLabel.data(using: .utf8)!
////            connection.write(data, error: &err)
////
////        } else if language == PRINTER_LANGUAGE_CPCL {
////
////            testLabel = "! 0 200 200 406 1\r\nON-FEED IGNORE\r\nBOX 20 20 380 380 8\r\nT 0 6 137 177 Test\r\nPRINT\r\n"
////
////            let data = testLabel.data(using: .utf8)!
////
////            connection.write(data, error: &err)
////        }
////        if err == nil
////        {
////            return true
////        }else
////        {
////            return false
////        }
////    }
////
////
//
//    func printImageOnly() {
//        // Print
//      //  DispatchQueue.global(qos: .background).async {
//            if self.ip.text != "" {
//                do {
//                    let ipAddress = ip.text!
//                    let portAsString = port.text!
//                    let por = Int(portAsString) ?? 0
//                    let connection = TcpPrinterConnection(address: ipAddress, andWithPort: por)
//                    if connection?.open() == true {
//                        let printer = ZebraPrinterFactory.getInstance(connection, with: PRINTER_LANGUAGE_ZPL)
//
//                        // Print image
//                        do {
//                            try printer?.getToolsUtil().sendCommand("^XA")
//
//                            let imageURL = Bundle.main.url(forResource: "wmark1", withExtension: "jpg")!
//                            let imageData = try Data(contentsOf: imageURL)
//                            let image = UIImage(data: imageData)
//
//                            if image != nil && image!.cgImage != nil {
//                                try printer?.getGraphicsUtil().print(image!.cgImage!, atX: 0, atY: 20, withWidth: 400, withHeight: 200, andIsInsideFormat: true)
//                            }
//                            try printer?.getToolsUtil().sendCommand("^XZ")
//                        }
//                    }
//
//                    //connection?.close()
//                    //connection = nil
//                } catch {
//                    DispatchQueue.main.sync {
//                        // Display alert
//                        let alert = UIAlertController(title: "Message", message: error.localizedDescription, preferredStyle: .alert)
//                        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: nil))
//
//                        if var currentViewController = UIApplication.shared.keyWindow?.rootViewController {
//                            while let presentedViewController = currentViewController.presentedViewController {
//                                currentViewController = presentedViewController
//                            }
//
//                            // Display message with current view controller
//                            currentViewController.present(alert, animated: true, completion: nil)
//                        }
//                    }
//                }
//            } else {
//                DispatchQueue.main.sync {
//                    // Display alert
//                    let alert = UIAlertController(title: "Message", message: "Please set up printer first.", preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: nil))
//
//                    if var currentViewController = UIApplication.shared.keyWindow?.rootViewController {
//                        while let presentedViewController = currentViewController.presentedViewController {
//                            currentViewController = presentedViewController
//                        }
//
//                        // Display message with current view controller
//                        currentViewController.present(alert, animated: true, completion: nil)
//                    }
//                }
//            }
//      //  }
//    }
//
//
//
//    /*
//     // MARK: - Navigation
//
//     // In a storyboard-based application, you will often want to do a little preparation before navigation
//     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//     // Get the new view controller using segue.destination.
//     // Pass the selected object to the new view controller.
//     }
//     */
//
//}
//
//extension GeneralViewController : UITableViewDelegate, UITableViewDataSource
//{
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
//        cell.textLabel!.text = self.printers![indexPath.row].address
//
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if let printers = self.printers
//        {
//            return printers.count
//        }
//        return 0
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        tableView.separatorColor = UIColor.gray
//        return CGFloat(60)
//
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//       Constants.zebra = self.printers![indexPath.row].address
//        ip.text = Constants.zebra
////        port.text = "6101"
//        UserDefaults.standard.set(Constants.zebra, forKey: "Zprinter")
//        UserDefaults.standard.synchronize()
//
//        ToastView.show(message: "Added", controller: self)
//        dismiss(animated: true, completion: nil)
//    }
//
//}
//
