//
//  BayAssignView.swift
//  Garage
//
//  Created by Amjad on 18/03/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit

class BayAssignView: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var CarNme: UILabel!
    @IBOutlet weak var editoutlet: UIButton!
    
    @IBOutlet weak var BayCollectionView: UICollectionView!
    var assigning: Int = 0
    let reuseIdentifier = "cell"
    var WBaydetails = [BayforWelcomeOBj]()
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.WBaydetails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! barforWelcome
        
        cell.title.text = WBaydetails[indexPath.row].WName
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        assigning = WBaydetails[indexPath.row].WBayID!
        let cell = BayCollectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 2.0
        cell?.layer.borderColor = UIColor.DefaultApp.cgColor
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        let cell = BayCollectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 2.0
        cell?.layer.borderColor = UIColor.clear.cgColor
       
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 30, bottom: 20, right: 30)
    }
    
    func SerivceAssignedApi() {
        
        
        
        let parameters = [
            Constants.OrderID: Constants.editOrderid,
            Constants.BayID: assigning,
            Constants.type: "bay",
            Constants.SessionID: Constants.sessions]  as [String : Any]
        
        let url = URL(string: "\(CallEngine.baseURL)\(CallEngine.Assigned)")!
        
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
                            
                          NotificationCenter.default.post(name: Notification.Name("ServiceDone"), object: nil)
                            self.dismiss(animated: true, completion: nil)
                            
 
                        }
                    }
                    else if (status == 0) {
                        print(status!)
                        DispatchQueue.main.async {
                             ToastView.show(message: newmessage!, controller: self)

                            self.dismiss(animated: true, completion: nil)
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editoutlet.isHidden = true
        self.navigationController?.isNavigationBarHidden = true
        let Label = Constants.BMake + ", " + Constants.Bplate
        CarNme.text = Label
        Wbaylist()
        
    }
    
    
    
    @IBAction func EditCarBtn(_ sender: Any) {
       
        Constants.flagEdit = 1
        Constants.bayid = 0
        Constants.bayname = "B0"
        if let vc = self.parent as? ReceptionalistView {
            let storyboard = UIStoryboard(name: Constants.AddnewCar, bundle: nil)
            let newCarvc = storyboard.instantiateViewController(withIdentifier: Constants.addNewCarVc) as! addNewCar
            vc.switchViewController(vc: newCarvc, showFooter: false)
        }
    }
    
    
    
    
    @IBAction func dissmissBtn(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    @IBAction func ServiceBtn(_ sender: Any) {
        
        if assigning == 0 {
            ToastView.show(message: "Select Bay", controller: self)
        } else {
            SerivceAssignedApi()
            
        }
        
        
    }
    
    
    
    
    
    
    
    
    @IBAction func unlistBtn(_ sender: Any) {
        
        UnlistApi()
        
    }
    
    
    
    func UnlistApi() {

        let parameters = [
            Constants.BayID: Constants.bayid,
            "AmountDiscount": 0,
                        Constants.PaymentMode: 1,
                        "Gratuity": 0,
                        Constants.CarID:  Constants.editcarid,
                        Constants.GrandTotal: 0,
                        "ServiceCharges": 0,
                        Constants.AmountTotal: 0,
                        "PartialPayment": 0,
                        Constants.OrderID: Constants.editOrderid,
                        Constants.Date: Constants.currentdate,
                        Constants.SessionID: Constants.sessions,
                        Constants.WorkerID: 0,
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
                        Constants.AssistantID: 0]  as [String : Any]
        
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
                            NotificationCenter.default.post(name: Notification.Name("unlistDone"), object: nil)
                            self.dismiss(animated: true, completion: nil)
                       
                        }
                    }
                    else if (status == 0) {
                        
                        print(status!)
                        DispatchQueue.main.async {
                            ToastView.show(message: newmessage!, controller: self)
                            self.dismiss(animated: true, completion: nil)
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
    
    func  Wbaylist()  {
        
        let url = URL(string: "\(CallEngine.baseURL)\(CallEngine.BayAssignApi)\(Constants.sessions)")
        URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                print(json)
                if let bay = json["BaysList"] as? [[String: Any]] {
                    self.WBaydetails.removeAll()
                    for Baylist in bay {
                        let baylist = BayforWelcomeOBj(WBaylist: Baylist)
                        let new = baylist?.WName
                        let new1 = baylist!.WBayID
                        if (new == "Waiting List") && (new1 == 0)   {
                            print("Hello world")
                        }
                        else {
                        self.WBaydetails.append(baylist!)
                        }
                    }
                }
                DispatchQueue.main.async {
                    self.BayCollectionView.reloadData()
                }
                
            } catch let error as NSError {
                print(error)
            }
        }).resume()
        DispatchQueue.main.async {
            //   self.BayCollectionView.reloadData()
            
        }
        
        
    }
    
}
