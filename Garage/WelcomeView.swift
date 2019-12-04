//
//  WelcomeView.swift
//  Garage
//
//  Created by Amjad Ali on 7/9/18.
//  Copyright © 2018 Amjad Ali. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class WelcomeView: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UITextFieldDelegate, UIPopoverPresentationControllerDelegate,NVActivityIndicatorViewable {
    
    
    @IBOutlet var welcomeView: UIView!
    @IBOutlet weak var viewupper: UIView!
    @IBOutlet weak var carSearchTextField: UITextField!
    @IBOutlet weak var WelcomeSegmented: UISegmentedControl!
    @IBOutlet weak var tableViewWelcome: UITableView!
    
    var Welcomedata = [WelcomeModel]()
    var filterdata = [WelcomeModel]()
    let dateFormatter : DateFormatter = DateFormatter()
    var AssignedID: Int = 0
    
    
    //Localization
    
     let Cancel = NSLocalizedString("Cancel", comment: "")
    let AlreadyAssigned = NSLocalizedString("AlreadyAssigned", comment: "")
    
    //Localization
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        Constants.currentdate = dateString
        Constants.sessions = UserDefaults.standard.string(forKey: "Session")!
        tableViewWelcome.reloadData()
        tableViewWelcome.dataSource = self
        tableViewWelcome.delegate = self
        SearcIconImage()
        ApiImplimentations()
        carSearchTextField.delegate = self
        carSearchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        NotificationCenter.default.addObserver(self, selector: #selector(WelcomeView.service(notification:)), name: Notification.Name("ServiceDone"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(WelcomeView.unlist(notification:)), name: Notification.Name("unlistDone"), object: nil)
        Constants.SuperUser = UserDefaults.standard.integer(forKey: Constants.superuserA)
        Constants.flagEdit = 0
        

    }
    
    deinit {
        
        NotificationCenter.default.removeObserver(self, name: Notification.Name("ServiceDone"), object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name("unlistDone"), object: nil)
    }
    
    
    
    
    @objc func service(notification: Notification) {
        // Refreshing data
        self.ApiImplimentations()
    }
    
    @objc func unlist(notification: Notification) {
        // Refreshing data
        self.ApiImplimentations()
    }
  
    
  
    
    func setClearButtonColor(_ color: UIColor?, forTextfield textField: UITextField?) {
        
        let clearButton = textField?.value(forKey: "_clearButton") as? UIButton
        
        if clearButton != nil {
            
            let image = UIImage(named: "textfieldClearButton")?.withRenderingMode(.alwaysTemplate)
            clearButton?.setImage(image, for: .normal)
            if let aColor = color {
                clearButton?.tintColor = aColor
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // Plate number Search field
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if textField.text  != "" {
            if (carSearchTextField.text?.count)! != 0 {
                self.Welcomedata.removeAll()
                for str in filterdata {
                    let range = str.RegistrationNo?.range(of: textField.text!, options: .caseInsensitive, range: nil, locale: nil)
                     print(str)
                    if range != nil {
                        self.Welcomedata.append(str)
                    }
                }
            }
            tableViewWelcome.reloadData()
            
        } else {
            
            carSearchTextField.resignFirstResponder()
            carSearchTextField.text = ""
            self.Welcomedata.removeAll()
            for str in filterdata {
                Welcomedata.append(str)
            }
            tableViewWelcome.reloadData()
            
        }
        var currentText = textField.text!.replacingOccurrences(of: "-", with: "")
        if currentText.count >= 4 {
            currentText.insert("-", at: currentText.index(currentText.startIndex, offsetBy: 3))
        }
        textField.text = currentText
        if textField.text!.count  == 8  {
            
            
        }
        
    }
    
    func showAnimate() {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.5, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    
    
    
    func SearcIconImage() {
        
        carSearchTextField.rightViewMode = .always
        let emailImgContainer = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 25))
        let emailImg = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        emailImg.image = UIImage(named: "searchIcon")
        emailImg.center = emailImgContainer.center
        emailImgContainer.addSubview(emailImg)
        carSearchTextField.rightView = emailImgContainer
        
    }
    
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        carSearchTextField.resignFirstResponder()
        carSearchTextField.text = ""
        self.Welcomedata.removeAll()
        for str in filterdata {
            Welcomedata.append(str)
        }
        tableViewWelcome.reloadData()
        return false
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (carSearchTextField.text?.count)! != 0 {
            self.Welcomedata.removeAll()
            for str in filterdata {
                let range = str.RegistrationNo?.range(of: textField.text!, options: .caseInsensitive, range: nil, locale: nil)
                if range != nil {
                    self.Welcomedata.append(str)
                }
            }
        }
        tableViewWelcome.reloadData()
        return true
    }
    
    
    
    @IBAction func segmentedAction(_ sender: Any) {
        ApiImplimentations()
        
       
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        if let vc = self.parent as? ReceptionalistView {
            vc.addFooterView1(selected: 0)
        }
    }
    
    
    
    
    
    // fatching data of all, waitlist, assigned from Api's
    func ApiImplimentations() {
        var Apiurl = ""
        switch (WelcomeSegmented.selectedSegmentIndex) {
            
        case 0:
            Apiurl = "\(CallEngine.baseURL)\(CallEngine.Welcomelistall)\(Constants.sessions)"
        case 1:
            Apiurl = "\(CallEngine.baseURL)\(CallEngine.Welcomelistwaitlist)\(Constants.sessions)"
        case 2:
            Apiurl = "\(CallEngine.baseURL)\(CallEngine.Welcomelistassigned)\(Constants.sessions)"
        default:
            break
        }
        self.WelcomeSegmented.isUserInteractionEnabled = false
        DispatchQueue.main.async {
            self.startAnimating(message: Constants.wait, messageFont: UIFont(name:"SFProDisplay-Bold", size: 18.0), type: .ballPulse, color: UIColor.DefaultApp)
         
        }
        let url = URL(string: Apiurl)
        URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
            if response == nil {
                DispatchQueue.main.async {
                    self.stopAnimating()
                    ToastView.show(message: LocalizedString.interneterror, controller: self)
                    self.WelcomeSegmented.isUserInteractionEnabled = true
                }
            }
            guard let data = data, error == nil else { return }
            do {
                
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                print(json)
                
                let status = json[Constants.Status] as? Int
                let discript = json[Constants.Description] as? String
                if (status == 1) {
                if let order = json["OrdersList"] as? [[String: Any]] {
                    self.Welcomedata.removeAll()
                    
                    
                    for OrdersList in order {
                        
                        let neworder = WelcomeModel(OrdersList: OrdersList)
                        self.Welcomedata.append(neworder!)
                        self.filterdata = self.Welcomedata
                    }
                }
            
                    DispatchQueue.main.async {
                    self.stopAnimating()
                    self.tableViewWelcome.reloadData()
                    self.WelcomeSegmented.isUserInteractionEnabled = true
                  }
                    
            }
                 else if (status == 0) {
                   DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                        self.stopAnimating()
                        ToastView.show(message: discript!, controller: self)
                      self.WelcomeSegmented.isUserInteractionEnabled = true
                    })
                    
                }
                else if (status == 1000) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                         self.stopAnimating()
                        ToastView.show(message: LocalizedString.wrong, controller: self)
                        self.WelcomeSegmented.isUserInteractionEnabled = true
                    })
                    
                }
                
                else if (status == 1001) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                         self.stopAnimating()
                        ToastView.show(message: LocalizedString.invalid, controller: self)
                        self.WelcomeSegmented.isUserInteractionEnabled = true
                    })
                    
                }
                
                else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                         self.stopAnimating()
                        ToastView.show(message: LocalizedString.occured, controller: self)
                        self.WelcomeSegmented.isUserInteractionEnabled = true
                    })
                    
                }
                
            } catch let error as NSError {
                 DispatchQueue.main.async {
                 self.stopAnimating()
                self.WelcomeSegmented.isUserInteractionEnabled = true
                ToastView.show(message: "\(error)", controller: self)
                }
            }
        }).resume()
        DispatchQueue.main.async {
            self.tableViewWelcome.reloadData()
        }
        
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var returnValue = 0
        switch (WelcomeSegmented.selectedSegmentIndex) {
        case 0:
            
            
            returnValue = Welcomedata.count
            
        case 1:
            returnValue = Welcomedata.count
        case 2:
            
            returnValue = Welcomedata.count
            
        default:
            break
        }
        return returnValue
    }
    
    
    
    
    
    // cancel from any bay, assigning to waitlist
    func AssignToWait() {
        
        let parameters = [
            Constants.OrderID: AssignedID,
            Constants.BayID: 0,
            Constants.type: "unassigned",
            Constants.SessionID: Constants.sessions]  as [String : Any]
        
        let url = URL(string: "\(CallEngine.baseURL)\(CallEngine.UnAssigned)")!
        
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
                }
                
            }
            }.resume()
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    {
        var returnValue = [AnyObject]()
        
        switch (WelcomeSegmented.selectedSegmentIndex) {
        case 0:
            print("Nothing")
            
        case 1:
            print("Nothing")
        case 2:
            let deleteAction = UITableViewRowAction(style: .destructive, title: Cancel) { (action, indexpath) in
                self.AssignedID = self.Welcomedata[indexPath.row].OrderID ?? 0
                print(self.AssignedID)
                self.AssignToWait()
                self.Welcomedata.remove(at: indexPath.row)
                self.tableViewWelcome.deleteRows(at: [indexPath], with: .automatic)
                self.tableViewWelcome.reloadData()
            }
          
            returnValue = [deleteAction]
            deleteAction.backgroundColor = .DefaultApp
            
        default:
            break
        }
        
        return returnValue as? [UITableViewRowAction]
        
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.separatorColor = UIColor.gray
        return CGFloat(60)
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "welcomeCell", for: indexPath) as? Welcomecell else { return UITableViewCell() }
     
        switch (WelcomeSegmented.selectedSegmentIndex) {
        case 0:
            print(indexPath)
            print(indexPath.row)
            print(WelcomeSegmented.selectedSegmentIndex)
            cell.plateNmb.text = Welcomedata[indexPath.row].RegistrationNo
            cell.make.text = Welcomedata[indexPath.row].MakerName
            cell.model.text = Welcomedata[indexPath.row].ModelName
            let trans = Welcomedata[indexPath.row].TransactionNo
            cell.serialnmb.text = "\(trans ?? 0)"
            cell.editBtn.tag = indexPath.row
            cell.editBtn.setTitle("", for: .normal)
            cell.editBtn.setImage(#imageLiteral(resourceName: "editbilal"), for: .normal)
            cell.editBtn.addTarget(self, action:#selector(self.add(_:)), for: .touchUpInside)
            
            
            
        case 1:
            print(indexPath)
            print(indexPath.row)
            cell.editBtn.isUserInteractionEnabled = true
            print(WelcomeSegmented.selectedSegmentIndex)
            cell.plateNmb.text = Welcomedata[indexPath.row].RegistrationNo
            cell.make.text = Welcomedata[indexPath.row].MakerName
            cell.model.text = Welcomedata[indexPath.row].ModelName
            cell.editBtn.setTitle("", for: .normal)
            cell.editBtn.setImage(#imageLiteral(resourceName: "welcomearrow"), for: .normal)
            //   cell.editBtn.addTarget(self, action:#selector(self.add1(_:)), for: .touchUpInside)
            let trans2 = Welcomedata[indexPath.row].TransactionNo
            cell.serialnmb.text = "\(trans2 ?? 0)"
            
        case 2:
            cell.editBtn.isUserInteractionEnabled = true
            print(indexPath)
            print(indexPath.row)
            print(WelcomeSegmented.selectedSegmentIndex)
            cell.plateNmb.text = Welcomedata[indexPath.row].RegistrationNo
            cell.make.text = Welcomedata[indexPath.row].MakerName
            cell.model.text = Welcomedata[indexPath.row].ModelName
            let Bay = Welcomedata[indexPath.row].BayName
            cell.editBtn.tag = indexPath.row
            cell.editBtn.setTitle(Bay, for: .normal)
            cell.editBtn.setTitleColor(UIColor.DefaultApp, for: .normal)
            cell.editBtn.titleLabel!.font = UIFont(name: "SFProDisplay-Bold" , size: 17)
            cell.editBtn.imageView?.isHidden = true
            cell.editBtn.isUserInteractionEnabled = false
            //                 cell.editBtn.addTarget(self, action:#selector(self.add2(_:)), for: .touchUpInside)
            let trans3 = Welcomedata[indexPath.row].TransactionNo
            cell.serialnmb.text = "\(trans3!)"
        default:
            break
        }
        cell.selectionStyle = .none

        
        return cell
        
    }
    
    @objc func add(_ sender: UIButton){
        switch (WelcomeSegmented.selectedSegmentIndex) {
            
        case 0:
            
            let bay = Welcomedata[sender.tag].BayID
            let bayname = Welcomedata[sender.tag].BayName
            
            if bay == 0 {
                if let new = Welcomedata[sender.tag].OrderID {
                    Constants.editOrderid = new
                    Constants.flagEdit = 1
                    Constants.bayid = 0
                    Constants.bayname = "B0"
                    if let vc = self.parent as? ReceptionalistView {
                        let storyboard = UIStoryboard(name: Constants.AddnewCar, bundle: nil)
                        let newCarvc = storyboard.instantiateViewController(withIdentifier: Constants.addNewCarVc) as! addNewCar
                        vc.switchViewController(vc: newCarvc, showFooter: false)
                    }
                }
                
                
                
            }
                
            else {
                
                ToastView.show(message: "\(AlreadyAssigned) \(bayname!)", controller: self)
            }
         
        case 1:
            Constants.Bplate = Welcomedata[sender.tag].RegistrationNo ?? ""
            Constants.BMake = Welcomedata[sender.tag].MakerName ?? ""
            Constants.editOrderid = Welcomedata[sender.tag].OrderID ?? 0
            Constants.bayid = Welcomedata[sender.tag].BayID ?? 0
            Constants.editcarid = Welcomedata[sender.tag].CarID ?? 0
            Constants.orderstatus = 101
            tapped()
            
            
        case 2:
            ToastView.show(message: "Under Development! Be patient (Assigned)", controller: self)
            
        default:
            break
        }
    }
    
    // view of selecting any bay
    func tapped() {
        let screenSize = UIScreen.main.bounds.width
        var storyboard: UIStoryboard!
        var popController: UIViewController!
        storyboard = UIStoryboard(name: Constants.BayForWelcome, bundle: nil)
        popController = storyboard.instantiateViewController(withIdentifier: Constants.BayForWelcomeVc) as! BayAssignView
       // let nav = UINavigationController(rootViewController: popController)
    //    popController.modalPresentationStyle = .popover
        let popOverVC = popController.popoverPresentationController
        popOverVC?.delegate = self
        popOverVC?.sourceView = self.view
        popOverVC?.permittedArrowDirections = UIPopoverArrowDirection(rawValue:0)
        popOverVC?.sourceRect = CGRect(x: screenSize*0.5, y: UIScreen.main.bounds.size.height*0.5, width: 0, height: 0)
        popController.preferredContentSize = CGSize(width: screenSize*0.6, height: UIScreen.main.bounds.size.height*0.3)
        self.present(popController, animated: true)
    }
    
    
    @objc func add1(_ sender: UIButton){
        let new = Welcomedata[sender.tag].TransactionNo
        print(new!)
    } 

    
    @objc func add2(_ sender: UIButton){
        let new = Welcomedata[sender.tag].TransactionNo
        print(new!)
        
    }

    
    
    @IBAction func carScannerBtn(_ sender: Any) {
        Constants.bayid = 0
        Constants.bayname = "B0"
        if let vc = self.parent as? ReceptionalistView {
            let storyboard = UIStoryboard(name: Constants.CarScan, bundle: nil)
            let carScanner = storyboard.instantiateViewController(withIdentifier: Constants.carScannerVc) as!CarScannerView
            vc.switchViewController(vc: carScanner, showFooter: false)
            
        }
    }
    
    
    @IBAction func addNewCarBtn(_ sender: Any) {
        Constants.flagEdit = 0
        Constants.bayid = 0
        Constants.bayname = "B0"
        if let vc = self.parent as? ReceptionalistView {
            let storyboard = UIStoryboard(name: Constants.AddnewCar, bundle: nil)
            let newCarvc = storyboard.instantiateViewController(withIdentifier: Constants.addNewCarVc) as! addNewCar
            vc.switchViewController(vc: newCarvc, showFooter: false)
        }
    }
    
    
    
}




