//
//  HistoryCar.swift
//  Garage
//
//  Created by Amjad on 21/02/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

struct HistoryDetails {
    
    static var details = [checkoutItems]()
    static var savedetail = [checkoutItems]()
    static var SaveInspectionlist = [InspectionListH]()
    static var SaveInspectionDtail = [InspectionDetailsH]()
    
    static var carNotes = [CarNote]()
    static var savecarNotes = [CarNote]()
    // static var uploadedimages = [NotesImages]()
}


class HistoryCar: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate,NVActivityIndicatorViewable {
    
    @IBOutlet weak var historyTableview: UITableView!
    @IBOutlet weak var carModelLabel: UILabel!
    
    @IBOutlet weak var platenmbLabel: UILabel!
    
    var HistoryData = [HistoryModel]()
    var PDFLetterH: String = ""
    var Inspectionlist = [InspectionListH]()
    var InspectionDtail = [InspectionDetailsH]()
    
    
    var upimages = [String]()
    var count = 0
    
    let AirPrint = NSLocalizedString("AirPrint", comment: "")
    let PrintingSucuess  = NSLocalizedString("sucessfully", comment: "")
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.historyData()
       // self.historyTableview.reloadData()
    }
    
    
    
    func historyData() {
        let url = URL(string: "\(CallEngine.baseURL)\(CallEngine.HistoryApi)\(Constants.CarIDData)/\(Constants.sessions)")
        self.startAnimating(message: Constants.wait, messageFont: UIFont(name:"SFProDisplay-Bold", size: 18.0), type: .ballPulse, color: UIColor.DefaultApp)
        URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }
            do {
//                self.startAnimating(message: Constants.wait, messageFont: UIFont(name:"SFProDisplay-Bold", size: 18.0), type: .ballPulse, color: UIColor.DefaultApp)
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
                            self.Inspectionlist.removeAll()
                            self.InspectionDtail.removeAll()
                            
                            
                            for items in history {
                                if let item = items[Constants.OrderItems] as? [[String: Any]] {
                                    for details in item {
                                        let Name = details[Constants.ItemName] as? String  ?? ""
                                        let AlternateName = details[Constants.AlternateName] as? String  ?? ""
                                        let Price = details[Constants.Price] as? Double  ?? 0.0
                                        let ItemID = details[Constants.ItemID] as? Int  ?? 0
                                        let Quantity = details[Constants.Quantity] as? Int  ?? 0
                                        let OrderDetails = details[Constants.OrderDetailID] as? Int  ?? 0
                                        let itemorderID = details[Constants.OrderID] as? Int  ?? 0
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
                                        let Name = carCheckLists[Constants.Name] as? String  ?? ""
                                        let AName = carCheckLists[Constants.AlternateName] as? String  ?? ""
                                        let InspectionDetails = carCheckLists[Constants.InspectionDetails] as? [[String: Any]]
                                        let CarInspectionIDH = carCheckLists[Constants.CarInspectionID] as? Int  ?? 0
                                        let OrderID = carCheckLists[Constants.OrderID] as? Int  ?? 0
                                        InspectionDtail = []
                                        for sub in InspectionDetails!  {
                                            let CarInspectionDetailID = sub[Constants.CarInspectionDetailID] as? Int  ?? 0
                                            let CarInspectionID = sub[Constants.CarInspectionID] as? Int  ?? 0
                                            let Name = sub[Constants.Name] as? String  ?? ""
                                            let AName = sub[Constants.AlternateName] as? String  ?? ""
                                            let Value = sub[Constants.Value] as? String  ?? ""
                                            let newInspectionDetails = InspectionDetailsH(CarInspectionDetailIDH: CarInspectionDetailID, CarInspectionIDH: CarInspectionID, Name: Name, AlternativeH: AName, Value: Value)
                                            InspectionDtail.append(newInspectionDetails)
                                            
                                        }
                                        
                                        let newInspectionList = InspectionListH(InspectionDetailsH: InspectionDtail, InspectionIDH: CarInspectionIDH, NameH: Name, AlternativeH: AName, OrderIDH: OrderID)
                                        self.Inspectionlist.append(newInspectionList)
                                         DispatchQueue.main.async {
                                        self.historyTableview.reloadData()
                                        }
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
                            self.stopAnimating()
                        }
                        
                    }
                        
                    else  if intstatus == 0 {
                        DispatchQueue.main.async {
                            self.stopAnimating()
                            ToastView.show(message: descript!, controller: self)
                        }
                    }
                    else if (intstatus == 1000) {
                        DispatchQueue.main.async {
                            self.stopAnimating()
                            ToastView.show(message: LocalizedString.wrong, controller: self)
                            
                            
                        }
                    }
                        
                    else if (intstatus == 1001) {
                        DispatchQueue.main.async {
                            self.stopAnimating()
                            ToastView.show(message: LocalizedString.invalid, controller: self)
                            
                        }
                    }
                        
                    else {
                        DispatchQueue.main.async {
                            self.stopAnimating()
                            ToastView.show(message: LocalizedString.occured, controller: self)
                            
                        }
                    }
                    
                    
                    
                }
                
            } catch let error as NSError {
                print(error)
                self.stopAnimating()
                ToastView.show(message: LocalizedString.occured, controller: self)
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
        cell.SrNo.text = "\(serial ?? 0)"
        cell.Date.text = HistoryData[indexPath.row].Date
        cell.Mechanic.text = HistoryData[indexPath.row].Mechanic
        cell.Total.text = HistoryData[indexPath.row].Total
        cell.detailButton.tag = indexPath.row
        cell.detailButton.addTarget(self, action:#selector(self.detailAction(_:)), for: .touchUpInside)
        cell.selectionStyle = .none
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let AirPrinter = UITableViewRowAction(style: .destructive, title: AirPrint) { (action, indexpath) in
            DispatchQueue.main.async {
                
                Constants.checkoutPDF = self.HistoryData[indexPath.row].OrderID ?? 0
                self.PdfPrinterH()
            }
        }
        
        
        AirPrinter.backgroundColor = UIColor.DefaultApp
        
        return [AirPrinter]
    }
    
    
    
    func PdfPrinterH() {
        
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
                    //self.startAnimating(message: "Please wait..", messageFont: UIFont(name:"SFProDisplay-Bold", size: 18.0), type: .ballPulse, color: UIColor.DefaultApp)
                    guard  let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {return}
                    let discript = json[Constants.Description] as? String
                    if let status = json[Constants.Status] as? Int {
                        if (status == 1) {
                            print(json)
                            if let printer = json["Path"] as? String {
                                if printer != "" {
                                    DispatchQueue.main.async {
                                        print(printer)
                                        
                                        self.PDFLetterH = printer
                                        //self.stopAnimating()
                                        self.PrintletterH()
                                    }
                                } else {
                                    DispatchQueue.main.async {
                                        
                                        
                                        ToastView.show(message: "PDF not found", controller: self)
                                       // self.stopAnimating()
                                    }
                                }
                            }
                        }
                        else if (status == 0) {
                            ToastView.show(message: discript ?? "Null data", controller: self)
                          //  self.stopAnimating()
                        }
                            
                        else if (status == 1000) {
                            
                            ToastView.show(message: LocalizedString.wrong, controller: self)
                            self.stopAnimating()
                        }
                            
                        else if (status == 1001) {
                            
                            ToastView.show(message: LocalizedString.invalid, controller: self)
                           // self.stopAnimating()
                        }
                            
                        else {
                           
                            ToastView.show(message: LocalizedString.occured, controller: self)
                           //  self.stopAnimating()
                        }
                        
                    }
                    
                } catch let error as NSError {
                    
                    print(error)
                    ToastView.show(message: "failed! Try Again", controller: self)
                    //self.stopAnimating()
                }
                
            }
            }.resume()
    }
    
    
    func PrintletterH() {
        
        let printController = UIPrintInteractionController.shared
        let printInfo = UIPrintInfo(dictionary: [:])
        printInfo.outputType = UIPrintInfo.OutputType.general
        printInfo.orientation = UIPrintInfo.Orientation.portrait
        printInfo.jobName = "Receipt Details"
        printController.printInfo = printInfo
        // printController.showsPageRange = true
        //http://www.pdf995.com/samples/pdf.pdf
        print(self.PDFLetterH)
        printController.printingItem = NSData(contentsOf: URL(string:  self.PDFLetterH)!)
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
    
    
    
    
    
    
    
    @objc func detailAction(_ sender: UIButton){
        
        HistoryDetails.savedetail.removeAll()
        HistoryDetails.SaveInspectionlist.removeAll()
        HistoryDetails.SaveInspectionDtail.removeAll()
        HistoryDetails.savecarNotes.removeAll()
        
        
        
        let id = HistoryData[sender.tag].OrderID  ?? 0
        Constants.historytrans = HistoryData[sender.tag].TransactionNo  ?? 0
        Constants.historygrandtotal = HistoryData[sender.tag].GrandTotal  ?? 0
        Constants.historydiscount = HistoryData[sender.tag].Discount  ?? 0
        Constants.historysubtotal = HistoryData[sender.tag].TotalAmount  ?? 0
        Constants.historytax = HistoryData[sender.tag].Tax  ?? 0
        
        for itemmodels in  HistoryDetails.details {
            if itemmodels.itemorderid == id {
                HistoryDetails.savedetail.append(itemmodels)
            } else if itemmodels.itemorderid != id {
                print("Not present")
            }
        }
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
       // popController.modalPresentationStyle = .popover
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
