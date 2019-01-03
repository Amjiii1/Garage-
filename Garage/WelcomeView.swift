//
//  WelcomeView.swift
//  Garage
//
//  Created by Amjad Ali on 7/9/18.
//  Copyright © 2018 Amjad Ali. All rights reserved.
//

import UIKit

class WelcomeView: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UITextFieldDelegate, UIPopoverPresentationControllerDelegate {
    
    
    @IBOutlet var welcomeView: UIView!
    @IBOutlet weak var viewupper: UIView!
    @IBOutlet weak var carSearchTextField: UITextField!
    @IBOutlet weak var WelcomeSegmented: UISegmentedControl!
    @IBOutlet weak var tableViewWelcome: UITableView!
    
    var Welcomecellobj = [WelcomeModel]()
    var fruitsArray = [WelcomeModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewWelcome.reloadData()
        tableViewWelcome.dataSource = self
        tableViewWelcome.delegate = self
        SearcIconImage()
        ApiImplimentations()
        carSearchTextField.delegate = self
       carSearchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
       print("\(Constants.bayid)")
        
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
    
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if textField.text  != "" {
            if (carSearchTextField.text?.count)! != 0 {
                self.Welcomecellobj.removeAll()
                for str in fruitsArray {
                    let range = str.RegistrationNo?.range(of: textField.text!, options: .caseInsensitive, range: nil, locale: nil)
                    if range != nil {
                        self.Welcomecellobj.append(str)
                    }
                }
            }
            tableViewWelcome.reloadData()
            
        } else {
            
            carSearchTextField.resignFirstResponder()
            carSearchTextField.text = ""
            self.Welcomecellobj.removeAll()
            for str in fruitsArray {
                Welcomecellobj.append(str)
            }
            tableViewWelcome.reloadData()
            
        }
        var currentText = textField.text!.replacingOccurrences(of: "-", with: "")
        if currentText.count >= 4 {
            currentText.insert("-", at: currentText.index(currentText.startIndex, offsetBy: 3))
        }
        textField.text = currentText
        if textField.text!.characters.count  == 8          {
           
        
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
        self.Welcomecellobj.removeAll()
        for str in fruitsArray {
            Welcomecellobj.append(str)
        }
       tableViewWelcome.reloadData()
        return false
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (carSearchTextField.text?.count)! != 0 {
            self.Welcomecellobj.removeAll()
            for str in fruitsArray {
                let range = str.RegistrationNo?.range(of: textField.text!, options: .caseInsensitive, range: nil, locale: nil)
                if range != nil {
                    self.Welcomecellobj.append(str)
                }
            }
        }
        tableViewWelcome.reloadData()
        return true
    }
    
    
    
    @IBAction func segmentedAction(_ sender: Any) {
        tableViewWelcome.reloadData()
        ApiImplimentations()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        if let vc = self.parent as? ReceptionalistView {
            vc.addFooterView1(selected: 0)
        }
    }
    
    func showloader() {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
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
            self.showloader()
        }
        let url = URL(string: Apiurl)
    //    print(Apiurl)
        URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }
            do {
              
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
            //    print(json)
               
                if let order = json["OrdersList"] as? [[String: Any]] {
                    self.Welcomecellobj.removeAll()
                    
                
                    for OrdersList in order {
                       
                        let neworder = WelcomeModel(OrdersList: OrdersList)
                         self.Welcomecellobj.append(neworder!)
                        self.fruitsArray = self.Welcomecellobj
                    }
                    }
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                
                 self.dismiss(animated: true, completion: nil)
                    self.tableViewWelcome.reloadData()
                  self.WelcomeSegmented.isUserInteractionEnabled = true
                })
            
                 } catch let error as NSError {
                   self.dismiss(animated: true, completion: nil)
                   self.WelcomeSegmented.isUserInteractionEnabled = true
                    ToastView.show(message: "\(error)", controller: self)
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
            
        
         returnValue = Welcomecellobj.count
            
        case 1:
           returnValue = Welcomecellobj.count
        case 2:
         
           returnValue = Welcomecellobj.count
            
        default:
            break
        }
        return returnValue
    }
        
   
//      func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
//
//        let Cancel = UITableViewRowAction(style: .normal, title: "Cancel") { action, index in
//
//        }
//        switch (WelcomeSegmented.selectedSegmentIndex) {
//        case 0:
//            print(Cancel)
//        case 1:
//             print("Cancel")
//        case 2:
//
//            let Cancel = UITableViewRowAction(style: .normal, title: "Cancel") { action, index in
//
//            }
//
//
//        default:
//            break
//        }
//           return [Cancel]
//
//    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        switch (WelcomeSegmented.selectedSegmentIndex) {
        case 0:
   
              print("cancel")

           // }
        case 1:
            print("cancel")
         
            
        case 2:
               print("cancel")
//            if editingStyle == .delete {
//                Welcomecellobj.remove(at: indexPath.row)
//                tableView.deleteRows(at: [indexPath], with: .automatic)
//            }
            
        default:
         break
        }
        }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.separatorColor = UIColor.gray
        return CGFloat(60)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "welcomeCell", for: indexPath) as! Welcomecell
     
            switch (WelcomeSegmented.selectedSegmentIndex) {
            case 0:
                print(indexPath)
                print(indexPath.row)
                print(WelcomeSegmented.selectedSegmentIndex)
                cell.plateNmb.text = Welcomecellobj[indexPath.row].RegistrationNo
                cell.make.text = Welcomecellobj[indexPath.row].MakerName
                cell.model.text = Welcomecellobj[indexPath.row].ModelName
                let trans = Welcomecellobj[indexPath.row].TransactionNo
                cell.serialnmb.text = "\(trans!)"
                cell.editBtn.tag = indexPath.row
                 cell.editBtn.setTitle("", for: .normal)
                cell.editBtn.setImage(#imageLiteral(resourceName: "editbilal"), for: .normal)
                cell.editBtn.addTarget(self, action:#selector(self.add(_:)), for: .touchUpInside)
                
                
                
            case 1:
                print(indexPath)
                print(indexPath.row)
                cell.editBtn.isUserInteractionEnabled = true
                print(WelcomeSegmented.selectedSegmentIndex)
                cell.plateNmb.text = Welcomecellobj[indexPath.row].RegistrationNo
                cell.make.text = Welcomecellobj[indexPath.row].MakerName
                cell.model.text = Welcomecellobj[indexPath.row].ModelName
                cell.editBtn.setTitle("", for: .normal)
                cell.editBtn.setImage(#imageLiteral(resourceName: "welcomearrow"), for: .normal)
            //   cell.editBtn.addTarget(self, action:#selector(self.add1(_:)), for: .touchUpInside)

                let trans2 = Welcomecellobj[indexPath.row].TransactionNo
                cell.serialnmb.text = "\(trans2!)"
                
            case 2:
                cell.editBtn.isUserInteractionEnabled = true
                print(indexPath)
                print(indexPath.row)
                print(WelcomeSegmented.selectedSegmentIndex)
                cell.plateNmb.text = Welcomecellobj[indexPath.row].RegistrationNo
                cell.make.text = Welcomecellobj[indexPath.row].MakerName
                cell.model.text = Welcomecellobj[indexPath.row].ModelName
                let Bay = Welcomecellobj[indexPath.row].BayName
                cell.editBtn.tag = indexPath.row
                cell.editBtn.setTitle(Bay, for: .normal)
                cell.editBtn.setTitleColor(UIColor.DefaultApp, for: .normal)
                cell.editBtn.titleLabel!.font = UIFont(name: "SFProDisplay-Bold" , size: 17)
                cell.editBtn.imageView?.isHidden = true
                cell.editBtn.isUserInteractionEnabled = false
//                 cell.editBtn.addTarget(self, action:#selector(self.add2(_:)), for: .touchUpInside)
                let trans3 = Welcomecellobj[indexPath.row].TransactionNo
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
            
            let bay = Welcomecellobj[sender.tag].BayID
            let bayname = Welcomecellobj[sender.tag].BayName
            if bay == 0 {
                if let new = Welcomecellobj[sender.tag].OrderID {
                    Constants.editOrderid = new
                    Constants.flagEdit = 1
                    Constants.bayid = 0
                    Constants.bayname = "B0"
                    if let vc = self.parent as? ReceptionalistView {
                        let storyboard = UIStoryboard(name: "AddnewCar", bundle: nil)
                        let newCarvc = storyboard.instantiateViewController(withIdentifier: "addNewCarVc") as! addNewCar
                        vc.switchViewController(vc: newCarvc, showFooter: false)
                    }
                }
                
                
                
            }
            
            else {
                
                
                ToastView.show(message: "Sorry Order cannot be added! Already Assigned to \(bayname!)", controller: self)
            }
            
            
            
            
      
        case 1:
          //  ToastView.show(message: "Under Development! Be patient (Waitlist)", controller: self)
            //BayAssign
            
         tapped()
            
            
        case 2:
          ToastView.show(message: "Under Development! Be patient (Assigned)", controller: self)
//            let new = Welcomecellobj[sender.tag].OrderID
//           print(new)

            
        default:
            break
        }
    }
        
     func tapped() {
        let screenSize = UIScreen.main.bounds
      
        guard let popVC = storyboard?.instantiateViewController(withIdentifier: "BayAssign") else { return }
        
        popVC.modalPresentationStyle = .popover
        
        let popOverVC = popVC.popoverPresentationController
        popOverVC?.delegate = self
        popOverVC?.sourceView = self.view
        popOverVC?.permittedArrowDirections = UIPopoverArrowDirection(rawValue:0)
        popOverVC?.sourceRect = CGRect(x: UIScreen.main.bounds.size.width*0.5, y: UIScreen.main.bounds.size.height*0.5, width: 0, height: 0)
       // popVC.preferredContentSize = CGSize(width: UIScreen.main.bounds.size.width*0.5, height: 400)
        
        self.present(popVC, animated: true)
    }

    
      @objc func add1(_ sender: UIButton){
        let new = Welcomecellobj[sender.tag].TransactionNo
        print(new!)
        
    }
    
    @objc func add2(_ sender: UIButton){
        let new = Welcomecellobj[sender.tag].TransactionNo
        print(new!)
        
    }
    
    
    
    
    
    
   
//    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
//        let new = Welcomecellobj[indexPath.row].TransactionNo
//        print(new)
//    }
    
    
    

    
    @IBAction func carScannerBtn(_ sender: Any) {
        Constants.bayid = 0
        Constants.bayname = "B0"
        if let vc = self.parent as? ReceptionalistView {
                let storyboard = UIStoryboard(name: "CarScan", bundle: nil)
                let carScanner = storyboard.instantiateViewController(withIdentifier: "carScannerVc") as!CarScannerView
                vc.switchViewController(vc: carScanner, showFooter: false)

        }
//        let viewController:UIViewController = UIStoryboard(name: "CarScan", bundle: nil).instantiateViewController(withIdentifier: "carScannerVc") as UIViewController
//        // .instantiatViewControllerWithIdentifier() returns AnyObject! this must be downcast to utilize it
//
//        self.present(viewController, animated: false, completion: nil)
    }
    
    @IBAction func addNewCarBtn(_ sender: Any) {
        Constants.flagEdit = 0
        Constants.bayid = 0
        Constants.bayname = "B0"
        if let vc = self.parent as? ReceptionalistView {
            let storyboard = UIStoryboard(name: "AddnewCar", bundle: nil)
            let newCarvc = storyboard.instantiateViewController(withIdentifier: "addNewCarVc") as! addNewCar
            vc.switchViewController(vc: newCarvc, showFooter: false)
        }
    }
    
    
   
 }




