//
//  addNewCar.swift
//  Garage
//
//  Created by Amjad Ali on 7/11/18.
//  Copyright © 2018 Amjad Ali. All rights reserved

import UIKit
import IQKeyboardManager
import Alamofire

class addNewCar: UIViewController {
    
 
    @IBOutlet weak var VinNumber: UITextField!
    @IBOutlet weak var carplateNumber: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var check: UITextField!
    @IBOutlet weak var carMake: UITextField!
    @IBOutlet weak var modelNumber: UITextField!
    @IBOutlet weak var yearNumber: UITextField!
    @IBOutlet weak var recommendedAmount: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CardetailsData()
    }
    
    

    override func viewWillAppear(_ animated: Bool) {
//        if let vc = self.parent as? ReceptionalistView {
//            vc.removeFooterView()
//
//        }
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
    
    func CardetailsData() {
        
        
        if Constants.platenmb == "" {
         
        }
        else {

        
       
        guard let addcarapi = URL(string: Constants.Searchapi ) else { return }
        let session = URLSession.shared
        session.dataTask(with: addcarapi){ (data, response, error) in
            if let data = data {
                print(data)
                do {
                    guard  let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {return}
                    print(json)
                    let details = Cardetails(json: json)
                    if (details.description == "Success") {
                        self.showloader()
                    if let cars = json[Constants.Cars] as? [[String: Any]] {
                        for items in cars {
                            print("\(items)")
                            if  let maker = items[Constants.MakerName] as? String {
                                DispatchQueue.main.async {
                                    self.carMake.text = maker
                                }
                            }
                            if  let VinNo = items[Constants.VinNo] as? String {
                                DispatchQueue.main.async {
                                    self.VinNumber.text = VinNo
                                }
                            }
                            if  let Customernmb = items[Constants.CustomerContact] as? String {
                                DispatchQueue.main.async {
                                    self.phoneNumber.text =  Customernmb
                                }
                            }
                            if  let CheckLitre = items[Constants.CheckLitre] as? String {
                                DispatchQueue.main.async {
                                    self.check.text = CheckLitre
                                }
                            }
                            
                            if let model = items[Constants.ModelName] as? String {
                                DispatchQueue.main.async {
                                    self.modelNumber.text = model
                                }
                                }
                            if let RegistrationNo = items[Constants.RegistrationNo] as? String {
                                DispatchQueue.main.async {
                                    self.carplateNumber.text = RegistrationNo
                                }
                            }
                            
                            if  let Year = items[Constants.Year] as? Int {
                                DispatchQueue.main.async {
                                    self.yearNumber.text = String (Year)
                                }
                            }
                           if  let RecommendedAmount = items[Constants.RecommendedAmount] as? String {
                                DispatchQueue.main.async {
                                    self.recommendedAmount.text =  RecommendedAmount
                                }
                            }
                        }
                    }
                        
                        self.dismiss(animated: true, completion: nil)
                        
                        }
                        
                     else {
                       
                        DispatchQueue.main.async {
                            ToastView.show(message: "Invalid Plate Number", controller: self)
                    }
                    }
                    
                } catch {
                    
                    print(error)
                    ToastView.show(message: "Failed to collect data! check internet", controller: self)
                  
                }
                
                
            }
            
            
            }.resume()
        
        
    }
    }
    
    
    @IBAction func reScannerBtn(_ sender: Any) {
         if let parentVC = self.parent as? ReceptionalistView {
            let storyboard = UIStoryboard(name: "CarScan", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "carScannerVc") as?CarScannerView
            parentVC.switchViewController(vc: vc!, showFooter: false)
        }
    }
    
    
    @IBAction func continueBtnServiceCart(_ sender: Any) {
        
            editDetails()
        
        if let parentVC = self.parent as? ReceptionalistView {
            let storyboard = UIStoryboard(name: "ServiceCart", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ServiceCartVc") as? ServiceCartView
            parentVC.switchViewController(vc: vc!, showFooter: false)
        }
        
    }
    
    
    
    
    func editDetails() {
        
        
        let parameters = [    Constants.MakeID: "6",
                              Constants.ModelID: "6",
                              Constants.CarID: "31",
                              Constants.CustomerID: "1016",
                              Constants.CustomerContact: phoneNumber.text!,
                              Constants.VinNo: VinNumber.text!,
                              Constants.MakerName: carMake.text!,
                              Constants.ModelName: modelNumber.text!,
                              Constants.CarName: "corolla altis2",
                              Constants.CarDescription: "",
                              Constants.Year: yearNumber.text!,
                              Constants.Color: "green",
                              Constants.RegistrationNo: carplateNumber.text!,
                              Constants.ImagePath: "",
                              Constants.SessionID: "POS-KXCBSH636726904049291864",
                              Constants.CheckLitre: check.text!,
                              Constants.RecommendedAmount: recommendedAmount.text!] as [String : Any]
        
        guard let url = URL(string: Constants.Editapi) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            if let data = data {
                print(data)
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {return}
                    print(json)
                    let status = json["Status"] as? Int
                    if (status == 1) {
                        print(status!)
                        DispatchQueue.main.async {
                            ToastView.show(message: "Car Edit Sucessfully", controller: self)
                        }
                        
                    }
                    else {
                        (status == 0)
                        print(status!)
                        DispatchQueue.main.async {
                            ToastView.show(message: "Car Edit Failed! try later", controller: self)
                        }
                        
                    }
                    
                    
                } catch {
                    print(error)
                    ToastView.show(message: "Car Edit Failed!", controller: self)
                    
                }
            }
            
            }.resume()
    }
    
    
    
    
    
    func downloadSheet()
    {
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        
        let saveAction = UIAlertAction(title: "Save", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
           print("Hello")
        })
        
        optionMenu.addAction(saveAction)
        self.present(optionMenu, animated: true, completion: nil)
    }

    
    
    
    
    

    @IBAction func backBtn(_ sender: Any) {
         if let parentVC = self.parent as? ReceptionalistView {
            let storyboard = UIStoryboard(name: "WelcomeView", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "WelcomeVc") as? WelcomeView
            parentVC.switchViewController(vc: vc!, showFooter: true)
          
        }
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
