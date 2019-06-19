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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewContainer.dataSource = self
        tableViewContainer.delegate = self
        checkoutSegment.selectedSegmentIndex = 1
        CheckoutDetails()
        Constants.editcheckout = 0
        Constants.percent = Int(Double(Constants.tax)! * 100)
        NotificationCenter.default.addObserver(self, selector: #selector(CheckoutView.checkoutDone(notification:)), name: Notification.Name("checkoutDone"), object: nil)
        
        //  Constants.Printer = UserDefaults.standard.string(forKey: "printer") ?? ""
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
                    ToastView.show(message: Constants.interneterror, controller: self)
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
                    if let order = json["OrdersList"] as? [[String: Any]] {
                        self.checkoutmodel.removeAll()
                        Checkoutstruct.Itemdetails.removeAll()
                        
                        for items in order {
                            if let item = items["OrderItems"] as? [[String: Any]] {
                                for details in item {
                                    let Name = details["ItemName"] as! String
                                    let AlternateName = details["ItemName"] as! String
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
                        ToastView.show(message: Constants.wrong, controller: self)
                        self.checkoutSegment.isUserInteractionEnabled = true
                    })
                }
                    
                else if (status == 1001) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                        self.dismiss(animated: true, completion: nil)
                        ToastView.show(message: Constants.invalid, controller: self)
                        self.checkoutSegment.isUserInteractionEnabled = true
                    })
                }
                    
                else  {
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                        self.dismiss(animated: true, completion: nil)
                        ToastView.show(message: Constants.occured, controller: self)
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
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
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
            print("Nothing")
            
        case 1:
            let deleteAction = UITableViewRowAction(style: .destructive, title: "Edit") { (action, indexpath) in
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
            deleteAction.backgroundColor = .black
        case 2:
            
            
            let deleteAction = UITableViewRowAction(style: .destructive, title: "Re-Print") { (action, indexpath) in
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
                    
                    Constants.checkouttax = Constants.checkoutGrandtotal * Double(Constants.tax)!
                    Constants.subtotal = Constants.checkoutGrandtotal
                    Constants.checkoutGrandtotal =  Constants.checkoutGrandtotal + Constants.checkouttax
                    self.printerreceipt()
                    
                    
                }
            }
            returnValue = [deleteAction]
            deleteAction.backgroundColor = UIColor.DefaultApp
            
            
        default:
            break
        }
        return returnValue as? [UITableViewRowAction]
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckoutCell", for: indexPath) as! CheckoutCell
        
        switch (checkoutSegment.selectedSegmentIndex) {
        case 0:
            headerlabel.text = "Bay"
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
            headerlabel.text = "Action"
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
            cell.checkoutBtn.setTitle("Checkout", for: .normal)
            cell.checkoutBtn.setTitleColor(UIColor.DefaultApp, for: .normal)
            cell.checkoutBtn.titleLabel!.font = UIFont(name: "SFProDisplay-Bold" , size: 17)
            cell.checkoutBtn.addTarget(self, action:#selector(self.addccheckout(_:)), for: .touchUpInside)
            let trans2 = checkoutmodel[indexPath.row].TransactionNo
            cell.CSerialnmb.text = "\(trans2!)"
            
        case 2:
            headerlabel.text = "Done"
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
            cell.checkoutBtn.setTitle("Done", for: .normal)
            cell.checkoutBtn.setTitleColor(UIColor.DefaultApp, for: .normal)
            cell.checkoutBtn.titleLabel!.font = UIFont(name: "SFProDisplay-Bold" , size: 17)
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
            
            Constants.checkouttax = Constants.checkoutGrandtotal * Double(Constants.tax)!
            Constants.subtotal = Constants.checkoutGrandtotal
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
            
            let cartItemStruct = ReceiptModel(Name: receipt.Name!, Price: receipt.Price!, ItemID: receipt.ItemID!, Quantity: receipt.Quantity!, Mode: "new", OrderDetailID: receipt.OrderDetailID!, Status: 1)
            
            cartItemStructArray.append(cartItemStruct)
            
            
            
        }
        
        
        
        
        
        
        let orderToPrint = Orderdetail.init(OrderDetailID: 12, OrderID: 12, ItemID: 1, ItemName: "Amjad", ItemImage: "store.png", Quantity: 32, Price: 21, TotalCost: 11, LOYALTYPoints: 1, StatusID: 2, ItemDate: Constants.currentdate, Mode: "new", orderPrinterType: PrinterType.checkout)
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
    
}
