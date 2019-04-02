//
//  CheckOutPopView.swift
//  Garage
//
//  Created by Amjad Ali on 8/5/18.
//  Copyright © 2018 Amjad Ali. All rights reserved.
//

import UIKit

class CheckOutPopView: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate {
    
    
    
    @IBOutlet weak var buttonstack: UIStackView!
    @IBOutlet weak var PopUpView: UIView!
    @IBOutlet weak var containerPop: UIView!
    @IBOutlet weak var buttonStackView: UIStackView!
    @IBOutlet weak var voucherBtn: UIButton!
    @IBOutlet weak var loyalityBtn: UIButton!
    @IBOutlet weak var giftcardBtn: UIButton!
    @IBOutlet weak var cardBtn: UIButton!
    @IBOutlet weak var cashBtn: UIButton!
    @IBOutlet weak var checkout_tableview: UITableView!
    @IBOutlet weak var workerBtn: UIButton!
    @IBOutlet weak var assistantBtn: UIButton!
    @IBOutlet weak var checkoutoutlet: UIButton!
    @IBOutlet weak var grandtotalBtn: UIButton!
    @IBOutlet weak var discouttableview: UITableView!
    @IBOutlet weak var tenderedbalance: UITextField!
    @IBOutlet weak var grandtotalLbl: UILabel!
    let dateFormatter : DateFormatter = DateFormatter()
    @IBOutlet weak var balancetxtf: UITextField!
    private weak var subView: UIView?
    var orderdetails = [Checkoutdetails]()
    

    
    
//    var printer: Epos2Printer?
//    var valuePrinterSeries: Epos2PrinterSeries = EPOS2_TM_M10
//    var valuePrinterModel: Epos2ModelLang = EPOS2_MODEL_ANK
    var cartItemStructArray = [ReceiptModel]()
var printerDetailModelUICells: [PrinterDetailCellUIModel]!
    
    let viewModel = CheckoutViewModel()
    var dummyData = ["Discount","SubTotal","VAT \(Constants.percent)%"]
    var amount = [0,Constants.subtotal,Constants.checkouttax]
    var workerid = 0
    var assistantid = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = UIColor.clear.withAlphaComponent(0.5)
        if let button = buttonstack.viewWithTag(1) as? UIButton {
            tabButtonaction(button)
        }
        
        //  buttonstack.layer.cornerRadius = 14.0
        tenderedbalance.delegate = self
        viewModel.checkoutVC = self
        checkout_tableview.delegate = self
        checkout_tableview.dataSource = self
        discouttableview.delegate = self
        discouttableview.dataSource = self
        checkout_tableview.separatorStyle = .none
        discouttableview.separatorStyle = .none
        self.checkoutoutlet.setTitle(String(format: "%.2f SAR", Constants.checkoutGrandtotal), for: .normal)  //(format: "%.2f", (Constants.checkoutGrandtotal)
        NotificationCenter.default.addObserver(self, selector: #selector(CheckOutPopView.userNotification(notification:)), name: Notification.Name("Notificationusername"), object: nil)
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        Constants.currentdate = dateString

        grandtotalLbl.text = String(format: "%.2f", Constants.checkoutGrandtotal)
        tenderedbalance.textAlignment = NSTextAlignment.left
        tenderedbalance.text = "0"
        balancetxtf.text = String(format: "%.2f", Constants.checkoutGrandtotal)
        tenderedbalance.addTarget(self, action: #selector(tendrdFieldDidChange(_:)), for: .editingChanged)
        let result = Epos2Log.setLogSettings(EPOS2_PERIOD_TEMPORARY.rawValue, output: EPOS2_OUTPUT_STORAGE.rawValue, ipAddress:nil, port:0, logSize:1, logLevel:EPOS2_LOGLEVEL_LOW.rawValue)
        
        if result != EPOS2_SUCCESS.rawValue {
            MessageView.showErrorEpos(result, method: "setLogSettings")
        }
        NotificationCenter.default.addObserver(self, selector: #selector(CheckOutPopView.printeradded(notification:)), name: Notification.Name("printerAdded"), object: nil)
        
        
    }
    
    
    
    @objc func printeradded(notification: Notification) {
        print(Constants.Printer)
    }
    
    
    @objc func tendrdFieldDidChange(_ textField: UITextField) {
        if tenderedbalance.text == "0" {
            balancetxtf.text = String(format: "%.2f", Constants.checkoutGrandtotal)
        }  else if tenderedbalance.text == "" {
            balancetxtf.text = String(format: "%.2f", Constants.checkoutGrandtotal)
        } else {
            //
            let intFromString = Double(tenderedbalance.text!)
            if ((Int(intFromString!)) > (Int(Constants.checkoutGrandtotal))) {
                balancetxtf.text = "0"
            } else {
                let blnce = Constants.checkoutGrandtotal - intFromString!
                balancetxtf.text = String(format: "%.2f", blnce)
            }
            
        }
        
    }
    
    
    @objc func userNotification(notification: Notification) {
        if Constants.workerflag == 1 {
            self.workerBtn.setTitle("\(Constants.FullName)", for: .normal)
            Constants.checkoutmechanic = Constants.FullName
            workerid = Constants.SubUserID
            
            Constants.workerflag = 0
        } else {
            self.assistantBtn.setTitle("\(Constants.FullName)", for: .normal)
            assistantid = Constants.SubUserID
            
        }
        
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("printerAdded"), object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name("Notificationusername"), object: nil)
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var returnvalue = 0
        if tableView == checkout_tableview {
            returnvalue = Checkoutstruct.sentitems.count
        }
        else if tableView == discouttableview {
            returnvalue = 3
        }
        return returnvalue
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == checkout_tableview {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellcheckout") as! checkoutcell
            cell.productlabel.text = Checkoutstruct.sentitems[indexPath.row].Name
            let qty = Checkoutstruct.sentitems[indexPath.row].Quantity
            cell.Qtylabel.text = "\(qty!)"
            let price = Checkoutstruct.sentitems[indexPath.row].Price
            cell.pricelabel.text =  "\(price!)"
            cell.selectionStyle = .none
            return cell
        }
        else if tableView == discouttableview {
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "dummycell") as! checkoutdiscount
            cell2.label.text = dummyData[indexPath.row]
            let tax = amount[indexPath.row]
            cell2.amount.text = String(format: "%.2f", tax)//String(tax)
            cell2.selectionStyle = .none
            //            cell2.textLabel!.text = dummyData[indexPath.row]
            return cell2
            
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.separatorColor = UIColor.gray
        return CGFloat(40)
        
    }
    
    
    
    @IBAction func workerAction(_ sender: Any) {
        
        Constants.workerflag = 1
        var storyboard: UIStoryboard!
        var popController: UIViewController!
        
        storyboard = UIStoryboard(name: "Subusers", bundle: nil)
        popController = storyboard.instantiateViewController(withIdentifier: "SubusersVc") as! Subusers
        let nav = UINavigationController(rootViewController: popController)
        nav.modalPresentationStyle = UIModalPresentationStyle.popover
        let heightForPopOver = 80*3
        let popover = nav.popoverPresentationController
        popController.preferredContentSize = CGSize(width: 200 , height: heightForPopOver)
        popover?.permittedArrowDirections = .up
        popover?.backgroundColor = UIColor.white
        popover?.sourceView = self.workerBtn
        popover?.sourceRect = self.workerBtn.bounds//CGRect(x: self.assignBtn.bounds.midX, y: self.assignBtn.bounds.midY, width: 0, height: 0)
        self.present(nav, animated: true, completion: nil)
    }
    
    
    
    
    @IBAction func AssistantAction(_ sender: Any) {
        var storyboard: UIStoryboard!
        var popController: UIViewController!
        storyboard = UIStoryboard(name: Constants.Subusers, bundle: nil)
        popController = storyboard.instantiateViewController(withIdentifier: Constants.SubusersVc) as! Subusers
        let nav = UINavigationController(rootViewController: popController)
        nav.modalPresentationStyle = UIModalPresentationStyle.popover
        let heightForPopOver = 80*3
        let popover = nav.popoverPresentationController
        popController.preferredContentSize = CGSize(width: 200 , height: heightForPopOver)
        popover?.permittedArrowDirections = .up
        popover?.backgroundColor = UIColor.white
        popover?.sourceView = self.assistantBtn
        popover?.sourceRect = self.assistantBtn.bounds//CGRect(x: self.assignBtn.bounds.midX, y: self.assignBtn.bounds.midY, width: 0, height: 0)
        self.present(nav, animated: true, completion: nil)
    }
    
    
    
    
    @IBAction func tabButtonaction(_ sender: UIButton) {
        
        var voucherNibView:  VoucherView!
        var loyalityNibView: LoyaltyView!
        var giftCardNibView: GiftCardView!
        var cardNibView:     CardView!
        var cashNibView:     CashView!
        
        removeNibViews()
        checkboxDidTap(sender: sender)
        
        switch sender.tag {
            
        case 1:
            cashNibView = Bundle.main.loadNibNamed(Constants.CashView, owner: self, options: nil)?[0] as? CashView
            cashNibView.frame.size = containerPop.frame.size
            cashNibView.delegate = self
            self.containerPop.addSubview(cashNibView)
            
            
            
        case 2:
            cardNibView = Bundle.main.loadNibNamed(Constants.CardView, owner: self, options: nil)?[0] as? CardView
            cardNibView.frame.size = containerPop.frame.size
            self.containerPop.addSubview(cardNibView)
            break
        case 3:
            giftCardNibView = Bundle.main.loadNibNamed(Constants.GiftCardView, owner: self, options: nil)?[0] as? GiftCardView
            giftCardNibView.frame.size = containerPop.frame.size
            self.containerPop.addSubview(giftCardNibView)
            break
            
        case 4:
            loyalityNibView = Bundle.main.loadNibNamed(Constants.LoyaltyView, owner: self, options: nil)?[0] as? LoyaltyView
            loyalityNibView.frame.size = containerPop.frame.size
            self.containerPop.addSubview(loyalityNibView)
            break
            
        case 5:
            voucherNibView = Bundle.main.loadNibNamed(Constants.VoucherView, owner: self, options: nil)?[0] as? VoucherView
            voucherNibView.frame.size = containerPop.frame.size
            self.containerPop.addSubview(voucherNibView)
            break
        default:
            break
        }
        
    }
    
    
    func checkboxDidTap(sender: UIButton) {
        
        for i in 1...5 {
            if let btn = buttonStackView.viewWithTag(i) as? UIButton {
                btn.isSelected = false
                
            }
        }
        sender.isSelected = true
        
    }
    
    
    func myButtonTapped()  {
        if  voucherBtn.isSelected == true {
            voucherBtn.isSelected = false
        }   else {
            voucherBtn.isSelected = true
        }
    }
    
    
    
    
    func removeNibViews() {
        if containerPop.subviews.count > 0  {
            let views:[UIView] = containerPop.subviews
            for view in views  {
                view.removeFromSuperview()
                
            }
            
        }
        
        
    }
    
    
    
    
    func checkoutOrder() {
        
        let test = ["CardNumber": "", "CardHolderName": "", "CardType": "", "AmountPaid": Constants.checkoutGrandtotal.myRounded(toPlaces: 2), "AmountDiscount": 0.0, "PaymentMode": 1] as [String : Any]

        let test2 = Double(tenderedbalance.text!) ?? Double.nan
        
        if (test2) >= Constants.checkoutGrandtotal.myRounded(toPlaces: 2)  {
            
            let parameters = [   Constants.OrderID: Constants.checkoutorderid,
                                 Constants.SessionID: Constants.sessions,
                                 "PaymentMode": 1,
                                 Constants.Date: Constants.currentdate,
                                 Constants.AmountTotal: Constants.subtotal.myRounded(toPlaces: 2),
                                 "OrderStatus": 103,
                                 Constants.AmountPaid: tenderedbalance.text!,
                                 Constants.GrandTotal: Constants.checkoutGrandtotal.myRounded(toPlaces: 2),
                                 "AmountDiscount": 0,
                                 "PartialPayment": 0,
                                 "Gratuity": 0,
                                 "ServiceCharges": 0,
                                 Constants.CarID:  Constants.checkoutcarid,
                                 Constants.Tax: Constants.checkouttax.myRounded(toPlaces: 2),
                                 Constants.WorkerID: workerid,
                                 Constants.AssistantID: assistantid,
                                 "AmountComplementary": 0,
                                 "CheckoutDetails": [test] ] as [String : Any]
            
            guard let url = URL(string: "\(CallEngine.baseURL)\(CallEngine.checkout)") else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
            request.httpBody = httpBody
            if let JSONString = String(data: httpBody, encoding: .utf8) {
                
                print(JSONString)
            }
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                if response == nil {
                    DispatchQueue.main.async {
                        ToastView.show(message: "Login failed! Check internet", controller: self)
                        
                    }
                }
                if let response = response {
                    print(response)
                }
                
                if let data = data {
                    print(data)
                    do {
                        guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {return}
                        print(json)
                        
                        let status = json[Constants.Status] as? Int
                        let newmessage = json[Constants.Description] as? String
                        if (status == 1) {
                            ToastView.show(message: newmessage!, controller: self)
                            
                            DispatchQueue.main.async {
                                self.printerreceipt()
                             //   self.runPrinterReceiptSequence()
                                NotificationCenter.default.post(name: Notification.Name("checkoutDone"), object: nil)
                                self.dismiss(animated: true, completion: nil)
                                self.grandtotalBtn.isUserInteractionEnabled = true
                                
                            }
                            
                        }
                        else if (status == 0) {
                            
                            DispatchQueue.main.async {
                                let messageVC = UIAlertController(title: "Failed ", message: "\(newmessage!)" , preferredStyle: .actionSheet)
                                self.present(messageVC, animated: true) {
                                    Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { (_) in
                                        messageVC.dismiss(animated: true, completion: nil)})}
                                ToastView.show(message: newmessage!, controller: self)
                                self.grandtotalBtn.isUserInteractionEnabled = true
                            }
                            
                        }
                            
                        else if (status == 1000) {
                            
                            DispatchQueue.main.async {
                                let messageVC = UIAlertController(title: "Failed ", message: "\(Constants.wrong)" , preferredStyle: .actionSheet)
                                self.present(messageVC, animated: true) {
                                    Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { (_) in
                                        messageVC.dismiss(animated: true, completion: nil)})}
                                ToastView.show(message: newmessage!, controller: self)
                                self.grandtotalBtn.isUserInteractionEnabled = true
                            }
                            
                        }
                            
                        else if (status == 1001) {
                            
                            DispatchQueue.main.async {
                                let messageVC = UIAlertController(title: "Failed ", message: "\(Constants.invalid)" , preferredStyle: .actionSheet)
                                self.present(messageVC, animated: true) {
                                    Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { (_) in
                                        messageVC.dismiss(animated: true, completion: nil)})}
                                ToastView.show(message: newmessage!, controller: self)
                                self.grandtotalBtn.isUserInteractionEnabled = true
                            }
                            
                        }
                            
                        else  {
                            DispatchQueue.main.async {
                                let messageVC = UIAlertController(title: "Failed ", message: "\(Constants.occured)" , preferredStyle: .actionSheet)
                                self.present(messageVC, animated: true) {
                                    Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { (_) in
                                        messageVC.dismiss(animated: true, completion: nil)})}
                                ToastView.show(message: newmessage!, controller: self)
                                self.grandtotalBtn.isUserInteractionEnabled = true
                            }
                            
                        }
                        
                        
                    } catch {
                        print(error)
                        ToastView.show(message: "Edit Failed! error occured", controller: self)
                        self.grandtotalBtn.isUserInteractionEnabled = true
                        
                    }
                    
                    
                    
                }
                
                }.resume()
            
        }   else {
            let messageVC = UIAlertController(title: "Checkout Failed", message: "Please Enter Total Amount!" , preferredStyle: .actionSheet)
            present(messageVC, animated: true) {
                Timer.scheduledTimer(withTimeInterval:1.0, repeats: false, block: { (_) in
                    messageVC.dismiss(animated: true, completion: nil)})}
            self.grandtotalBtn.isUserInteractionEnabled = true
            
        }
        
    }
    
    
    
    
    //    func updateQuickButtonAmount(){
    //        if let view = containerPop as? CashView   {
    //           view.updateFirstButtonAmount()
    //        }
    //    }
    
    
    
    @IBAction func CheckoutBtn(_ sender: Any) {
       
        
        self.grandtotalBtn.isUserInteractionEnabled = true
//        print(Constants.Printer)
//        if Constants.Printer == "" {
//            alert(view: self, title: "Printer is not connected", message: "Do you want to add Printer from Settings")
//        } else {
            checkoutOrder()
      //  }
        

    }
    
    
    
    func printerreceipt() {
        
        for receipt in Checkoutstruct.sentitems {
            
            let cartItemStruct = ReceiptModel(Name: receipt.Name!, Price: receipt.Price!, ItemID: receipt.ItemID!, Quantity: receipt.Quantity!, Mode: "new", OrderDetailID: receipt.OrderDetailID!, Status: 1)
            
            cartItemStructArray.append(cartItemStruct)
            self.dismiss(animated: true, completion: nil)
            
            
        }
        
        
        
        
        
        
        let orderToPrint = Orderdetail.init(OrderDetailID: 12, OrderID: 12, ItemID: 1, ItemName: "Ammjad", ItemImage: "store.png", Quantity: 32, Price: 21, TotalCost: 11, LOYALTYPoints: 1, StatusID: 2, ItemDate: Constants.currentdate, Mode: "new", orderPrinterType: PrinterType.checkout)
        
        PrintJobHelper.addCheckoutOrderInPrinterQueue(orderDetails: orderToPrint, cartItems:cartItemStructArray)
        
    }
    
    
    
    
    
    
    
    func settings() {
        
        let screenSize = UIScreen.main.bounds.width
        let screenheight = UIScreen.main.bounds.size.height
        print(screenheight)
        var storyboard: UIStoryboard!
        var popController: UIViewController!
        storyboard = UIStoryboard(name: "CheckoutPopUp", bundle: nil)
        popController = storyboard.instantiateViewController(withIdentifier: "CheckOutPopVc") as! CheckOutPopView
        popController.modalPresentationStyle = .popover
        let popOverVC = popController.popoverPresentationController
        popOverVC?.delegate = self
        popOverVC?.sourceView = self.view
        popOverVC?.permittedArrowDirections = UIPopoverArrowDirection(rawValue:0)
        popOverVC?.sourceRect = CGRect(x: screenSize, y: screenheight*0.70, width: 0, height: 0)
        popController.preferredContentSize = CGSize(width: screenSize, height: screenheight*0.70)
        self.present(popController, animated: true)
    }
    
    
    
    func alert(view: CheckOutPopView, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Yes", style: .default, handler: { action in
            self.dismiss(animated: true, completion: nil)
            //    self.settings()
            
        })
        
        alert.addAction(defaultAction)
        let cancel = UIAlertAction(title: "No", style: .default, handler: { action in
            self.checkoutOrder()
        })
        alert.addAction(cancel)
        DispatchQueue.main.async(execute: {
            view.present(alert, animated: true)
        })
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        //        if let vc = (self.parent as? CheckoutView)?.parent as? ReceptionalistView {
        //        vc.removeFooterView()
        //
        //        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //    func updateButtonState(_ state: Bool) {
    //        buttonDiscovery.isEnabled = state
    //        printbtn.isEnabled = state
    //        printbtn.isEnabled = state
    //
    //    }
    
//    func runPrinterReceiptSequence() -> Bool {
//
//        if !initializePrinterObject() {
//            return false
//        }
//
//        if !createReceiptData() {
//            finalizePrinterObject()
//            return false
//        }
//
//        if !printData() {
//            finalizePrinterObject()
//            return false
//        }
//
//        return true
//    }
//
//    func runPrinterCouponSequence() -> Bool {
//
//        if !initializePrinterObject() {
//            return false
//        }
//
//        if !createCouponData() {
//            finalizePrinterObject()
//            return false
//        }
//
//        if !printData() {
//            finalizePrinterObject()
//            return false
//        }
//
//        return true
//    }
//
//    func createReceiptData() -> Bool {
//
//        var result = EPOS2_SUCCESS.rawValue
//
//        let textData: NSMutableString = NSMutableString()
//        let logoData = UIImage(named: "store1.png")
//
//        if logoData == nil {
//            return false
//        }
//
//        result = printer!.addTextAlign(EPOS2_ALIGN_CENTER.rawValue)
//        if result != EPOS2_SUCCESS.rawValue {
//            MessageView.showErrorEpos(result, method:"addTextAlign")
//            return false;
//        }
//
//        result = printer!.add(logoData, x: 0, y:0,
//                              width:Int(logoData!.size.width),
//                              height:Int(logoData!.size.height),
//                              color:EPOS2_COLOR_1.rawValue,
//                              mode:EPOS2_MODE_MONO.rawValue,
//                              halftone:EPOS2_HALFTONE_DITHER.rawValue,
//                              brightness:Double(EPOS2_PARAM_DEFAULT),
//                              compress:EPOS2_COMPRESS_AUTO.rawValue)
//
//        if result != EPOS2_SUCCESS.rawValue {
//            MessageView.showErrorEpos(result, method:"addImage")
//            return false
//        }
//
//
//        // Section 1 : Store information
//        result = printer!.addFeedLine(1)
//        if result != EPOS2_SUCCESS.rawValue {
//            MessageView.showErrorEpos(result, method:"addFeedLine")
//            return false
//        }
//        result = printer!.addTextAlign(EPOS2_ALIGN_CENTER.rawValue)
//        if result != EPOS2_SUCCESS.rawValue {
//            MessageView.showErrorEpos(result, method:"addTextAlign")
//            return false;
//        }
//        textData.append("AL MALAZ BRANCH\n")
//        textData.append("Phone No. 0568833923\n")
//        textData.append("\n")
//        //textData.append("\(Constants.currentdate)\n")
//        // textData.append("Majid Bin Abdul Aziz Road\n")
//        textData.append("VAT# 12345678912345\n")
//        textData.append("\n")
//        textData.append("Plate No. \(Constants.checkoutplatenmb)\n")
//        textData.append("\n")
//        textData.append("VIN: \(Constants.checkoutvin)\n")
//        textData.append("\n\n")
//        textData.append("------------------------------\n")
//        textData.append("\(Constants.currentdate)\n")
//        textData.append("------------------------------\n")
//        textData.append("\(Constants.checkoutcustm)                       \(Constants.checkoutbayname)\n")
//        textData.append("\(Constants.checkoutcarmake)                      \(Constants.checkoutcarmodel)\n")
//        textData.append("00km                       \(Constants.checkoutyear)\n")
//
//        textData.append("------------------------------\n\n")
//        result = printer!.addText(textData as String)
//        if result != EPOS2_SUCCESS.rawValue {
//            MessageView.showErrorEpos(result, method:"addText")
//            return false;
//        }
//        textData.setString("")
//
//        result = printer!.addTextAlign(EPOS2_ALIGN_CENTER.rawValue)
//        if result != EPOS2_SUCCESS.rawValue {
//            MessageView.showErrorEpos(result, method:"addTextAlign")
//            return false;
//        }
//
//        // Section 2 : Purchaced items
//        for receipt in Checkoutstruct.sentitems {
//            textData.append("\(receipt.Quantity!)X \(receipt.Name!) ------------------ \(receipt.Price!) SR\n")
//            //        textData.append("410 3 CUP BLK TEAPOT    9.99 R\n")
//            //        textData.append("445 EMERIL GRIDDLE/PAN 17.99 R\n")
//            //        textData.append("438 CANDYMAKER ASSORT   4.99 R\n")
//            //        textData.append("474 TRIPOD              8.99 R\n")
//            //        textData.append("433 BLK LOGO PRNTED ZO  7.99 R\n")
//            //        textData.append("458 AQUA MICROTERRY SC  6.99 R\n")
//            //        textData.append("493 30L BLK FF DRESS   16.99 R\n")
//            //        textData.append("407 LEVITATING DESKTOP  7.99 R\n")
//            //        textData.append("441 **Blue Overprint P  2.99 R\n")
//            //        textData.append("476 REPOSE 4PCPM CHOC   5.49 R\n")
//            //        textData.append("461 WESTGATE BLACK 25  59.99 R\n")
//        }
//        textData.append("\n")
//        textData.append("------------------------------\n")
//        result = printer!.addText(textData as String)
//        if result != EPOS2_SUCCESS.rawValue {
//            MessageView.showErrorEpos(result, method:"addText")
//            return false;
//        }
//        textData.setString("")
//
//
//        // Section 3 : Payment infomation
//        textData.append("SUBTOTAL                 \( Constants.subtotal) SR\n");
//         textData.append("Discount                   0.0 SR\n");
//        textData.append("VAT(\(Constants.percent)%)                   \(Constants.checkouttax) SR\n\n");
//        result = printer!.addText(textData as String)
//        if result != EPOS2_SUCCESS.rawValue {
//            MessageView.showErrorEpos(result, method:"addText")
//            return false
//        }
//        textData.setString("")
//
//        result = printer!.addTextSize(2, height:2)
//        if result != EPOS2_SUCCESS.rawValue {
//            MessageView.showErrorEpos(result, method:"addTextSize")
//            return false
//        }
//
//        result = printer!.addText("TOTAL    \(Constants.checkoutGrandtotal) SR\n")
//        if result != EPOS2_SUCCESS.rawValue {
//            MessageView.showErrorEpos(result, method:"addText")
//            return false;
//        }
//
//        result = printer!.addTextSize(1, height:1)
//        if result != EPOS2_SUCCESS.rawValue {
//            MessageView.showErrorEpos(result, method:"addTextSize")
//            return false;
//        }
//
//        result = printer!.addFeedLine(1)
//        if result != EPOS2_SUCCESS.rawValue {
//            MessageView.showErrorEpos(result, method:"addFeedLine")
//            return false;
//        }
//
//        textData.append("CASH                    \(Constants.checkoutGrandtotal)\n")
//        textData.append("------------------------------\n")
//        result = printer!.addText(textData as String)
//        if result != EPOS2_SUCCESS.rawValue {
//            MessageView.showErrorEpos(result, method:"addText")
//            return false
//        }
//        textData.setString("")
//
//        // Section 4 : Advertisement
//        textData.append("** Have a safe drive **\n")
//        //  textData.append("Sign Up and Save !\n")
//        textData.append("Garage.sa\n")
//        result = printer!.addText(textData as String)
//        if result != EPOS2_SUCCESS.rawValue {
//            MessageView.showErrorEpos(result, method:"addText")
//            return false;
//        }
//        textData.setString("")
//
//        result = printer!.addFeedLine(2)
//        if result != EPOS2_SUCCESS.rawValue {
//            MessageView.showErrorEpos(result, method:"addFeedLine")
//            return false
//        }
//
//        //        result = printer!.addBarcode("01209457",
//        //                                     type:EPOS2_BARCODE_CODE39.rawValue,
//        //                                     hri:EPOS2_HRI_BELOW.rawValue,
//        //                                     font:EPOS2_FONT_A.rawValue,
//        //                                     width:barcodeWidth,
//        //                                     height:barcodeHeight)
//        //        if result != EPOS2_SUCCESS.rawValue {
//        //            MessageView.showErrorEpos(result, method:"addBarcode")
//        //            return false
//        //        }
//        //
//        result = printer!.addCut(EPOS2_CUT_FEED.rawValue)
//        if result != EPOS2_SUCCESS.rawValue {
//            MessageView.showErrorEpos(result, method:"addCut")
//            return false
//        }
//
//        return true
//    }
//
//    func createCouponData() -> Bool {
//        let barcodeWidth = 2
//        let barcodeHeight = 64
//
//        var result = EPOS2_SUCCESS.rawValue
//
//        if printer == nil {
//            return false
//        }
//
//        let coffeeData = UIImage(named: "coffee1.png")
//        let wmarkData = UIImage(named: "wmark1.png")
//
//        if coffeeData == nil || wmarkData == nil {
//            return false
//        }
//
//        result = printer!.addPageBegin()
//        if result != EPOS2_SUCCESS.rawValue {
//            MessageView.showErrorEpos(result, method:"addPageBegin")
//            return false
//        }
//
//        result = printer!.addPageArea(0, y:0, width:PAGE_AREA_WIDTH, height:PAGE_AREA_HEIGHT)
//        if result != EPOS2_SUCCESS.rawValue {
//            MessageView.showErrorEpos(result, method:"addPageArea")
//            return false
//        }
//
//        result = printer!.addPageDirection(EPOS2_DIRECTION_TOP_TO_BOTTOM.rawValue)
//        if result != EPOS2_SUCCESS.rawValue {
//            MessageView.showErrorEpos(result, method:"addPageDirection")
//            return false
//        }
//
//        result = printer!.addPagePosition(0, y:Int(coffeeData!.size.height))
//        if result != EPOS2_SUCCESS.rawValue {
//            MessageView.showErrorEpos(result, method:"addPagePosition")
//            return false
//        }
//
//        result = printer!.add(coffeeData, x:0, y:0,
//                              width:Int(coffeeData!.size.width),
//                              height:Int(coffeeData!.size.height),
//                              color:EPOS2_PARAM_DEFAULT,
//                              mode:EPOS2_PARAM_DEFAULT,
//                              halftone:EPOS2_PARAM_DEFAULT,
//                              brightness:3,
//                              compress:EPOS2_PARAM_DEFAULT)
//        if result != EPOS2_SUCCESS.rawValue {
//            MessageView.showErrorEpos(result, method:"addImage")
//            return false
//        }
//
//        result = printer!.addPagePosition(0, y:Int(wmarkData!.size.height))
//        if result != EPOS2_SUCCESS.rawValue {
//            MessageView.showErrorEpos(result, method:"addPagePosition")
//            return false
//        }
//
//        result = printer!.add(wmarkData, x:0, y:0,
//                              width:Int(wmarkData!.size.width),
//                              height:Int(wmarkData!.size.height),
//                              color:EPOS2_PARAM_DEFAULT,
//                              mode:EPOS2_PARAM_DEFAULT,
//                              halftone:EPOS2_PARAM_DEFAULT,
//                              brightness:Double(EPOS2_PARAM_DEFAULT),
//                              compress:EPOS2_PARAM_DEFAULT)
//
//        if result != EPOS2_SUCCESS.rawValue {
//            MessageView.showErrorEpos(result, method:"addImage")
//            return false
//        }
//
//        result = printer!.addPagePosition(FONT_A_WIDTH * 4, y:(PAGE_AREA_HEIGHT / 2) - (FONT_A_HEIGHT * 2))
//        if result != EPOS2_SUCCESS.rawValue {
//            MessageView.showErrorEpos(result, method:"addPagePosition")
//            return false
//        }
//
//        result = printer!.addTextSize(3, height:3)
//        if result != EPOS2_SUCCESS.rawValue {
//            MessageView.showErrorEpos(result, method:"addTextSize")
//            return false
//        }
//
//        result = printer!.addTextStyle(EPOS2_PARAM_DEFAULT, ul:EPOS2_PARAM_DEFAULT, em:EPOS2_TRUE, color:EPOS2_PARAM_DEFAULT)
//        if result != EPOS2_SUCCESS.rawValue {
//            MessageView.showErrorEpos(result, method:"addTextStyle")
//            return false
//        }
//
//        result = printer!.addTextSmooth(EPOS2_TRUE)
//        if result != EPOS2_SUCCESS.rawValue {
//            MessageView.showErrorEpos(result, method:"addTextSmooth")
//            return false
//        }
//
//        result = printer!.addText("FREE Coffee\n")
//        if result != EPOS2_SUCCESS.rawValue {
//            MessageView.showErrorEpos(result, method:"addText")
//            return false
//        }
//
//        result = printer!.addPagePosition((PAGE_AREA_WIDTH / barcodeWidth) - BARCODE_WIDTH_POS, y:Int(coffeeData!.size.height) + BARCODE_HEIGHT_POS)
//        if result != EPOS2_SUCCESS.rawValue {
//            MessageView.showErrorEpos(result, method:"addPagePosition")
//            return false
//        }
//
//        result = printer!.addBarcode("01234567890", type:EPOS2_BARCODE_UPC_A.rawValue, hri:EPOS2_PARAM_DEFAULT, font: EPOS2_PARAM_DEFAULT, width:barcodeWidth, height:barcodeHeight)
//        if result != EPOS2_SUCCESS.rawValue {
//            MessageView.showErrorEpos(result, method:"addBarcode")
//            return false
//        }
//
//        result = printer!.addPageEnd()
//        if result != EPOS2_SUCCESS.rawValue {
//            MessageView.showErrorEpos(result, method:"addPageEnd")
//            return false
//        }
//
//        result = printer!.addCut(EPOS2_CUT_FEED.rawValue)
//        if result != EPOS2_SUCCESS.rawValue {
//            MessageView.showErrorEpos(result, method:"addCut")
//            return false
//        }
//
//        return true
//    }
//
//    func printData() -> Bool {
//        var status: Epos2PrinterStatusInfo?
//
//        if printer == nil {
//            return false
//        }
//
//        if !connectPrinter() {
//            return false
//        }
//
//        status = printer!.getStatus()
//        // dispPrinterWarnings(status)
//
//        if !isPrintable(status) {
//            MessageView.show(makeErrorMessage(status))
//            printer!.disconnect()
//            return false
//        }
//
//        let result = printer!.sendData(Int(EPOS2_PARAM_DEFAULT))
//        if result != EPOS2_SUCCESS.rawValue {
//            MessageView.showErrorEpos(result, method:"sendData")
//            printer!.disconnect()
//            return false
//        }
//
//        return true
//    }
//
//    func initializePrinterObject() -> Bool {
//        printer = Epos2Printer(printerSeries: valuePrinterSeries.rawValue, lang: valuePrinterModel.rawValue)
//
//        if printer == nil {
//            return false
//        }
//        printer!.setReceiveEventDelegate(self)
//
//        return true
//    }
//
//    func finalizePrinterObject() {
//        if printer == nil {
//            return
//        }
//
//        printer!.clearCommandBuffer()
//        printer!.setReceiveEventDelegate(nil)
//        printer = nil
//    }
//
//    func connectPrinter() -> Bool {
//        var result: Int32 = EPOS2_SUCCESS.rawValue
//
//        if printer == nil {
//            return false
//        }
//
//        result = printer!.connect(Constants.Printer, timeout:Int(EPOS2_PARAM_DEFAULT))
//        if result != EPOS2_SUCCESS.rawValue {
//            MessageView.showErrorEpos(result, method:"connect")
//            return false
//        }
//
//        result = printer!.beginTransaction()
//        if result != EPOS2_SUCCESS.rawValue {
//            MessageView.showErrorEpos(result, method:"beginTransaction")
//            printer!.disconnect()
//            return false
//
//        }
//        return true
//    }
//
//    func disconnectPrinter() {
//        var result: Int32 = EPOS2_SUCCESS.rawValue
//
//        if printer == nil {
//            return
//        }
//
//        result = printer!.endTransaction()
//        if result != EPOS2_SUCCESS.rawValue {
//            DispatchQueue.main.async(execute: {
//                MessageView.showErrorEpos(result, method:"endTransaction")
//            })
//        }
//
//        result = printer!.disconnect()
//        if result != EPOS2_SUCCESS.rawValue {
//            DispatchQueue.main.async(execute: {
//                MessageView.showErrorEpos(result, method:"disconnect")
//            })
//        }
//
//        finalizePrinterObject()
//    }
//    func isPrintable(_ status: Epos2PrinterStatusInfo?) -> Bool {
//        if status == nil {
//            return false
//        }
//
//        if status!.connection == EPOS2_FALSE {
//            return false
//        }
//        else if status!.online == EPOS2_FALSE {
//            return false
//        }
//        else {
//            // print available
//        }
//        return true
//    }
//
//    func onPtrReceive(_ printerObj: Epos2Printer!, code: Int32, status: Epos2PrinterStatusInfo!, printJobId: String!) {
//        MessageView.showResult(code, errMessage: makeErrorMessage(status))
//
//        //dispPrinterWarnings(status)
//        //    updateButtonState(true)
//
//        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async(execute: {
//            self.disconnectPrinter()
//        })
//    }
//
//    //    func dispPrinterWarnings(_ status: Epos2PrinterStatusInfo?) {
//    //        if status == nil {
//    //            return
//    //        }
//    //
//    //        //        textWarnings.text = ""
//    //
//    //        if status!.paper == EPOS2_PAPER_NEAR_END.rawValue {
//    //          //  textWarnings.text = NSLocalizedString("warn_receipt_near_end", comment:"")
//    //        }
//    //
//    //        if status!.batteryLevel == EPOS2_BATTERY_LEVEL_1.rawValue {
//    //         //   textWarnings.text = NSLocalizedString("warn_battery_near_end", comment:"")
//    //        }
//    //    }
//
//    func makeErrorMessage(_ status: Epos2PrinterStatusInfo?) -> String {
//        let errMsg = NSMutableString()
//        if status == nil {
//            return ""
//        }
//
//        if status!.online == EPOS2_FALSE {
//            errMsg.append(NSLocalizedString("err_offline", comment:""))
//        }
//        if status!.connection == EPOS2_FALSE {
//            errMsg.append(NSLocalizedString("err_no_response", comment:""))
//        }
//        if status!.coverOpen == EPOS2_TRUE {
//            errMsg.append(NSLocalizedString("err_cover_open", comment:""))
//        }
//        if status!.paper == EPOS2_PAPER_EMPTY.rawValue {
//            errMsg.append(NSLocalizedString("err_receipt_end", comment:""))
//        }
//        if status!.paperFeed == EPOS2_TRUE || status!.panelSwitch == EPOS2_SWITCH_ON.rawValue {
//            errMsg.append(NSLocalizedString("err_paper_feed", comment:""))
//        }
//        if status!.errorStatus == EPOS2_MECHANICAL_ERR.rawValue || status!.errorStatus == EPOS2_AUTOCUTTER_ERR.rawValue {
//            errMsg.append(NSLocalizedString("err_autocutter", comment:""))
//            errMsg.append(NSLocalizedString("err_need_recover", comment:""))
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
//                errMsg.append(NSLocalizedString("err_wrong_paper", comment:""))
//            }
//        }
//        if status!.batteryLevel == EPOS2_BATTERY_LEVEL_0.rawValue {
//            errMsg.append(NSLocalizedString("err_battery_real_end", comment:""))
//        }
//
//        return errMsg as String
//    }
    
    
}
extension CheckOutPopView: UITextFieldDelegate {
    //amounttendered delegate
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == tenderedbalance {
            if let amount = Double(textField.text!) {
                viewModel.amountTendered = amount
            }
         //   NotificationCenter.default.post(name: Notification.Name("buttonpressed"), object: nil)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == tenderedbalance {
            //            let newText = (textField.text ?? "") + string
            
            if let text = textField.text,
                let textRange = Range(range, in: text) {
                let updatedText = text.replacingCharacters(in: textRange,
                                                           with: string)
                //backspace on last character
                if updatedText == "" {
                    viewModel.amountTendered = 0
                  //  NotificationCenter.default.post(name: Notification.Name("buttonpressed"), object: nil)
                    return true
                }
                let doub = Double(updatedText)
                
                //can input only double values in amount tendered
                if let doub = doub {
                    viewModel.amountTendered = doub
                    return true
                }
                else {
                    return false
                }
            }
        }
        return true
    }
}

extension CheckOutPopView: CashViewDelegate {
    func PayAmountTapped(amount: Double) {
        if let amountTender = tenderedbalance.text {
            if amountTender == "" || amountTender == "0" {
                tenderedbalance.text = String(format: "%.2f", amount)//"\(amount)"
                viewModel.amountTendered = amount
            }
            else {
                if let amountTenderDouble = Double(amountTender) {
                    let increamented = amount + amountTenderDouble
                    tenderedbalance.text = String(format: "%.2f", increamented)//"\(increamented)"
                    viewModel.amountTendered = increamented
                }
            }
        }
        //  on tapping quickbutton textdidendediting is not called so update here
        NotificationCenter.default.post(name: Notification.Name("buttonpressed"), object: nil)
        
    }
    
    
}





