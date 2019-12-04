//
//  CheckOutPopView.swift
//  Garage
//
//  Created by Amjad Ali on 8/5/18.
//  Copyright © 2018 Amjad Ali. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

struct Workers {
     static var usersdetail = [SubuserModel]()
}



class CheckOutPopView: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate,NVActivityIndicatorViewable  {
    
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
    @IBOutlet weak var SubtotalAmount: UILabel!
    @IBOutlet weak var DiscountAmount: UILabel!
    @IBOutlet weak var TaxAmount: UILabel!
    @IBOutlet weak var workerBtn: UIButton!
    @IBOutlet weak var assistantBtn: UIButton!
    @IBOutlet weak var checkoutoutlet: UIButton!
    @IBOutlet weak var grandtotalBtn: UIButton!
    @IBOutlet weak var tenderedbalance: UITextField!
    @IBOutlet weak var grandtotalLbl: UILabel!
    let dateFormatter : DateFormatter = DateFormatter()
    @IBOutlet weak var balancetxtf: UITextField!
    @IBOutlet weak var balacelbl: UILabel!
    @IBOutlet weak var discountContainer: UIView!
    @IBOutlet weak var taxLabel: UILabel!
    
    @IBOutlet weak var priceAllig: UILabel!
    
    @IBOutlet weak var mainviewtop: UIView!
    
    
    @IBOutlet weak var discountBtn: UIButton!
    
    private weak var subView: UIView?
    let viewModel = CheckoutViewModel()
    private var discountVC: DiscountPopViewController?
    var orderdetails = [Checkoutdetails]()
    var flag = 1      //this flag is used for cash and card: (cash = 1. card = 2, both = 3 (from cash total and checkout card frm card screen flag convering by checking))
    var cardcash: Double = 0.0
    var holdername: String = ""
    var cardnmb: NSNumber = 0
    var CheckoutObject = [CheckouObject]()
    var cartItemStructArray = [ReceiptModel]()
    var printerDetailModelUICells: [PrinterDetailCellUIModel]!
    var amount = [Constants.subtotal,Constants.checkoutdiscount,Constants.checkouttax]
    var workerid = 0
    var assistantid = 0
    var cashamount: Double = 0.0
    var cardamount: Double = 0.0
    
    
    //Localization
    
    let VAT = NSLocalizedString("VAT", comment: "")
    let selectWorker = NSLocalizedString("selectWorker", comment: "")
    let EnterAmount = NSLocalizedString("EnterAmount!", comment: "")
    let Discountcantgreater = NSLocalizedString("Discountcantgreater", comment: "")
    let CheckoutFailed = NSLocalizedString("CheckoutFailed", comment: "")
    let Discarded = NSLocalizedString("Discarded", comment: "")
    
    
    //Localization
    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
   
        discountContainer.isHidden = true
        self.navigationController?.isNavigationBarHidden = true
       // self.view.backgroundColor = UIColor.clear.withAlphaComponent(0.5)
        if let button = buttonstack.viewWithTag(1) as? UIButton {
            tabButtonaction(button)
        }
        tenderedbalance.delegate = self
        viewModel.checkoutVC = self
        checkout_tableview.delegate = self
        checkout_tableview.dataSource = self
        checkout_tableview.separatorStyle = .none
        
        setbuttonshadow()
        setCalculationUI()
        
        self.checkoutoutlet.setTitle(String(format: "%.2f SAR", Constants.checkoutGrandtotal), for: .normal)
        NotificationCenter.default.addObserver(self, selector: #selector(CheckOutPopView.userNotification(notification:)), name: Notification.Name("Notificationusername"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(CheckOutPopView.userNotificationAssist(notification:)), name: Notification.Name("NotificationusernameAsist"), object: nil)
        
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
        setUI()
        NotificationCenter.default.addObserver(self, selector: #selector(CheckOutPopView.printeradded(notification:)), name: Notification.Name("printerAdded"), object: nil)
        
        if L102Language.currentAppleLanguage() == "ar" {
            cashBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left:0, bottom: 30, right: 30)
            cardBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left:0, bottom: 30, right: 35)
            giftcardBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left:0, bottom: 30, right: 35)
            loyalityBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left:0, bottom: 30, right: 30)
            voucherBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left:0, bottom: 30, right: 35)
        }
        
        usersdetails()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        self.mainviewtop.addGestureRecognizer(tap)
    }
    


@objc func handleTap(){
    dismiss(animated: true, completion: nil)
    
}

    
    
    
    private func setUI() {
        viewModel.originalAmount = Constants.checkoutGrandtotal
    }
    
    func setCalculationUI() {
        
        SubtotalAmount.text = String(format: "%.2f", Constants.subtotal)
        DiscountAmount.text = String(format: "%.2f", Constants.checkoutdiscount)
        TaxAmount.text =  String(format: "%.2f", Constants.checkouttax)       
        taxLabel.text = "\(VAT) (\(Constants.percent)%)"
        if L102Language.currentAppleLanguage() == "ar" {
            SubtotalAmount.textAlignment = .left
            DiscountAmount.textAlignment = .left
            TaxAmount.textAlignment = .left
            
            priceAllig.textAlignment = .left
        }
        
        
    }
    
    
    func setbuttonshadow() {
    
        
        
        assistantBtn.layer.shadowColor = UIColor.gray.cgColor
        assistantBtn.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        assistantBtn.layer.masksToBounds = false
        assistantBtn.layer.shadowRadius = 1
        assistantBtn.layer.shadowOpacity = 0.5
        
        
        
        workerBtn.layer.shadowColor = UIColor.gray.cgColor
        workerBtn.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        workerBtn.layer.masksToBounds = false
        workerBtn.layer.shadowRadius = 1
        workerBtn.layer.shadowOpacity = 0.5
        
        discountBtn.layer.shadowColor = UIColor.gray.cgColor
        discountBtn.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        discountBtn.layer.masksToBounds = false
        discountBtn.layer.shadowRadius = 1
        discountBtn.layer.shadowOpacity = 0.5
    
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
                balancetxtf.text =  String(format: "%.2f", blnce)
            }
            
        }
        
    }
    
    
    @objc func userNotification(notification: Notification) {
     //   if Constants.workerflag == 1 {
            self.workerBtn.setTitle("\(Constants.FullName)", for: .normal)
            Constants.checkoutmechanic = Constants.FullName
            workerid = Constants.SubUserID
     //       Constants.workerflag = 0
//        } else {
//            self.assistantBtn.setTitle("\(Constants.FullName)", for: .normal)
//            assistantid = Constants.SubUserID
//        }
        
    }
    
    @objc func userNotificationAssist(notification: Notification) {
        
            self.assistantBtn.setTitle("\(Constants.FullNameAsis)", for: .normal)
        Constants.checkoutAssistant = Constants.FullNameAsis
            assistantid = Constants.SubUserIDAssist
        
        
    }
    
    
    
    
    
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("printerAdded"), object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name("Notificationusername"), object: nil)
         NotificationCenter.default.removeObserver(self, name: Notification.Name("NotificationusernameAsist"), object: nil)
        
    }
    
    
    
    
    
    @IBAction func dismissCheckout(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var returnvalue = 0
        returnvalue = Checkoutstruct.sentitems.count
        return returnvalue
    }
    
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellcheckout") as! checkoutcell
        if L102Language.currentAppleLanguage() == "ar" {
            cell.productlabel.text = Checkoutstruct.sentitems[indexPath.row].AlternateName
            let qty = Checkoutstruct.sentitems[indexPath.row].Quantity
            cell.Qtylabel.text = "\(qty ?? 0)"
            let price = Checkoutstruct.sentitems[indexPath.row].Price
            cell.pricelabel.text =  "\(price!.myRounded(toPlaces: 2))"
            cell.productlabel.textAlignment = .right
            cell.pricelabel.textAlignment = .left
            
        } else {
            cell.productlabel.text = Checkoutstruct.sentitems[indexPath.row].Name
            let qty = Checkoutstruct.sentitems[indexPath.row].Quantity
            cell.Qtylabel.text = "\(qty ?? 0)"
            let price = Checkoutstruct.sentitems[indexPath.row].Price
            cell.pricelabel.text =  "\(price!.myRounded(toPlaces: 2))"
        }
        
       
        cell.selectionStyle = .none
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.separatorColor = UIColor.gray
        return CGFloat(40)
        
    }
    
    func  usersdetails()  {
        
        let url = URL(string: "\(CallEngine.baseURL)\(CallEngine.subusers)\(Constants.sessions)")
        URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                if let bay = json["SubuserList"] as? [[String: Any]] {
                    Workers.usersdetail.removeAll()
                    for SubUser in bay {
                        let subUser = SubuserModel(SubUser: SubUser)
                        Workers.usersdetail.append(subUser!)
                    }
                    
                }
            } catch let error as NSError {
                print(error)
            }
        }).resume()
        
        
    }
    
    
    
    
    @IBAction func workerAction(_ sender: Any) {
        Constants.workerflag = 1
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
        popover?.sourceView = self.workerBtn
        popover?.sourceRect = self.workerBtn.bounds//CGRect(x: self.assignBtn.bounds.midX, y: self.assignBtn.bounds.midY, width: 0, height: 0)
        self.present(nav, animated: true, completion: nil)
    }
    
    
    
    @IBAction func AssistantAction(_ sender: Any) {
        var storyboard: UIStoryboard!
        var popController: UIViewController!
        storyboard = UIStoryboard(name: "subuserAsist", bundle: nil)
        popController = storyboard.instantiateViewController(withIdentifier: "SubusersAsistVc") as! SubuserAssist
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
    
    
    func toggleContianerViews() {
        if discountContainer.isHidden {
            self.containerPop.isHidden = true
            self.discountContainer.isHidden = false
        }
        else {
            self.containerPop.isHidden = false
            self.discountContainer.isHidden = true
        }
    }
    
    @IBAction func discountAction(_ sender: Any) {
        
        if discountVC == nil {
            discountVC =  DiscountPopViewController(nibName: "DiscountPopViewController", bundle: nil)
            Common.addChildController(childController: discountVC!, onParent: self, onView: self.discountContainer)
            discountVC!.delegate = self
        }
        toggleContianerViews()
        
        
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
            if ((Double(temp2)) > (Double(Constants.checkoutGrandtotal))) || ((Double(temp2)) < (Double(Constants.checkoutGrandtotal))) {
                
                cardamount = Double(tenderedbalance.text!)!
                cashamount = Double(temp!)!
                if ((Double(cashamount)) == (Double(Constants.checkoutGrandtotal.myRounded(toPlaces: 2)))) {
                    flag = 1
                }
                
                if ((Double(cashamount)) < (Double(Constants.checkoutGrandtotal.myRounded(toPlaces: 2))))  && (Double(cashamount)) != 0.0 {
                    
                    flag = 3
                }
                cardcash = Double(temp!)! + Double(balancetxtf.text!)!
                balancetxtf.text = "0"
                
            } else {
                balancetxtf.text =  String(format: "%.2f", temp2)
            }
        }
        else {
            tenderedbalance.text = "0"
        }
    }
    
    func toggleLblBalanceHeading() {
        if balacelbl.text == LocalizedString.Balance {
            balacelbl.text = LocalizedString.Return
        }
        else {
            balacelbl.text = LocalizedString.Balance
        }
    }
    
    
    func updateAmountTenderForCashView() {
        flag = 1
        tenderedbalance.isEnabled = true
        viewModel.amountTendered = viewModel.cashAmountTender
        tenderedbalance.text = String(format: "%g", viewModel.amountTendered)
    }
    
    
    
    
    @IBAction func discartBtn(_ sender: Any) {
        alert(view: self, title: LocalizedString.Alert, message: Discarded)
    }
    
    
    
    @IBAction func Printletter(_ sender: Any) {
        
    }
    
    
    
    
    
    func UnlistApi() {
        
        let parameters = [
            "AmountDiscount": 0,
            Constants.PaymentMode: 1,
            "Gratuity": 0,
            Constants.CarID:  Constants.checkoutcarid,
            Constants.GrandTotal: 0,
            "ServiceCharges": 0,
            Constants.AmountTotal: 0,
            "PartialPayment": 0,
            Constants.OrderID: Constants.checkoutorderid,
            Constants.Date: Constants.currentdate,
            Constants.SessionID: Constants.sessions,
            Constants.WorkerID: workerid,
            Constants.AmountPaid: 0,
            "OrderStatus": 105,
            "AmountComplementary": 0,
            Constants.Tax: 0,
            "CheckoutDetails": [[
            "CardHolderName": "",
            "AmountPaid": 0,
            "CardType": "",
            "AmountDiscount": 0,
            "PaymentMode": 1,
            "CardNumber": ""
            ]],
            Constants.AssistantID: assistantid,
            ]  as [String : Any]
        
      //  let url = URL(string: "\(CallEngine.baseURL)\(CallEngine.Unlist)")!
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
                    ToastView.show(message: LocalizedString.interneterror, controller: self)
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

                            ToastView.show(message: newmessage!, controller: self)
                            
                            
                        }
                        
                    }
                        
                    else if (status == 1000) {
                        
                        DispatchQueue.main.async {

                            ToastView.show(message: LocalizedString.wrong, controller: self)
                            
                        }
                        
                    }
                        
                    else if (status == 1001) {
                        
                        DispatchQueue.main.async {

                            ToastView.show(message: LocalizedString.invalid, controller: self)
                            
                        }
                        
                    }
                        
                    else  {
                        DispatchQueue.main.async {

                            ToastView.show(message: LocalizedString.occured, controller: self)
                            
                        }
                        
                    }
                    
                } catch {
                    print(error)
                    ToastView.show(message: LocalizedString.occured, controller: self)
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
        print(Constants.checkoutdiscount)
        
        if flag == 2 ||  flag == 3 {
            if cardcash >= Constants.checkoutGrandtotal.myRounded(toPlaces: 2)   {
                status()
                if cardtype == "" {
                    ToastView.show(message: LocalizedString.PleaseselectCard, controller: self)

                }
                else {
                    if Constants.checkoutmechanic != "" {
                        
                        if flag == 3 {
                            CheckoutObject.removeAll()
                            
                            let object = CheckouObject(CardNumber: "\(cardnmb)", CardHolderName: holdername, CardType: cardtype, AmountPaid: cardamount.myRounded(toPlaces: 2), AmountDiscount: 0.0, PaymentMode: 2)
                            CheckoutObject.append(object)
                            let object1 = CheckouObject(CardNumber: "", CardHolderName: "", CardType: "", AmountPaid: cashamount.myRounded(toPlaces: 2), AmountDiscount: 0.0, PaymentMode: 1)
                            CheckoutObject.append(object1)
                            Constants.CashAmountcheckout = cashamount.myRounded(toPlaces: 2) // for receipt multi (during checkout)
                            Constants.CardAmountcheckout = cardamount.myRounded(toPlaces: 2)
                            Constants.CardTypecheckout = cardtype
                            
                        } else if flag == 2 {
                            CheckoutObject.removeAll()
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
                                             "AmountDiscount": Constants.checkoutdiscount,
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
                                    ToastView.show(message: LocalizedString.interneterror, controller: self)
                                }
                            }
                            if let response = response {
                                print(response)
                            }
                            
                            if let data = data {
                                print(data)
                                do {
                                    self.startAnimating(message: Constants.wait, messageFont: UIFont(name:"SFProDisplay-Bold", size: 18.0), type: .ballPulse, color: UIColor.DefaultApp)
                                    guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {return}
                                    print(json)
                                    
                                    let status = json[Constants.Status] as? Int
                                    let newmessage = json[Constants.Description] as? String
                                    if (status == 1) {
                                        ToastView.show(message: newmessage!, controller: self)
                                        
                                        DispatchQueue.main.async {
                                            Constants.paymentflag = self.flag
                                            
                                            self.printerreceipt()
                                            //   self.runPrinterReceiptSequence()
                                            NotificationCenter.default.post(name: Notification.Name("checkoutDone"), object: nil)
                                            self.dismiss(animated: true, completion: nil)
                                            self.grandtotalBtn.isUserInteractionEnabled = true
                                            self.stopAnimating()
                                        }
                                        
                                    }
                                    else if (status == 0) {
                                        
                                        DispatchQueue.main.async {
                                            self.stopAnimating()
                                            ToastView.show(message: newmessage!, controller: self)
                                            self.grandtotalBtn.isUserInteractionEnabled = true
                                        }
                                        
                                    }
                                        
                                    else if (status == 1000) {
                                        
                                        DispatchQueue.main.async {
                                            self.stopAnimating()
                                            ToastView.show(message: LocalizedString.wrong, controller: self)
                                            self.grandtotalBtn.isUserInteractionEnabled = true
                                        }
                                        
                                    }
                                        
                                    else if (status == 1001) {
                                        
                                        DispatchQueue.main.async {
                                            self.stopAnimating()
                                            ToastView.show(message: LocalizedString.invalid, controller: self)
                                            self.grandtotalBtn.isUserInteractionEnabled = true
                                        }
                                        
                                    }
                                        
                                    else if (status == 1005) {
                                        
                                        DispatchQueue.main.async {
                                            self.stopAnimating()
                                            ToastView.show(message: newmessage!, controller: self)
                                            self.grandtotalBtn.isUserInteractionEnabled = true
                                        }
                                    }
                                        
                                    else  {
                                        DispatchQueue.main.async {
                                            self.stopAnimating()
                                            ToastView.show(message: LocalizedString.occured, controller: self)
                                            self.grandtotalBtn.isUserInteractionEnabled = true
                                        }
                                        
                                    }
                                    
                                    
                                } catch {
                                    print(error)
                                    self.stopAnimating()
                                    ToastView.show(message: LocalizedString.occured, controller: self)
                                    self.grandtotalBtn.isUserInteractionEnabled = true
                                    
                                }
                                
                                
                            }
                            
                            }.resume()
                        
                    }   else {
                        ToastView.show(message: selectWorker, controller: self)
                        self.grandtotalBtn.isUserInteractionEnabled = true
                        
                    }
                    
                }
                
            }
        } else if flag == 1 {
            
            let test2 = (Double(tenderedbalance.text!) ?? Double.nan).myRounded(toPlaces: 2)
            if (test2) >= Constants.checkoutGrandtotal.myRounded(toPlaces: 2)  || cashamount >= Constants.checkoutGrandtotal.myRounded(toPlaces: 2) {
                print(test2 )
                
                if Constants.checkoutmechanic != "" {
                    CheckoutObject.removeAll()
                    let object = CheckouObject(CardNumber: "\(cardnmb)", CardHolderName: holdername, CardType: "", AmountPaid: Constants.checkoutGrandtotal.myRounded(toPlaces: 2), AmountDiscount: 0.0, PaymentMode: flag)
                    CheckoutObject.append(object)
                    
                    let encoder = JSONEncoder()
                    encoder.outputFormatting = .prettyPrinted
                    let data1 = try! encoder.encode(CheckoutObject)
                    guard let object1 = try? JSONSerialization.jsonObject(with: data1, options: []) as? Any else {return}
                    
                    let parameters = [   Constants.OrderID: Constants.checkoutorderid,
                                         Constants.SessionID: Constants.sessions,
                                         Constants.PaymentMode: flag,
                                         Constants.Date: Constants.currentdate,
                                         Constants.AmountTotal: Constants.subtotal.myRounded(toPlaces: 2),
                                         "OrderStatus": 103,
                                         Constants.AmountPaid: tenderedbalance.text!,
                                         Constants.GrandTotal: Constants.checkoutGrandtotal.myRounded(toPlaces: 2),
                                         "AmountDiscount": Constants.checkoutdiscount,
                                         "PartialPayment": 0,
                                         "Gratuity": 0,
                                         "ServiceCharges": 0,
                                         Constants.CarID:  Constants.checkoutcarid,
                                         Constants.Tax: Constants.checkouttax.myRounded(toPlaces: 2),
                                         Constants.WorkerID: workerid,
                                         Constants.AssistantID: assistantid,
                                         "AmountComplementary": 0,
                                         Constants.CheckoutDetails: object1 ] as [String : Any]
                    
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
                                ToastView.show(message: LocalizedString.interneterror, controller: self)
                            }
                        }
                        if let response = response {
                            print(response)
                        }
                        
                        
                        if let data = data {
                            print(data)
                            do {
                                 self.startAnimating(message: Constants.wait, messageFont: UIFont(name:"SFProDisplay-Bold", size: 18.0), type: .ballPulse, color: UIColor.DefaultApp)
                                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {return}
                                print(json)
                                
                                let status = json[Constants.Status] as? Int
                                let newmessage = json[Constants.Description] as? String
                                if (status == 1) {
                                    ToastView.show(message: newmessage!, controller: self)
                                    
                                    DispatchQueue.main.async {
                                        Constants.paymentflag = self.flag
                                        self.printerreceipt()
                                        //   self.runPrinterReceiptSequence()
                                        NotificationCenter.default.post(name: Notification.Name("checkoutDone"), object: nil)
                                        self.dismiss(animated: true, completion: nil)
                                        self.grandtotalBtn.isUserInteractionEnabled = true
                                        self.stopAnimating()
                                        
                                    }
                                    
                                }
                                else if (status == 0) {
                                    
                                    DispatchQueue.main.async {
                                        self.stopAnimating()
                                        ToastView.show(message: newmessage!, controller: self)
                                        self.grandtotalBtn.isUserInteractionEnabled = true
                                    }
                                    
                                }
                                    
                                else if (status == 1000) {
                                    
                                    DispatchQueue.main.async {
                                        self.stopAnimating()
                                        ToastView.show(message: LocalizedString.wrong, controller: self)
                                        self.grandtotalBtn.isUserInteractionEnabled = true
                                    }
                                    
                                }
                                    
                                else if (status == 1001) {
                                    
                                    DispatchQueue.main.async {
                                        self.stopAnimating()
                                        ToastView.show(message: LocalizedString.invalid, controller: self)
                                        self.grandtotalBtn.isUserInteractionEnabled = true
                                    }
                                    
                                }
                                else if (status == 1005) {
                                    
                                    DispatchQueue.main.async {
                                        self.stopAnimating()
                                        ToastView.show(message: newmessage!, controller: self)
                                        self.grandtotalBtn.isUserInteractionEnabled = true
                                    }
                                }
                                    
                                else  {
                                    DispatchQueue.main.async {
                                        self.stopAnimating()
                                        ToastView.show(message: LocalizedString.occured, controller: self)
                                        self.grandtotalBtn.isUserInteractionEnabled = true
                                    }
                                    
                                }
                                
                                
                            } catch {
                                print(error)
                                self.stopAnimating()
                                ToastView.show(message: LocalizedString.occured, controller: self)
                                self.grandtotalBtn.isUserInteractionEnabled = true
                                
                            }                            
                            
                        }
                        
                        }.resume()
                    
                }   else {
                    ToastView.show(message: selectWorker, controller: self)
                    self.grandtotalBtn.isUserInteractionEnabled = true
                    
                }
            } else {
                ToastView.show(message: EnterAmount, controller: self)
                self.grandtotalBtn.isUserInteractionEnabled = true
             
                
            }
        }
    }
    
    
    func status() {
        
        
        if let subView = subView as? CardView {
            if let cardHolder = subView.cardHolderName {
                holdername = cardHolder
                
            }
            
            if let cardNo = subView.cardNo, let cardInt = Int(cardNo) {
                let myNumber = NSNumber(value: cardInt)
                cardnmb = myNumber
                
            }
        }
    }
    
    
    
    
    
    @IBAction func CheckoutBtn(_ sender: Any) {
        self.grandtotalBtn.isUserInteractionEnabled = true
        checkoutOrder()
        
    }
    
    
    
    func printerreceipt() {
        
        for receipt in Checkoutstruct.sentitems {
            
            let cartItemStruct = ReceiptModel(Name: receipt.Name!, AlternateName: receipt.AlternateName, Price: receipt.Price!, ItemID: receipt.ItemID!, Quantity: receipt.Quantity!, Mode: "new", OrderDetailID: receipt.OrderDetailID!, Status: 1)
            cartItemStructArray.append(cartItemStruct)
            self.dismiss(animated: true, completion: nil)
        }
        
        
        let orderToPrint = Orderdetail.init(OrderDetailID: 12, OrderID: 12, ItemID: 1, ItemName: "Amjad", AlternateName: "Ali", ItemImage: "store.png", Quantity: 32, Price: 21, TotalCost: 11, LOYALTYPoints: 1, StatusID: 2, ItemDate: Constants.currentdate, Mode: "new", orderPrinterType: PrinterType.checkout)
        
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
        let defaultAction = UIAlertAction(title: "Yes", style: .destructive, handler: { action in
            self.UnlistApi()
        })
        
        alert.addAction(defaultAction)
        let cancel = UIAlertAction(title: "No", style: .default, handler: { action in
        })
        
        alert.addAction(cancel)
        DispatchQueue.main.async(execute: {
            view.present(alert, animated: true)
        })
    }
}


extension CheckOutPopView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == tenderedbalance {
            if let amount = Double(textField.text!) {
                viewModel.amountTendered = amount
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == tenderedbalance {
            if let text = textField.text,
                let textRange = Range(range, in: text) {
                let updatedText = text.replacingCharacters(in: textRange,
                                                           with: string)
                //backspace on last character
                if updatedText == "" {
                    viewModel.amountTendered = 0
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

extension CheckOutPopView: DiscountPopDelegate {
    func discountApplyPressed(viewController: UIViewController) {
        print("apply pressed in checkoutpopup")
        
        validateDiscount { [weak self] (valid) in
            if let this = self, valid {
                this.toggleContianerViews()
                this.viewModel.calculateAndUpdateUI()
                NotificationCenter.default.post(name: Notification.Name("buttonpressed"), object: nil)
                
            } else {
                Common.resetAllRecords(in: "Discount")
            }
        }
    }
    
    func discountCancelPressed(viewController: UIViewController) {
        print("cancel pressed in checkoutpopup")
        viewModel.calculateAndUpdateUI()
        toggleContianerViews()
        NotificationCenter.default.post(name: Notification.Name("buttonpressed"), object: nil)
    }
    
    private func validateDiscount(completion: @escaping (Bool)->()) {
        guard let discountVC = discountVC else { completion(false) ; return }
        if let textAmountEntered = discountVC.numPadVC?.txtFieldAmountEnter.text {
            if let amountEntered = Double(textAmountEntered) {
                guard let value = discountVC.selectedDiscountType //DiscountType(rawValue: selectedType.rawValue)
                    else { return }
                
                switch value {
                case .Amount:
                    if amountEntered > Constants.subtotal {
                        ToastView.show(message: Discountcantgreater, controller: self)

                        completion(false)
                        return
                    } else if amountEntered == Constants.subtotal {
                        setFullDiscount()
                    }
                case .Percentage:
                    
                    let discounttotal = Constants.subtotal * (amountEntered / 100)
                    let afterDiscountTotal = Constants.subtotal - discounttotal
                    if afterDiscountTotal < 0 {
                        ToastView.show(message: Discountcantgreater, controller: self)
                        completion(false)
                        return
                    } else if afterDiscountTotal == 0 {
                        setFullDiscount()
                    }
                    
                case .Trend:
                    print("Trend")
                }
                setCalculationUI()
                
                
                completion(true)
                return
            }
            
        }
        
    }
    
    private func setFullDiscount() {
        self.tenderedbalance.text = "0"
    }
}



