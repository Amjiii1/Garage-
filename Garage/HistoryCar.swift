//
//  HistoryCar.swift
//  Garage
//
//  Created by Amjad on 21/02/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit


struct HistoryDetails {
    static var details = [checkoutItems]()
    static var savedetail = [checkoutItems]()
    
    
    static var Inspectionlist = [InspectionListH]()
    static var InspectionDtail = [InspectionDetailsH]()
    
    static var SaveInspectionlist = [InspectionListH]()
    static var SaveInspectionDtail = [InspectionDetailsH]()
    
}




class HistoryCar: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate {
    
    
    
    @IBOutlet weak var historyTableview: UITableView!
    @IBOutlet weak var carModelLabel: UILabel!
    
    @IBOutlet weak var platenmbLabel: UILabel!
    
    var HistoryData = [HistoryModel]()
//     var Inspectionlist = [InspectionListH]()
//      var InspectionDtail = [InspectionDetailsH]()
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        historyData()
        historyTableview.dataSource = self
        historyTableview.delegate = self
        historyTableview.reloadData()
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
    
    
    func historyData() {
        let url = URL(string: "\(CallEngine.baseURL)\(CallEngine.HistoryApi)\(Constants.CarIDData)/\(Constants.sessions)")
        
        URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }
            do {
                self.showloader()
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                print(json)
                
                if let intstatus = json[Constants.Status] as? Int {
                  let descript = json[Constants.Description] as? String
                  //  let status = String (intstatus)
                    if intstatus == 1 {
                        
                        if let model = json["CarModelName"] as? String {
                            DispatchQueue.main.async {
                                self.carModelLabel.text = model
                            }
                        }
                        if let CarNoPlate = json["CarNoPlate"] as? String {
                            DispatchQueue.main.async {
                                self.platenmbLabel.text = CarNoPlate
                            }
                        }
                        
                        
                        // Items
                        if let history = json["OrdersList"] as? [[String: Any]] {
                            self.HistoryData.removeAll()
                            HistoryDetails.details.removeAll()
                            
                            for items in history {
                                if let item = items["OrderItems"] as? [[String: Any]] {
                                    for details in item {
                                        let Name = details["ItemName"] as! String
                                        let AlternateName = details["AlternateName"] as! String
                                        let Price = details["Price"] as! Double
                                        let ItemID = details["ItemID"] as! Int
                                        let Quantity = details["Quantity"] as! Int
                                        let OrderDetails = details["OrderDetailID"] as! Int
                                        let itemorderID = details["OrderID"] as! Int
                                        let itemsdetailed = checkoutItems(Name: Name,AlternateName: AlternateName, Price: Price, ItemID: ItemID, Quantity: Quantity,OrderDetailID: OrderDetails, itemorderid: itemorderID)
                                        HistoryDetails.details.append(itemsdetailed)
                                    }
                                    
                                }
                            }
                            // Notes
                            for CarNotedetails in history {
                                if let CarNotes = CarNotedetails["CarNotes"] as? [[String: Any]] {
                                    print(CarNotes)
                              
                                    for notesdetails in CarNotes {
                                        let NotesComment = notesdetails["NotesComment"] as! String
                                        print(NotesComment)
                                        if let NotesImages = notesdetails["NotesImages"] as? [[String: Any]] {
                                            print(NotesImages)
                                        }
                                        print(notesdetails)
                                      
                                    }
                                    
                                    
                                }
                                }
                            // Checklist
                                
                                for CarCheckList in history {
                                
                                    if let CheckList = CarCheckList["CheckList"] as? [[String: Any]] {
                                        HistoryDetails.Inspectionlist.removeAll()
                                        HistoryDetails.InspectionDtail.removeAll()
                                        
                                        HistoryDetails.InspectionDtail = [InspectionDetailsH]()
                                        for carCheckLists in CheckList  {
                                        
                                            let Name = carCheckLists["Name"] as! String
                                            let InspectionDetails = carCheckLists["InspectionDetails"] as? [[String: Any]]
                                            let CarInspectionIDH = carCheckLists["CarInspectionID"] as! Int
                                            let OrderID = carCheckLists["OrderID"] as! Int
                                            HistoryDetails.InspectionDtail = []
                                            for sub in InspectionDetails!  {
//                                            "CarInspectionDetailID": 79,
//                                            "CarInspectionID": 79,
//                                            "Name": "air filter",
//                                            "Value": "I"
                                                let CarInspectionDetailID = sub["CarInspectionDetailID"] as! Int
                                                let CarInspectionID = sub["CarInspectionID"] as! Int
                                                let Name = sub["Name"] as! String
                                                let Value = sub["Value"] as! String
                                                
                                                let newInspectionDetails = InspectionDetailsH(CarInspectionDetailIDH: CarInspectionDetailID, CarInspectionIDH: CarInspectionID, Name: Name, Value: Value)
                                                HistoryDetails.InspectionDtail.append(newInspectionDetails)
                                            
                                            }
                                            
                                            let newInspectionList = InspectionListH(InspectionDetailsH: [InspectionDetailsH](), InspectionIDH: CarInspectionIDH, NameH: Name, OrderIDH: OrderID)
                                            HistoryDetails.Inspectionlist.append(newInspectionList)
                                        }
                                        
                                        
                                        
                                    }
                            }
                                    
                                    
                            
                            
                            
                            
                            
                            
                            
                            
                            for historyorder in history {
                                print(historyorder)
                                let neworder = HistoryModel(historyorder: historyorder)
                                self.HistoryData.append(neworder!)
                                
                            }
                            
                        }
                    
                        DispatchQueue.main.async {
                            self.historyTableview.reloadData()
                            self.dismiss(animated: true, completion: nil)
                        }
                        
                    }
                        
                    else  if intstatus == 0 {
                         DispatchQueue.main.async {
                        ToastView.show(message: descript!, controller: self)
                            self.dismiss(animated: true, completion: nil)
                        }
                    }
                    else if (intstatus == 1000) {
                        DispatchQueue.main.async {
                            ToastView.show(message: Constants.wrong, controller: self)
                            self.dismiss(animated: true, completion: nil)
                            
                          
                        }
                    }
                        
                    else if (intstatus == 1001) {
                        DispatchQueue.main.async {
                            ToastView.show(message: Constants.invalid, controller: self)
                            self.dismiss(animated: true, completion: nil)
                           
                        }
                    }
                        
                    else {
                        DispatchQueue.main.async {
                            ToastView.show(message: Constants.occured, controller: self)
                            self.dismiss(animated: true, completion: nil)
                           
                        }
                    }
                    
                    
                    
                }
                
            } catch let error as NSError {
                print(error)
                 ToastView.show(message: "failed! error occured", controller: self)
                self.dismiss(animated: true, completion: nil)
            }
        }).resume()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return HistoryData.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.separatorColor = UIColor.gray
        return CGFloat(60)
        
    }
    
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as! HistoryCell
        let serial = HistoryData[indexPath.row].TransactionNo
        cell.SrNo.text = "\(serial!)"
        cell.Date.text = HistoryData[indexPath.row].Date
        cell.Mechanic.text = HistoryData[indexPath.row].Mechanic
        cell.Total.text = HistoryData[indexPath.row].Total
        cell.detailButton.tag = indexPath.row
        cell.detailButton.addTarget(self, action:#selector(self.detailAction(_:)), for: .touchUpInside)
        cell.selectionStyle = .none
        
        return cell
    
    }
    
    
    
     @objc func detailAction(_ sender: UIButton){
        
         HistoryDetails.savedetail.removeAll()
         HistoryDetails.SaveInspectionDtail.removeAll()
         HistoryDetails.SaveInspectionlist.removeAll()
       let id = HistoryData[sender.tag].OrderID!
        Constants.historytrans = HistoryData[sender.tag].TransactionNo!

        Constants.subtotal = 0.0
        Constants.checkoutGrandtotal = 0.0
        Constants.checkouttax = 0.0
        for itemmodels in  HistoryDetails.details {

            if itemmodels.itemorderid == id {

                Constants.checkoutGrandtotal = Constants.checkoutGrandtotal + itemmodels.Price!

                HistoryDetails.savedetail.append(itemmodels)
            } else if itemmodels.itemorderid != id {
                print("Not present")
            }


        }
        Constants.checkouttax = Constants.checkoutGrandtotal * 0.05
        Constants.subtotal = Constants.checkoutGrandtotal
        Constants.checkoutGrandtotal =  Constants.checkoutGrandtotal + Constants.checkouttax
        
        
        for list in HistoryDetails.Inspectionlist {
            if list.OrderIDH == id {
                for list2 in HistoryDetails.InspectionDtail {
                    
                    HistoryDetails.SaveInspectionDtail.append(list2)
                }
              
                
            }
            HistoryDetails.SaveInspectionlist.append(list)
            
        }
        
        
        details()
    }
    
    
    
    
    func details() {
        let screenWidth = UIScreen.main.bounds.width
        let screenheight = UIScreen.main.bounds.height
        var storyboard: UIStoryboard!
        var popController: UIViewController!
        storyboard = UIStoryboard(name: "historydetailview", bundle: nil)
        popController = storyboard.instantiateViewController(withIdentifier: "historydetailviewVc") as! Historydetailview
        // let nav = UINavigationController(rootViewController: popController)
        popController.modalPresentationStyle = .popover
        let popOverVC = popController.popoverPresentationController
        popOverVC?.delegate = self
        popOverVC?.sourceView = self.view
        popOverVC?.permittedArrowDirections = UIPopoverArrowDirection(rawValue:0)
        popOverVC?.sourceRect = CGRect(x: screenWidth*0.5, y: UIScreen.main.bounds.size.height*0.5, width: 0, height: 0)
        popController.preferredContentSize = CGSize(width: screenWidth*0.70, height: screenheight*0.5)
        self.present(popController, animated: true)
    }
    
    
    
    @IBAction func backBtn(_ sender: Any) {
        if let parentVC = (self.parent as? ReceptionalistView) {
            let storyboard = UIStoryboard(name: "AddnewCar", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "addNewCarVc") as? addNewCar
            parentVC.switchViewController(vc: vc!, showFooter: false)
            
        }
    }
    
}
