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
    @IBOutlet weak var balacelbl: UILabel!
    
    private weak var subView: UIView?
    var orderdetails = [Checkoutdetails]()
    var flag = 1      //this flag is used for cash and card: (cash = 1. card = 3, both = 3 (from cash total and checkout card frm card screen flag convering by checking))
    var cardcash: Double = 0.0
    var holdername: String = ""
    var cardnmb: NSNumber = 0
    var CheckoutObject = [CheckouObject]()
    //    var printer: Epos2Printer?
    //    var valuePrinterSeries: Epos2PrinterSeries = EPOS2_TM_M10
    //    var valuePrinterModel: Epos2ModelLang = EPOS2_MODEL_ANK
    
    var cartItemStructArray = [ReceiptModel]()
    var printerDetailModelUICells: [PrinterDetailCellUIModel]!
    
    var dummyData = ["SubTotal","Discount","VAT \(Constants.percent)%"]
    var amount = [Constants.subtotal,0.00,Constants.checkouttax]
    var workerid = 0
    var assistantid = 0
    let viewModel = CheckoutViewModel()
    var cashamount: Double = 0.0
    var cardamount: Double = 0.0
    
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
        
        self.checkoutoutlet.setTitle(String(format: "%.2f SAR", Constants.checkoutGrandtotal), for: .normal)
        //(format: "%.2f", (Constants.checkoutGrandtotal)
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
            
        } else if tenderedbalance.text == "" {
            balancetxtf.text = String(format: "%.2f", Constants.checkoutGrandtotal)
            //tenderedbalance.text = "0"
        } else {
            
            let intFromString = Double(tenderedbalance.text!)
            if ((Double(intFromString!)) > (Double(Constants.checkoutGrandtotal))) {
                balancetxtf.text = "0"
            } else {
                let blnce = Constants.checkoutGrandtotal - intFromString!
                balancetxtf.text = String(format: "%.2f", blnce)
            }
            
        }
        
        
    }
    
    //    func update() {
    //        if flag == 1 {
    //            let temp = tenderedbalance.text
    //            tenderedbalance.text = balancetxtf.text
    //            balancetxtf.text = temp
    //        flag = 0
    //
    //
    //    }
    //    }
    
    
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
            cell.pricelabel.text =  "\(price!.myRounded(toPlaces: 2))"
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
    
    
    
    
    
    func updateAmountTenderForCardView() {
        flag = 2
        let cashAmount = viewModel.amountTendered
        viewModel.cashAmountTender = cashAmount
        
        // guard let _ = subView as? CardView else { return }
        tenderedbalance.isEnabled = false
        if  flag == 2 {
            if tenderedbalance.text == "" {
                tenderedbalance.text = "0"
            }
            let temp = tenderedbalance.text
            
            
            let temp2 = (Double(temp!)! + Double(balancetxtf.text!)! - Constants.checkoutGrandtotal.myRounded(toPlaces: 2))
            
            tenderedbalance.text = balancetxtf.text
            if ((Double(temp2)) > (Double(Constants.checkoutGrandtotal))) || ((Double(temp2)) < (Double(Constants.checkoutGrandtotal)))         {
                
                cardamount = Double(tenderedbalance.text!)!
                cashamount = Double(temp!)!
                
                //                if (Double(cardamount)) == 0.0 {
                //
                //
                //                    flag = 1
                //                }
                if ((Double(cashamount)) == (Double(Constants.checkoutGrandtotal.myRounded(toPlaces: 2)))) {
                    
                    
                    flag = 1
                }
                
                if ((Double(cashamount)) < (Double(Constants.checkoutGrandtotal.myRounded(toPlaces: 2))))  && (Double(cashamount)) != 0.0 {
                    
                    
                    flag = 3
                }
                
                cardcash = Double(temp!)! + Double(balancetxtf.text!)!
                
                balancetxtf.text = "0"
                //                let new = Double(balancetxtf.text!)!
                
            } else {
                balancetxtf.text =  String(format: "%.2f", temp2)
            }
            
            
            //(temp2
            
            // toggleLblBalanceHeading()
        }
        else {
            tenderedbalance.text = "0"
        }
    }
    
    func toggleLblBalanceHeading() {
        if balacelbl.text == "Balance" {
            //  balancetxtf.textColor = UIColor.black
            balacelbl.text = "Return"
        }
        else {
            // balancetxtf.textColor = UIColor.black
            balacelbl.text = "Balance"
        }
    }
    
    
    func updateAmountTenderForCashView() {
        flag = 1
        tenderedbalance.isEnabled = true
        viewModel.amountTendered = viewModel.cashAmountTender
        //        if balacelbl.text == "Return" {
        //        balacelbl.text = "Balance"
        //        }
        tenderedbalance.text = String(format: "%g", viewModel.amountTendered)
    }
    
    
    
    
    @IBAction func discartBtn(_ sender: Any) {
        alert(view: self, title: "Alert", message: "Do you want to Discard the order?")
    }
    
    
    
    @IBAction func Printletter(_ sender: Any) {
        
        let printController = UIPrintInteractionController.shared
        let printInfo = UIPrintInfo(dictionary: [:])
        printInfo.outputType = UIPrintInfoOutputType.general
        printInfo.orientation = UIPrintInfoOrientation.portrait
        printInfo.jobName = "Sample"
        printController.printInfo = printInfo
       // printController.showsPageRange = true
        printController.printingItem = NSData(contentsOf: URL(string: "https://www.adobe.com/support/products/enterprise/knowledgecenter/media/c4611_sample_explain.pdf")!)
        
        printController.present(animated: true) { (controller, completed, error) in
            if(!completed && error != nil){
                DispatchQueue.main.async {
                    let messageVC = UIAlertController(title: "Failed ", message: "Image not found!" , preferredStyle: .actionSheet)
                    self.present(messageVC, animated: true) {
                        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { (_) in
                            messageVC.dismiss(animated: true, completion: nil)})}
                }
            }
            else if(completed) {
                DispatchQueue.main.async {
                    let messageVC = UIAlertController(title: "Sucess ", message: "Printed succesfully" , preferredStyle: .actionSheet)
                    self.present(messageVC, animated: true) {
                        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { (_) in
                            messageVC.dismiss(animated: true, completion: nil)})}
                }
            }
        }
    }
    
    
    
    
    
    func UnlistApi() {
        
        let parameters = [
            Constants.OrderID: Constants.checkoutorderid,
            //  Constants.BayID: Constants.bayid,
            Constants.type: "unlist",
            Constants.SessionID: Constants.sessions]  as [String : Any]
        
        let url = URL(string: "\(CallEngine.baseURL)\(CallEngine.Unlist)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions.prettyPrinted) else { return }
        request.httpBody = httpBody
        let jsonS = NSString(data: httpBody, encoding: String.Encoding.utf8.rawValue)
        if let json = jsonS {
            print(json)
        }
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if response == nil {
                DispatchQueue.main.async {
                    ToastView.show(message: "failed! Check internet", controller: self)
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
                            NotificationCenter.default.post(name: Notification.Name("checkoutDone"), object: nil)
                            self.dismiss(animated: true, completion: nil)
                            
                        }
                    }
                    else if (status == 0) {
                        
                        DispatchQueue.main.async {
                            let messageVC = UIAlertController(title: "Failed ", message: "\(newmessage!)" , preferredStyle: .actionSheet)
                            self.present(messageVC, animated: true) {
                                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { (_) in
                                    messageVC.dismiss(animated: true, completion: nil)})}
                            ToastView.show(message: newmessage!, controller: self)
                            
                        }
                        
                    }
                        
                    else if (status == 1000) {
                        
                        DispatchQueue.main.async {
                            let messageVC = UIAlertController(title: "Failed ", message: "\(Constants.wrong)" , preferredStyle: .actionSheet)
                            self.present(messageVC, animated: true) {
                                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { (_) in
                                    messageVC.dismiss(animated: true, completion: nil)})}
                            ToastView.show(message: newmessage!, controller: self)
                            
                        }
                        
                    }
                        
                    else if (status == 1001) {
                        
                        DispatchQueue.main.async {
                            let messageVC = UIAlertController(title: "Failed ", message: "\(Constants.invalid)" , preferredStyle: .actionSheet)
                            self.present(messageVC, animated: true) {
                                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { (_) in
                                    messageVC.dismiss(animated: true, completion: nil)})}
                            ToastView.show(message: newmessage!, controller: self)
                            
                        }
                        
                    }
                        
                    else  {
                        DispatchQueue.main.async {
                            let messageVC = UIAlertController(title: "Failed ", message: "\(Constants.occured)" , preferredStyle: .actionSheet)
                            self.present(messageVC, animated: true) {
                                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { (_) in
                                    messageVC.dismiss(animated: true, completion: nil)})}
                            ToastView.show(message: newmessage!, controller: self)
                            
                        }
                        
                    }
                    
                } catch {
                    print(error)
                    ToastView.show(message: "Edit Failed! error occured", controller: self)
                    self.dismiss(animated: true, completion: nil)
                }
                
            }
            }.resume()
    }
    
    
    
    
    
    
    
    @IBAction func tabButtonaction(_ sender: UIButton) {
        
        var voucherNibView:  VoucherView!
        var loyalityNibView: LoyaltyView!
        var giftCardNibView: GiftCardView!
        //var cardNibView:     CardView!
        var cashNibView:     CashView!
        
        removeNibViews()
        checkboxDidTap(sender: sender)
        
        switch sender.tag {
            
        case 1:
            cashNibView = Bundle.main.loadNibNamed(Constants.CashView, owner: self, options: nil)?[0] as? CashView
            cashNibView.frame.size = containerPop.frame.size
            updateAmountTenderForCashView()
            cashNibView.delegate = self
            self.containerPop.addSubview(cashNibView)
            
            
            
        case 2:
            subView = Bundle.main.loadNibNamed(Constants.CardView, owner: self, options: nil)?[0] as? CardView
            subView!.frame.size = containerPop.frame.size
            updateAmountTenderForCardView()
            self.containerPop.addSubview(subView!)
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
        
        
        
        
        
        //        let test = ["CardNumber": "", "CardHolderName": "", "CardType": "", "AmountPaid": Constants.checkoutGrandtotal.myRounded(toPlaces: 2), "AmountDiscount": 0.0, "PaymentMode": flag] as [String : Any]
        print(Constants.checkoutmechanic)
        
        if flag == 2 ||  flag == 3 {
            
            //let test2 = (Double(tenderedbalance.text!) ?? Double.nan).myRounded(toPlaces: 2)
            if Constants.checkoutGrandtotal.myRounded(toPlaces: 2) == cardcash  {
                status()
                if cardtype == "" {
                    let messageVC = UIAlertController(title: "Alert", message: "Please select Card" , preferredStyle: .actionSheet)
                    self.present(messageVC, animated: true) {
                        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { (_) in
                            messageVC.dismiss(animated: true, completion: nil)})}
                }
                    //                else if holdername == "" {
                    //                    let messageVC = UIAlertController(title: "Alert", message: "Please enter Holdername" , preferredStyle: .actionSheet)
                    //                    self.present(messageVC, animated: true) {
                    //                        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { (_) in
                    //                            messageVC.dismiss(animated: true, completion: nil)})}
                    //                } else if cardnmb == 0 {
                    //                    let messageVC = UIAlertController(title: "Alert", message: "Please enter Cardnmber" , preferredStyle: .actionSheet)
                    //                    self.present(messageVC, animated: true) {
                    //                        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { (_) in
                    //                            messageVC.dismiss(animated: true, completion: nil)})}
                    //                }
                else {
                    if Constants.checkoutmechanic != "" {
                        
                        if flag == 3 {
                            
                            let object = CheckouObject(CardNumber: "\(cardnmb)", CardHolderName: holdername, CardType: cardtype, AmountPaid: cardamount.myRounded(toPlaces: 2), AmountDiscount: 0.0, PaymentMode: 2)
                            CheckoutObject.append(object)
                            let object1 = CheckouObject(CardNumber: "", CardHolderName: "", CardType: "", AmountPaid: cashamount.myRounded(toPlaces: 2), AmountDiscount: 0.0, PaymentMode: 1)
                            CheckoutObject.append(object1)
                            
                            
                        } else if flag == 2 {
                            let object = CheckouObject(CardNumber: "\(cardnmb)", CardHolderName: holdername, CardType: cardtype, AmountPaid: Constants.checkoutGrandtotal.myRounded(toPlaces: 2), AmountDiscount: 0.0, PaymentMode: flag)
                            CheckoutObject.append(object)
                            
                        }
                        
                        let encoder = JSONEncoder()
                        encoder.outputFormatting = .prettyPrinted
                        let data1 = try! encoder.encode(CheckoutObject)
                        guard let object = try? JSONSerialization.jsonObject(with: data1, options: []) as? Any else {return}
                        
                        
                        
                        
                        
                        let parameters = [   Constants.OrderID: Constants.checkoutorderid,
                                             Constants.SessionID: Constants.sessions,
                                             "PaymentMode": flag,
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
                                             "CheckoutDetails": object as Any ] as [String : Any]
                        
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
                        let messageVC = UIAlertController(title: "Checkout Failed", message: "Please select Worker!" , preferredStyle: .actionSheet)
                        present(messageVC, animated: true) {
                            Timer.scheduledTimer(withTimeInterval:1.0, repeats: false, block: { (_) in
                                messageVC.dismiss(animated: true, completion: nil)})}
                        self.grandtotalBtn.isUserInteractionEnabled = true
                        
                    }
                    
                    
                    
                    
                    
                }
                
            }
        } else if flag == 1 {
            
            
            
            let test2 = (Double(tenderedbalance.text!) ?? Double.nan).myRounded(toPlaces: 2)
            if (test2) >= Constants.checkoutGrandtotal.myRounded(toPlaces: 2)  || cashamount >= Constants.checkoutGrandtotal.myRounded(toPlaces: 2) {
                print(test2 )
                
                if Constants.checkoutmechanic != "" {
                    
                    let object = CheckouObject(CardNumber: "\(cardnmb)", CardHolderName: holdername, CardType: "", AmountPaid: Constants.checkoutGrandtotal.myRounded(toPlaces: 2), AmountDiscount: 0.0, PaymentMode: flag)
                    CheckoutObject.append(object)
                    
                    let encoder = JSONEncoder()
                    encoder.outputFormatting = .prettyPrinted
                    let data1 = try! encoder.encode(CheckoutObject)
                    guard let object1 = try? JSONSerialization.jsonObject(with: data1, options: []) as? Any else {return}
                    
                    
                    
                    let parameters = [   Constants.OrderID: Constants.checkoutorderid,
                                         Constants.SessionID: Constants.sessions,
                                         "PaymentMode": flag,
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
                                         "CheckoutDetails": object1 ] as [String : Any]
                    
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
                    let messageVC = UIAlertController(title: "Checkout Failed", message: "Please select Worker!" , preferredStyle: .actionSheet)
                    present(messageVC, animated: true) {
                        Timer.scheduledTimer(withTimeInterval:1.0, repeats: false, block: { (_) in
                            messageVC.dismiss(animated: true, completion: nil)})}
                    self.grandtotalBtn.isUserInteractionEnabled = true
                    
                }
            } else {
                let messageVC = UIAlertController(title: "Checkout Failed", message: "Please Enter Total Amount!" , preferredStyle: .actionSheet)
                present(messageVC, animated: true) {
                    Timer.scheduledTimer(withTimeInterval:1.0, repeats: false, block: { (_) in
                        messageVC.dismiss(animated: true, completion: nil)})}
                self.grandtotalBtn.isUserInteractionEnabled = true
                
                
            }
        }
    }
    
    
    
    
    //    func updateQuickButtonAmount(){
    //        if let view = containerPop as? CashView   {
    //           view.updateFirstButtonAmount()
    //        }
    //    }
    
    
    func status() {
        
        
        if let subView = subView as? CardView {
            if let cardHolder = subView.cardHolderName {
                holdername = cardHolder
                
            }
            
            if let cardNo = subView.cardNo, let cardInt = Int(cardNo) {
                let myNumber = NSNumber(value: cardInt)
                cardnmb = myNumber
                
            }
            //let card = PaymentMethod.card.description
        }
    }
    
    
    
    
    
    @IBAction func CheckoutBtn(_ sender: Any) {
        
        //         if flag == 1 {
        //            print("Paid from card")
        //        } else if flag == 0 {
        //            print("Paid by cash")
        //        }
        
        self.grandtotalBtn.isUserInteractionEnabled = true
        //        if Constants.Printer == "" {
        //           alert(view: self, title: "Printer is not connected", message: "Do you want to add Printer from Settings")
        //        } else {
        checkoutOrder()
        //        }
        //
        
    }
    
    
    
    func printerreceipt() {
        
        for receipt in Checkoutstruct.sentitems {
            
            let cartItemStruct = ReceiptModel(Name: receipt.Name!, Price: receipt.Price!, ItemID: receipt.ItemID!, Quantity: receipt.Quantity!, Mode: "new", OrderDetailID: receipt.OrderDetailID!, Status: 1)
            
            cartItemStructArray.append(cartItemStruct)
            self.dismiss(animated: true, completion: nil)
            
            
        }
        
        
        
        
        
        
        let orderToPrint = Orderdetail.init(OrderDetailID: 12, OrderID: 12, ItemID: 1, ItemName: "Amjad", ItemImage: "store.png", Quantity: 32, Price: 21, TotalCost: 11, LOYALTYPoints: 1, StatusID: 2, ItemDate: Constants.currentdate, Mode: "new", orderPrinterType: PrinterType.checkout)
        
        PrintJobHelper.addCheckoutOrderInPrinterQueue(orderDetails: orderToPrint, cartItems:cartItemStructArray)
        
    }
    
    
    
    
    
    
    
    func settings() {
        
        let screenSize = UIScreen.main.bounds.width
        let screenheight = UIScreen.main.bounds.size.height
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
            self.UnlistApi()
            
        })
        
        alert.addAction(defaultAction)
        let cancel = UIAlertAction(title: "No", style: .default, handler: { action in
            //self.dismiss(animated: true, completion: nil)
        })
        
        //        cancel.tintColor = UIColor.red
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
    
    
    
}
extension CheckOutPopView: UITextFieldDelegate {
    //amounttendered delegate
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == tenderedbalance {
            if let amount = Double(textField.text!) {
                viewModel.amountTendered = amount
            }
            //   NotificationCenter.default.post(name: Notification.Name("buttonpressed"), object: nil)0
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





