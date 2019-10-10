//
//  CheckoutView.swift
//  Garage
//
//  Created by Amjad Ali on 6/13/18.
//  Copyright © 2018 Amjad Ali. All rights reserved.
//

import UIKit

struct Checkoutstruct {
    static var Itemdetails = [checkoutItems]()
    static var sentitems = [checkoutItems]()
}

class CheckoutView: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var tableViewContainer: UITableView!
    @IBOutlet weak var checkoutSegment: UISegmentedControl!
    
    @IBOutlet weak var headerlabel: UILabel!
    var checkoutmodel = [CheckoutModel]()
    var cartItemStructArray = [ReceiptModel]()
    var PDFLetter: String = ""
    private let dataModel = GeneralViewController()
    var newVariableName = GeneralViewController()
    var newVariableName2 = GeneralViewController()
    
    
    //Localization
    
    let BayAr = NSLocalizedString("Bay", comment: "")
    let Action = NSLocalizedString("Action", comment: "")
    let Status = NSLocalizedString("Status", comment: "")
    let Checkout = NSLocalizedString("Checkout", comment: "")
    let Done = NSLocalizedString("Done", comment: "")
    let ZebraPrinterAr = NSLocalizedString("ZebraPrinter", comment: "")
    let Reprint = NSLocalizedString("Reprint", comment: "")
    let AirPrint = NSLocalizedString("AirPrint", comment: "")
    let Edit = NSLocalizedString("Edit", comment: "")
    let PrintingSucuess  = NSLocalizedString("sucessfully", comment: "")
    
    //Localization
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewContainer.dataSource = self
        tableViewContainer.delegate = self
        checkoutSegment.selectedSegmentIndex = 1
        CheckoutDetails()
        Constants.editcheckout = 0
        Constants.percent = Int(Double(Constants.tax)! * 100)
        NotificationCenter.default.addObserver(self, selector: #selector(CheckoutView.checkoutDone(notification:)), name: Notification.Name("checkoutDone"), object: nil)
        
    }
    
    deinit {
        
        NotificationCenter.default.removeObserver(self, name: Notification.Name("checkoutDone"), object: nil)
    }
    
    
    
    
    
    @objc func checkoutDone(notification: Notification) {
        self.CheckoutDetails()
    }
    
    
    func CheckoutDetails() {
        
        var Apiurl = ""
        switch (checkoutSegment.selectedSegmentIndex) {
            
        case 0:
            Apiurl = "\(CallEngine.baseURL)\(CallEngine.checkoutwork)\(Constants.sessions)"
        case 1:
            Apiurl = "\(CallEngine.baseURL)\(CallEngine.checkoutHold)\(Constants.sessions)"
        case 2:
            Apiurl = "\(CallEngine.baseURL)\(CallEngine.checkoutDone)\(Constants.sessions)"
        default:
            break
        }
        self.checkoutSegment.isUserInteractionEnabled = false
        DispatchQueue.main.async {
            self.showloader()
            
        }
        let url = URL(string: Apiurl)
        
        URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
            if response == nil {
                DispatchQueue.main.async {
                    ToastView.show(message: LocalizedString.interneterror, controller: self)
                    self.dismiss(animated: true, completion: nil)
                    self.checkoutSegment.isUserInteractionEnabled = true
                }
            }
            guard let data = data, error == nil else { return }
            do {
                
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                
                let status = json[Constants.Status] as? Int
                let discript = json[Constants.Description] as? String
                if (status == 1) {
                    if let order = json[Constants.OrdersList] as? [[String: Any]] {
                        self.checkoutmodel.removeAll()
                        Checkoutstruct.Itemdetails.removeAll()
                        for items in order {
                            if let item = items[Constants.OrderItems] as? [[String: Any]] {
                                for details in item {
                                    let Name = details["ItemName"] as? String  ?? ""
                                    let AlternateName = details["AlternateName"] as? String  ?? ""
                                    let Price = details["Price"] as! Double
                                    let ItemID = details["ItemID"] as! Int
                                    let Quantity = details["Quantity"] as! Int
                                    let OrderDetails = details["OrderDetailID"] as! Int
                                    let itemorderID = details["OrderID"] as! Int
                                    let itemsdetailed = checkoutItems(Name: Name,AlternateName: AlternateName, Price: Price, ItemID: ItemID, Quantity: Quantity,OrderDetailID: OrderDetails, itemorderid: itemorderID)
                                    Checkoutstruct.Itemdetails.append(itemsdetailed)
                                }
                                
                            }
                        }
                        
                        for checkoutlist in order {
                            //                            if let items = checkoutlist["OrderItems"] as? AnyObject{
                            //                                CheckoutItems.Itemdetails.append(items as! CheckoutItems)
                            //                            }
                            print(checkoutlist)
                            print(order)
                            let details = CheckoutModel(checkoutlist: checkoutlist)
                            self.checkoutmodel.append(details!)
                            
                        }
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                        
                        self.dismiss(animated: true, completion: nil)
                        self.tableViewContainer.reloadData()
                        self.checkoutSegment.isUserInteractionEnabled = true
                    })
                }
                else if (status == 0) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                        self.dismiss(animated: true, completion: nil)
                        ToastView.show(message: discript!, controller: self)
                        self.checkoutSegment.isUserInteractionEnabled = true
                    })
                }
                    
                else if (status == 1000) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                        self.dismiss(animated: true, completion: nil)
                        ToastView.show(message: LocalizedString.wrong, controller: self)
                        self.checkoutSegment.isUserInteractionEnabled = true
                    })
                }
                    
                else if (status == 1001) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                        self.dismiss(animated: true, completion: nil)
                        ToastView.show(message: LocalizedString.invalid, controller: self)
                        self.checkoutSegment.isUserInteractionEnabled = true
                    })
                }
                    
                else  {
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                        self.dismiss(animated: true, completion: nil)
                        ToastView.show(message: LocalizedString.occured, controller: self)
                        self.checkoutSegment.isUserInteractionEnabled = true
                    })
                }
                
            } catch let error as NSError {
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                    self.checkoutSegment.isUserInteractionEnabled = true
                    ToastView.show(message: "\(error)", controller: self)
                }
            }
        }).resume()
        DispatchQueue.main.async {
            self.tableViewContainer.reloadData()
        }
        
    }
    
    func showloader() {
        let alert = UIAlertController(title: nil, message: Constants.wait, preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        loadingIndicator.startAnimating();
        loadingIndicator.backgroundColor = UIColor.DefaultApp
        loadingIndicator.layer.cornerRadius = 18.0
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func segmentAction(_ sender: Any) {
        CheckoutDetails()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var returnValue = 0
        switch (checkoutSegment.selectedSegmentIndex) {
        case 0:
            
            returnValue = checkoutmodel.count
            
        case 1:
            returnValue = checkoutmodel.count
        case 2:
            
            returnValue = checkoutmodel.count
            
        default:
            break
        }
        return returnValue
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    {
        var returnValue = [AnyObject]()
        
        switch (checkoutSegment.selectedSegmentIndex) {
        case 0:
            
            print("nothing")
            
        case 1:
            let deleteAction = UITableViewRowAction(style: .destructive, title: Edit) { (action, indexpath) in
                DispatchQueue.main.async {
                    Constants.editcheckout = 1
                    Constants.editOrderid = self.checkoutmodel[indexPath.row].OrderID!
                    Constants.bayid = self.checkoutmodel[indexPath.row].BayID!
                    // Constants.carliterID = self.checkoutmodel[indexPath.row].
                    
                    if let parentVC = self.parent as? ReceptionalistView {
                        let storyboard = UIStoryboard(name: Constants.ServiceCart, bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: Constants.ServiceCartVc) as? ServiceCartView
                        parentVC.switchViewController(vc: vc!, showFooter: false)
                        
                    }
                    
                }
            }
            
           
            returnValue = [deleteAction]
            deleteAction.backgroundColor = .DefaultApp

            
        case 2:
            
            
            let Rprint = UITableViewRowAction(style: .destructive, title: Reprint) { (action, indexpath) in
                DispatchQueue.main.async {
                    
                    Checkoutstruct.sentitems.removeAll()
                    Constants.checkoutorderid = self.checkoutmodel[indexPath.row].OrderID!
                    Constants.checkoutcarid = self.checkoutmodel[indexPath.row].CarID!
                    Constants.checkoutplatenmb = self.checkoutmodel[indexPath.row].RegistrationNo!
                    Constants.checkoutvin = self.checkoutmodel[indexPath.row].VinNo!
                    Constants.checkoutcarmake = self.checkoutmodel[indexPath.row].MakerName!
                    Constants.checkoutcarmodel = self.checkoutmodel[indexPath.row].ModelName!
                    Constants.checkoutbayname = self.checkoutmodel[indexPath.row].BayName!
                    Constants.checkoutyear = self.checkoutmodel[indexPath.row].Year!
                    Constants.checkoutcustm = self.checkoutmodel[indexPath.row].CustomerID!
                    Constants.checkoutplatenmb1 = self.checkoutmodel[indexPath.row].RegistrationNoP1!
                    Constants.checkoutplatenmb2 = self.checkoutmodel[indexPath.row].RegistrationNoP2!
                    Constants.checkoutplatenmb3 = self.checkoutmodel[indexPath.row].RegistrationNoP3!
                    Constants.checkoutplatenmb4 = self.checkoutmodel[indexPath.row].RegistrationNoP4!
                    Constants.Checkoutdate = self.checkoutmodel[indexPath.row].CheckoutDate!
                    Constants.checkoutmechanic = self.checkoutmodel[indexPath.row].MechanicName!
                    Constants.checkoutstatus = self.checkoutmodel[indexPath.row].Status!
                    Constants.checkoutorderNo = self.checkoutmodel[indexPath.row].TransactionNo!
                    Constants.CardType = self.checkoutmodel[indexPath.row].CardType!
                    Constants.PaymentModes = self.checkoutmodel[indexPath.row].PaymentMode!
                    Constants.CashAmount = self.checkoutmodel[indexPath.row].CashAmount!
                    Constants.CardAmount = self.checkoutmodel[indexPath.row].CardAmount!
                    Constants.subtotal = self.checkoutmodel[indexPath.row].AmountTotal!
                    Constants.checkoutGrandtotal = self.checkoutmodel[indexPath.row].GrandTotal!
                    Constants.checkouttax = self.checkoutmodel[indexPath.row].Tax!
                    Constants.checkoutdiscount = self.checkoutmodel[indexPath.row].AmountDiscount!
                    
                    for itemmodels in Checkoutstruct.Itemdetails {
                        if itemmodels.itemorderid == Constants.checkoutorderid {
                            
                            Checkoutstruct.sentitems.append(itemmodels)
                        } else if itemmodels.itemorderid != Constants.checkoutorderid {
                            
                        }
                    }
                    self.printerreceipt()
                    
                    
                }
            }
            
            
            let AirPrinter = UITableViewRowAction(style: .destructive, title: AirPrint) { (action, indexpath) in
                DispatchQueue.main.async {
                    
                    Constants.checkoutPDF = self.checkoutmodel[indexPath.row].OrderID!
                    self.PdfPrinter()
                }
            }
            
            
            let ZebraPrinter = UITableViewRowAction(style: .destructive, title: ZebraPrinterAr) { (action, indexpath) in
                DispatchQueue.main.async {
                    Constants.ZRegistr = self.checkoutmodel[indexPath.row].OilType!
                    Constants.ZKm = self.checkoutmodel[indexPath.row].CheckLitre!
                    //let date1 = self.checkoutmodel[indexPath.row].CheckoutDate!
                    Constants.FilterName = self.checkoutmodel[indexPath.row].FilterName!
                    let dateFormatter : DateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd/MM/yyyy"
                    let date = Date()
                    Constants.Zdate = dateFormatter.string(from: date)
                    print(Constants.Zdate)
                    print(Constants.FilterName)
                    self.ZebraPrinter()
                    
                }
            }
            
            returnValue = [AirPrinter, Rprint, ZebraPrinter]
            //AirPrinter.backgroundColor = UIColor(patternImage: UIImage(named: "diesel.png")!)
            AirPrinter.backgroundColor = UIColor.red
            Rprint.backgroundColor = UIColor.DefaultApp
            ZebraPrinter.backgroundColor = UIColor.orange
            
            
        default:
            break
        }
        return returnValue as? [UITableViewRowAction]
        
    }
    
    
    
    func PdfPrinter() {
        
        guard let url = URL(string: "\(CallEngine.baseURL)\(CallEngine.Printerletter)\(Constants.checkoutPDF)/\(Constants.sessions)") else { return }
        print("\(url)")
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response,  error) in
            if response == nil {
                DispatchQueue.main.async {
                    ToastView.show(message: LocalizedString.interneterror, controller: self)
                    
                }
            }
            if let data = data {
                do {
                    guard  let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {return}
                    let discript = json[Constants.Description] as? String
                    if let status = json[Constants.Status] as? Int {
                        if (status == 1) {
                            print(json)
                            if let printer = json["Path"] as? String {
                                if printer != "" {
                                    DispatchQueue.main.async {
                                        print(printer)
                                        
                                        self.PDFLetter = printer
                                        self.Printletter()
                                    }
                                } else {
                                    DispatchQueue.main.async {
                                        
                                        
                                        ToastView.show(message: "PDF not found", controller: self)
                                    }
                                }
                            }
                        }
                        else if (status == 0) {
                            ToastView.show(message: discript!, controller: self)
                        }
                            
                        else if (status == 1000) {
                            ToastView.show(message: LocalizedString.wrong, controller: self)
                        }
                            
                        else if (status == 1001) {
                            ToastView.show(message: LocalizedString.invalid, controller: self)
                        }
                            
                        else {
                            ToastView.show(message: LocalizedString.occured, controller: self)
                        }
                        
                    }
                    
                } catch let error as NSError {
                    print(error)
                    ToastView.show(message: "failed! Try Again", controller: self)
                }
                
            }
            }.resume()
    }
    
    
    func Printletter() {
        
        let printController = UIPrintInteractionController.shared
        let printInfo = UIPrintInfo(dictionary: [:])
        printInfo.outputType = UIPrintInfoOutputType.general
        printInfo.orientation = UIPrintInfoOrientation.portrait
        printInfo.jobName = "Sample"
        printController.printInfo = printInfo
        // printController.showsPageRange = true
        //http://www.pdf995.com/samples/pdf.pdf
        print(self.PDFLetter)
        printController.printingItem = NSData(contentsOf: URL(string:  self.PDFLetter)!)
        printController.present(animated: true) { (controller, completed, error) in
            if(!completed && error != nil){
                DispatchQueue.main.async {
                    ToastView.show(message: "Image not found", controller: self)
                }
            }
            else if(completed) {
                DispatchQueue.main.async {
                    ToastView.show(message: self.PrintingSucuess, controller: self)
                }
            }
        }
    }
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckoutCell", for: indexPath) as! CheckoutCell
        
        switch (checkoutSegment.selectedSegmentIndex) {
        case 0:
            headerlabel.text = BayAr
            headerlabel.textColor = UIColor.white
            headerlabel.font = UIFont(name: "SFProDisplay-Bold", size: 19)
            print(indexPath)
            print(indexPath.row)
            print(checkoutSegment.selectedSegmentIndex)
            cell.CPlatenmb.text = checkoutmodel[indexPath.row].RegistrationNo
            cell.CMake.text = checkoutmodel[indexPath.row].MakerName
            cell.CModel.text = checkoutmodel[indexPath.row].ModelName
            let trans = checkoutmodel[indexPath.row].TransactionNo
            cell.CSerialnmb.text = "\(trans!)"
            let Bay = checkoutmodel[indexPath.row].BayName
            cell.checkoutBtn.tag = indexPath.row
            cell.checkoutBtn.setTitle(Bay, for: .normal)
            cell.checkoutBtn.setTitleColor(UIColor.DefaultApp, for: .normal)
            cell.checkoutBtn.titleLabel!.font = UIFont(name: "SFProDisplay-Bold" , size: 17)
            cell.checkoutBtn.imageView?.isHidden = true
            cell.checkoutBtn.isUserInteractionEnabled = false
            
            
        case 1:
            headerlabel.text = Action
            headerlabel.textColor = UIColor.white
            headerlabel.font = UIFont(name: "SFProDisplay-Bold", size: 19)
            print(indexPath)
            print(indexPath.row)
            cell.checkoutBtn.isUserInteractionEnabled = true
            print(checkoutSegment.selectedSegmentIndex)
            cell.CPlatenmb.text = checkoutmodel[indexPath.row].RegistrationNo
            cell.CMake.text = checkoutmodel[indexPath.row].MakerName
            cell.CModel.text = checkoutmodel[indexPath.row].ModelName
            cell.checkoutBtn.tag = indexPath.row
            cell.checkoutBtn.setTitle(Checkout, for: .normal)
            cell.checkoutBtn.setTitleColor(UIColor.DefaultApp, for: .normal)
            cell.checkoutBtn.titleLabel!.font = UIFont(name: "SFProDisplay-Bold" , size: 17)
            cell.checkoutBtn.addTarget(self, action:#selector(self.addccheckout(_:)), for: .touchUpInside)
            let trans2 = checkoutmodel[indexPath.row].TransactionNo
            cell.CSerialnmb.text = "\(trans2!)"
            
        case 2:
            headerlabel.text = Status
            headerlabel.textColor = UIColor.white
            headerlabel.font = UIFont(name: "SFProDisplay-Bold", size: 19)
            cell.checkoutBtn.isUserInteractionEnabled = true
            print(indexPath)
            print(indexPath.row)
            print(checkoutSegment.selectedSegmentIndex)
            cell.CPlatenmb.text = checkoutmodel[indexPath.row].RegistrationNo
            cell.CMake.text = checkoutmodel[indexPath.row].MakerName
            cell.CModel.text = checkoutmodel[indexPath.row].ModelName
            //  let Bay = checkoutmodel[indexPath.row].BayName
            cell.checkoutBtn.tag = indexPath.row
            let status = checkoutmodel[indexPath.row].Status
            if status == 105 {
                cell.checkoutBtn.setTitle("Cancelled", for: .normal)
                cell.checkoutBtn.setTitleColor(UIColor.red, for: .normal)
                cell.checkoutBtn.titleLabel!.font = UIFont(name: "SFProDisplay-Bold" , size: 17)
                
            } else  {
                cell.checkoutBtn.setTitle(Done, for: .normal)
                cell.checkoutBtn.setTitleColor(UIColor.DefaultApp, for: .normal)
                cell.checkoutBtn.titleLabel!.font = UIFont(name: "SFProDisplay-Bold" , size: 17)
            }
            
            cell.checkoutBtn.imageView?.isHidden = true
            //   cell.checkoutBtn.isUserInteractionEnabled = false
            //   cell.editBtn.addTarget(self, action:#selector(self.add2(_:)), for: .touchUpInside)
            let trans3 = checkoutmodel[indexPath.row].TransactionNo
            cell.CSerialnmb.text = "\(trans3!)"
        default:
            break
        }
        cell.selectionStyle = .none
        
        return cell
        
    }
    
    
    @objc func addccheckout(_ sender: UIButton){
        switch (checkoutSegment.selectedSegmentIndex) {
            
        case 0:
            print("Not any functionality")
            //            ToastView.show(message: "Under Development! Be patient (Assigned)", controller: self)
            
        case 1:
            Checkoutstruct.sentitems.removeAll() 
            Constants.checkoutorderid = checkoutmodel[sender.tag].OrderID!
            Constants.checkoutcarid = checkoutmodel[sender.tag].CarID!
            Constants.checkoutplatenmb = checkoutmodel[sender.tag].RegistrationNo!
            Constants.checkoutvin = checkoutmodel[sender.tag].VinNo!
            Constants.checkoutcarmake = checkoutmodel[sender.tag].MakerName!
            Constants.checkoutcarmodel = checkoutmodel[sender.tag].ModelName!
            Constants.checkoutbayname = checkoutmodel[sender.tag].BayName!
            Constants.checkoutyear = checkoutmodel[sender.tag].Year!
            Constants.checkoutcustm = checkoutmodel[sender.tag].CustomerID!
            Constants.checkoutplatenmb1 = checkoutmodel[sender.tag].RegistrationNoP1!
            Constants.checkoutplatenmb2 = checkoutmodel[sender.tag].RegistrationNoP2!
            Constants.checkoutplatenmb3 = checkoutmodel[sender.tag].RegistrationNoP3!
            Constants.checkoutplatenmb4 = checkoutmodel[sender.tag].RegistrationNoP4!
            Constants.checkoutplatenmb4 = checkoutmodel[sender.tag].RegistrationNoP4!
            Constants.checkoutmechanic = checkoutmodel[sender.tag].MechanicName!
            Constants.checkoutstatus = checkoutmodel[sender.tag].Status!
            Constants.checkoutorderNo = checkoutmodel[sender.tag].TransactionNo!
            
            Constants.subtotal = 0.0
            Constants.checkoutGrandtotal = 0.0
            Constants.checkouttax = 0.0
            for itemmodels in Checkoutstruct.Itemdetails {
                
                if itemmodels.itemorderid == Constants.checkoutorderid {
                    
                    Constants.checkoutGrandtotal = Constants.checkoutGrandtotal + itemmodels.Price!
                    
                    Checkoutstruct.sentitems.append(itemmodels)
                } else if itemmodels.itemorderid != Constants.checkoutorderid {
                
                }
            }
            
            
            
            Constants.checkoutdiscount = 0.00        
            Constants.subtotal = Constants.checkoutGrandtotal
            Constants.checkouttax = Constants.checkoutGrandtotal * Double(Constants.tax)!
            Constants.checkoutGrandtotal =  Constants.checkoutGrandtotal + Constants.checkouttax
            checkoutpop()
            
            
        case 2:
            print("Not any functionality")
            
        default:
            break
        }
    }
    
    
    func printerreceipt() {
        
        for receipt in Checkoutstruct.sentitems {
            
            let cartItemStruct = ReceiptModel(Name: receipt.Name!, AlternateName: receipt.AlternateName, Price: receipt.Price!, ItemID: receipt.ItemID!, Quantity: receipt.Quantity!, Mode: "new", OrderDetailID: receipt.OrderDetailID!, Status: 1)
            cartItemStructArray.append(cartItemStruct)
            
        }
        
        
        let orderToPrint = Orderdetail.init(OrderDetailID: 12, OrderID: 12, ItemID: 1, ItemName: "Amjad", AlternateName: "Ali", ItemImage: "store.png", Quantity: 32, Price: 21, TotalCost: 11, LOYALTYPoints: 1, StatusID: 2, ItemDate: Constants.currentdate, Mode: "new", orderPrinterType: PrinterType.checkout)
        PrintJobHelper.addCheckoutOrderInPrinterQueue(orderDetails: orderToPrint, cartItems:cartItemStructArray)
    }
    
    
    
    func checkoutpop() {
        let screenSize = UIScreen.main.bounds.width
        let screenheight = UIScreen.main.bounds.size.height
        print(screenheight)
        var storyboard: UIStoryboard!
        var popController: UIViewController!
        storyboard = UIStoryboard(name: Constants.CheckoutPopUp, bundle: nil)
        popController = storyboard.instantiateViewController(withIdentifier: Constants.CheckOutPopVc) as! CheckOutPopView
        popController.modalPresentationStyle = .popover
        let popOverVC = popController.popoverPresentationController
        popOverVC?.delegate = self
        popOverVC?.sourceView = self.view
        popOverVC?.permittedArrowDirections = UIPopoverArrowDirection(rawValue:0)
        popOverVC?.sourceRect = CGRect(x: screenSize, y: screenheight*0.70, width: 0, height: 0)
        popController.preferredContentSize = CGSize(width: screenSize, height: screenheight*0.70)
        self.present(popController, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.separatorColor = UIColor.gray
        return CGFloat(60)
    }
    
    

    
    @IBAction func settings(_ sender: Any) {
        setupsettings()
    }
    
    
    
    func setupsettings()  {
        let screenSize = UIScreen.main.bounds.width
        let screenheight = UIScreen.main.bounds.size.height
        print(screenheight)
        var storyboard: UIStoryboard!
        var popController: UIViewController!
        storyboard = UIStoryboard(name: "SettingsViewController", bundle: nil)
        popController = storyboard.instantiateViewController(withIdentifier: "SettingViewControllerVc") as! SettingsViewController
        popController.modalPresentationStyle = .popover
        let popOverVC = popController.popoverPresentationController
        popOverVC?.delegate = self
        popOverVC?.sourceView = self.view
        popOverVC?.permittedArrowDirections = UIPopoverArrowDirection(rawValue:0)
        popOverVC?.sourceRect = CGRect(x: screenSize, y: screenheight*0.80, width: 0, height: 0)
        popController.preferredContentSize = CGSize(width: screenSize, height: screenheight*0.80)
        self.present(popController, animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    func getLanguageName(_ language: PrinterLanguage) -> String? {
        if language == PRINTER_LANGUAGE_ZPL {
            return "ZPL"
        } else  {
            return "CPCL"
            
            
        }
    }
    
    func ZebraPrinter() {
        
        Constants.zebra = UserDefaults.standard.string(forKey: "Zprinter") ?? ""
        
        if Constants.zebra == "" { 
            ToastView.show(message: "Zebra Printer Not Selected", controller: self)
        }else {
            
            var connection: (ZebraPrinterConnection & NSObjectProtocol)? = nil
            //        ip.text = UserDefaults.standard.string(forKey: "Zprinter")!
            let ipAddress = Constants.zebra
            let portAsString = "6101"
            let por = Int(portAsString) ?? 0
            
            connection = TcpPrinterConnection(address: ipAddress, andWithPort: por)
            let didOpen = connection?.open()
            
            
            if didOpen == true {
                // self.setStatus("Connected...",UIColor.green)
                print("Connected")
                
                
                //    self.setStatus("Determining Printer Language...",UIColor.yellow)
                print("Determining Printer Language")
                
                var error: Error? = nil
                var printer = try? ZebraPrinterFactory.getInstance(connection)
                
                if printer != nil {
                    let language = printer?.getControlLanguage()
                    //   self.setStatus("Printer Language \(getLanguageName(language!) ?? "nil")",UIColor.cyan)
                    print("Printer Language")
                    //  self.setStatus("Sending Data",UIColor.cyan)
                    print("Sending Data")
                    let sentOK = printTestLabel(language!, onConnection: connection!)
                    
                    
                    if sentOK == true {
                        //                    self.setStatus("Test Label Sent",UIColor.green)
                        //                    Sending Data
                    } else {
                        //   self.setStatus("Test Label Failed to Print",UIColor.red)
                    }
                } else {
                    //    self.setStatus("Could not Detect Language",UIColor.red)
                }
            }else{
                // self.setStatus("Could not connect to printer",UIColor.red)
                ToastView.show(message: "Something wrong in Zebra Printer", controller: self)
            }
            // self.setStatus("Disconnecting...",UIColor.red)
            
            //printed.
            connection?.close()
            //  performingDemo = false
            
            
            // self.setStatus("Not Connected",UIColor.red)
            
            
            //PrintBtn.isEnabled = true
        }
    }
    
    
    
    func printTestLabel(_ language: PrinterLanguage, onConnection connection: (ZebraPrinterConnection & NSObjectProtocol)) -> Bool {
        var testLabel = ""
        var err : NSError?
        if language == PRINTER_LANGUAGE_ZPL {
            testLabel = "^XA^FWN,^CF0,30,^FT200,70^FD\(Constants.ZRegistr)^FS,^FT200,80^GB250,1,4^FS,^CF0,30,^FT200,120,^FDKM:  \(Constants.ZKm)^FS,^FT200,130^GB250,1,4^FS,^CF0,30,^FT200,170^FD\(Constants.FilterName)^FS,^FT200,180^GB250,1,4^FS,^CF0,30,^FT200,220^FDDate:  \(Constants.Zdate)^FS,,^FT200,230^GB250,1,4^FS^CF0,30,^XZ"
            //"^XA^FWN,^CF0,30,^FT200,70^FDOil Type:  \(Constants.ZRegistr)^FS,^FT200,80^GB250,1,5^FS,^CF0,30,^FT200,120,^FDKM:  \(Constants.ZKm)^FS,^FT200,130^GB250,1,5^FS,^CF0,30,^FT200,170^FDOil Filter:  \(Constants.FilterName)^FS,^FT200,180^GB250,1,5^FS,^CF0,30,^FT200,220^FDDate:  \(Constants.Zdate)^FS,,^FT200,230^GB250,1,5^FS^CF0,20,^XZ"
            let data = testLabel.data(using: .utf8)!
            connection.write(data, error: &err)
            
        } else if language == PRINTER_LANGUAGE_CPCL {
            
            testLabel = "! 0 200 200 406 1\r\nON-FEED IGNORE\r\nBOX 20 20 380 380 8\r\nT 0 6 137 177 Test\r\nPRINT\r\n"
            
            let data = testLabel.data(using: .utf8)!
            
            connection.write(data, error: &err)
        }
        if err == nil
        {
            return true
        }else
        {
            return false
        }
    }
    
    
    
    
    
}


