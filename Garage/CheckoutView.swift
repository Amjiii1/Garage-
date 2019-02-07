//
//  CheckoutView.swift
//  Garage
//
//  Created by Amjad Ali on 6/13/18.
//  Copyright © 2018 Amjad Ali. All rights reserved.
//

import UIKit

class CheckoutView: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    @IBOutlet weak var tableViewContainer: UITableView!
    @IBOutlet weak var checkoutSegment: UISegmentedControl!
    
    @IBOutlet weak var headerlabel: UILabel!
    
    
    var checkoutmodel = [CheckoutModel]()
    
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewContainer.dataSource = self
        tableViewContainer.delegate = self
        checkoutSegment.selectedSegmentIndex = 1
         CheckoutDetails()
        Constants.editcheckout = 0
        
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
        //    print(Apiurl)
        URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
            if response == nil {
                DispatchQueue.main.async {
                    ToastView.show(message: "Login failed! Check internet", controller: self)
                    self.dismiss(animated: true, completion: nil)
                    self.checkoutSegment.isUserInteractionEnabled = true
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
                        self.checkoutmodel.removeAll()
                        
                        
                        for checkoutlist in order {
                            
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
                
                    if let parentVC = self.parent as? ReceptionalistView {
                        let storyboard = UIStoryboard(name: "ServiceCart", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "ServiceCartVc") as? ServiceCartView
                        parentVC.switchViewController(vc: vc!, showFooter: false)

                    }
                
                }
            }
            
            returnValue = [deleteAction]
            deleteAction.backgroundColor = .black
        case 2:
          
            print("Nothing")
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
            cell.checkoutBtn.isUserInteractionEnabled = false
            //                 cell.editBtn.addTarget(self, action:#selector(self.add2(_:)), for: .touchUpInside)
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
             ToastView.show(message: "Under Development! Be patient (Assigned)", controller: self)
            
        case 1:
            if let parentVC = self.parent as? ReceptionalistView {
                let storyboard = UIStoryboard(name: "CheckoutPopUp", bundle: nil)
                let setting = storyboard.instantiateViewController(withIdentifier: "CheckOutPopVc") as! CheckOutPopView
                let navigationController = UINavigationController(rootViewController: setting)
                navigationController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                parentVC.switchViewController(vc: setting, showFooter: false)
            }
            
        case 2:
            ToastView.show(message: "Under Development! Be patient (Assigned)", controller: self)
            
        default:
            break
        }
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.separatorColor = UIColor.gray
        return CGFloat(60)
        
    }
    
    
   
    @IBAction func settings(_ sender: Any) {
        if let parentVC = self.parent as? ReceptionalistView {
            let storyboard = UIStoryboard(name: "SettingsViewController", bundle: nil)
            let setting = storyboard.instantiateViewController(withIdentifier: "SettingViewControllerVc") as! SettingsViewController
            parentVC.switchViewController(vc: setting, showFooter: false)
        
    }
    }
    
    
    
    
    func setupConstraints(){
       

    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
