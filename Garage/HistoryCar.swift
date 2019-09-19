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
    
    //    static var Inspectionlist = [InspectionListH]()
    //    static var InspectionDtail = [InspectionDetailsH]()
    
    static var SaveInspectionlist = [InspectionListH]()
    static var SaveInspectionDtail = [InspectionDetailsH]()
    
    static var carNotes = [CarNote]()
    static var savecarNotes = [CarNote]()
    
    // static var uploadedimages = [NotesImages]()
}




class HistoryCar: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate {
    
    
    
    @IBOutlet weak var historyTableview: UITableView!
    @IBOutlet weak var carModelLabel: UILabel!
    
    @IBOutlet weak var platenmbLabel: UILabel!
    
    var HistoryData = [HistoryModel]()
    
    
    
    var Inspectionlist = [InspectionListH]()
    var InspectionDtail = [InspectionDetailsH]()
    
    
    var upimages = [String]()
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
                        
                        if let model = json[Constants.CarModelName] as? String {
                            DispatchQueue.main.async {
                                self.carModelLabel.text = model
                            }
                        }
                        if let CarNoPlate = json[Constants.CarNoPlate] as? String {
                            DispatchQueue.main.async {
                                self.platenmbLabel.text = CarNoPlate
                            }
                        }
                        
                        
                        // Items
                        if let history = json[Constants.OrdersList] as? [[String: Any]] {
                            self.HistoryData.removeAll()
                            HistoryDetails.details.removeAll()
                            HistoryDetails.carNotes.removeAll()
                            //                            HistoryDetails.Inspectionlist.removeAll()
                            //                            HistoryDetails.InspectionDtail.removeAll()
                            self.Inspectionlist.removeAll()
                            self.InspectionDtail.removeAll()
                            
                            
                            for items in history {
                                if let item = items[Constants.OrderItems] as? [[String: Any]] {
                                    for details in item {
                                        let Name = details[Constants.ItemName] as! String
                                        let AlternateName = details[Constants.ItemName] as! String  // give Alternative name
                                        let Price = details[Constants.Price] as! Double
                                        let ItemID = details[Constants.ItemID] as! Int
                                        let Quantity = details[Constants.Quantity] as! Int
                                        let OrderDetails = details[Constants.OrderDetailID] as! Int
                                        let itemorderID = details[Constants.OrderID] as! Int
                                        let itemsdetailed = checkoutItems(Name: Name,AlternateName: AlternateName, Price: Price, ItemID: ItemID, Quantity: Quantity,OrderDetailID: OrderDetails, itemorderid: itemorderID)
                                        HistoryDetails.details.append(itemsdetailed)
                                    }
                                    
                                }
                            }
                            // Notes
                            for CarNotedetails in history {
                                if let CarNotes = CarNotedetails[Constants.CarNotes] as? [[String: Any]] {
                                    for notesdetails in CarNotes {
                                        let notesImage = notesdetails[Constants.NotesImages] as? NSArray
                                        let NotesComment = notesdetails[Constants.NotesComment] as? String
                                        let NotesID = notesdetails[Constants.NotesID] as? Int
                                        let OrderID = notesdetails[Constants.OrderID] as? Int
                                        let carNote = CarNote(Notes: notesImage as! [String], NotesComment: NotesComment!, NotesID: NotesID!, OrderID: OrderID!)
                                        HistoryDetails.carNotes.append(carNote)
                                        
                                    }
                                    
                                    
                                }
                            }
                            
                            // Checklist
                            for CarCheckList in history {
                                
                                if let CheckList = CarCheckList[Constants.CheckList] as? [[String: Any]] {
                                    var InspectionDtail = [InspectionDetailsH]()
                                    for carCheckLists in CheckList  {
                                        let Name = carCheckLists[Constants.Name] as! String
                                        let InspectionDetails = carCheckLists[Constants.InspectionDetails] as? [[String: Any]]
                                        let CarInspectionIDH = carCheckLists[Constants.CarInspectionID] as! Int
                                        let OrderID = carCheckLists[Constants.OrderID] as! Int
                                        InspectionDtail = []
                                        for sub in InspectionDetails!  {
                                            let CarInspectionDetailID = sub[Constants.CarInspectionDetailID] as! Int
                                            let CarInspectionID = sub[Constants.CarInspectionID] as! Int
                                            let Name = sub[Constants.Name] as! String
                                            let Value = sub[Constants.Value] as! String
                                            let newInspectionDetails = InspectionDetailsH(CarInspectionDetailIDH: CarInspectionDetailID, CarInspectionIDH: CarInspectionID, Name: Name, Value: Value)
                                            InspectionDtail.append(newInspectionDetails)
                                            
                                        }
                                        
                                        let newInspectionList = InspectionListH(InspectionDetailsH: InspectionDtail, InspectionIDH: CarInspectionIDH, NameH: Name, OrderIDH: OrderID)
                                        self.Inspectionlist.append(newInspectionList)
                                        self.historyTableview.reloadData()
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
        HistoryDetails.SaveInspectionlist.removeAll()
        HistoryDetails.SaveInspectionDtail.removeAll()
        HistoryDetails.savecarNotes.removeAll()
        
        
        
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
        
        
        for list in Inspectionlist {
            if list.OrderIDH == id {
                for list2 in list.InspectionDetailsH {
                    
                    HistoryDetails.SaveInspectionDtail.append(list2)
                }
                
                HistoryDetails.SaveInspectionlist.append(list)
            }
            
        }
        
        for images in HistoryDetails.carNotes {
            if images.OrderID == id {
                print(images.Notes)
                print(images.NotesComment)
                HistoryDetails.savecarNotes.append(images)
                
            }
            
        }
        
        details()
    }
    
    
    
    
    func details() {
        
        let screenWidth = UIScreen.main.bounds.width
        let screenheight = UIScreen.main.bounds.height
        var storyboard: UIStoryboard!
        var popController: UIViewController!
        storyboard = UIStoryboard(name: Constants.historydetailview, bundle: nil)
        popController = storyboard.instantiateViewController(withIdentifier: Constants.historydetailviewVc) as! Historydetailview
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
