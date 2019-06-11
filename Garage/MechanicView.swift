//
//  MechanicView.swift
//  Garage
//
//  Created by Amjad Ali on 6/13/18.
//  Copyright © 2018 Amjad Ali. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class MechanicView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var MechanicSegmented: UISegmentedControl!
    @IBOutlet weak var loadingBtn: UIButton!
    @IBOutlet weak var assignserviceBtn: UIButton!
    @IBOutlet weak var notesBtn: UIButton!
    @IBOutlet weak var collectionViewSlot: UICollectionView!
    @IBOutlet weak var loaderlabel: UILabel!
    @IBOutlet weak var checkcarBtn: UIButton!
    @IBOutlet weak var finishBtn: UIButton!
    @IBOutlet weak var carNamelbl: UILabel!
    @IBOutlet weak var platenumberlbl: UILabel!
    @IBOutlet weak var milesBtn: UIButton!
    @IBOutlet weak var dropDwnBtn: UIButton!
    @IBOutlet weak var workingLabel: UILabel!
    @IBOutlet weak var finishedTableview: UITableView!
    @IBOutlet weak var labelsView: UIView!
    @IBOutlet weak var completeView: UIView!
    
    @IBOutlet weak var serialNo: UILabel!
    @IBOutlet weak var makeLbl: UILabel!
    @IBOutlet weak var modelLbl: UILabel!
    @IBOutlet weak var plateLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    
    
    
    var flag: Int = 0
    var flag2: Int = 0
    var rec = "0"
    
    var MechanicModel = [MechanicTableviewModel]()
   
    
    
    var OrderDetails = [Orderdetail]()
    let reuseIdentifier = "MechanicCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notesBtn.isUserInteractionEnabled = false
        checkcarBtn.isUserInteractionEnabled = false
        dropDwnBtn.isUserInteractionEnabled = false
        
        milesBtn.isHidden = true
        carNamelbl.isHidden = true
        platenumberlbl.isHidden = true
        finishedTableview.isHidden = true
        finishedTableview.dataSource = self
        finishedTableview.delegate = self
        labelsView.isHidden = true
        donebtnenable()
         bay0()
        NotificationCenter.default.addObserver(self, selector: #selector(MechanicView.BayNotification(notification:)), name: Notification.Name("Notificationbayname"), object: nil)
        
    }
    
    func bay0() {
       if Constants.bayname == "B0" {
        assignserviceBtn.setTitle("Select Bay", for: .normal)
       } else {
         assignserviceBtn.setTitle("\(Constants.bayname)", for: .normal)
        }
        assignserviceBtn.contentHorizontalAlignment = .left
    
    }
    
    
    
    @objc func BayNotification(notification: Notification) {
        flag2 = 1
        Showdetails()
        self.assignserviceBtn.setTitle("\(Constants.bayname)", for: .normal)
        flag2 = 0
    }
    
    deinit {
        
        NotificationCenter.default.removeObserver(self, name: Notification.Name("Notificationbayname"), object: nil)
    }
    
    
    func donebtnenable() {
        
        if Constants.checkflag == 0 {
            finishBtn.isUserInteractionEnabled = false
            
            
        } else if Constants.checkflag == 1 {
            finishBtn.isUserInteractionEnabled = true
            finishBtn.isSelected = true
            Constants.checkflag = 0
        }
        
        
    }
    
    
    func HideDetails() {
        collectionViewSlot.isHidden = true
        loadingBtn.isHidden = true
        notesBtn.isHidden = true
        loaderlabel.isHidden = true
        checkcarBtn.isHidden = true
        finishBtn.isHidden = true
        carNamelbl.isHidden = true
        milesBtn.isHidden = true
        platenumberlbl.isHidden = true
        milesBtn.isHidden = true
        dropDwnBtn.isHidden = true
        workingLabel.isHidden = true
        completeView.isHidden = true
        finishedTableview.isHidden = false
        labelsView.isHidden = false
        serialNo.isHidden = false
        makeLbl.isHidden = false
        modelLbl.isHidden = false
        plateLbl.isHidden = false
        statusLbl.isHidden = false
     
    }
    
    func Showdetails() {
        collectionViewSlot.isHidden = false
        if flag2 != 0 {
            if let parentVC = self.parent as? ReceptionalistView {
                let storyboard = UIStoryboard(name: Constants.MechanicView, bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: Constants.MechanicVc) as? MechanicView
                parentVC.switchViewController(vc: vc!, showFooter: true)
            }
        }
        else {
            if flag != 1  {
                loadingBtn.isHidden = false
                loaderlabel.isHidden = false
            } else {
                loadingBtn.isHidden = true
                loaderlabel.isHidden = true
            }
        }
        completeView.isHidden = false
        notesBtn.isHidden = false
        checkcarBtn.isHidden = false
        finishBtn.isHidden = false
        carNamelbl.isHidden = false
        milesBtn.isHidden = false
        platenumberlbl.isHidden = false
        milesBtn.isHidden = false
        dropDwnBtn.isHidden = false
        workingLabel.isHidden = false
        finishedTableview.isHidden = true
        labelsView.isHidden = true
        serialNo.isHidden = true
        makeLbl.isHidden = true
        modelLbl.isHidden = true
        plateLbl.isHidden = true
        statusLbl.isHidden = true
        
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
    
    
    
    func FinishedApi() {
        
        let Apiurl = "\(CallEngine.baseURL)\(CallEngine.finishedOrderlist)/\(Constants.sessions)"
        self.MechanicSegmented.isUserInteractionEnabled = false
        DispatchQueue.main.async {
            self.showloader()
        }
        let url = URL(string: Apiurl)
        //    print(Apiurl)
        URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }
            do {
                
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                print(json)
                let statusmessage = json[Constants.Status] as? Int
                let descriptmessage = json[Constants.Description] as? String
                if (statusmessage == 1) {
                
                if let order = json["OrdersList"] as? [[String: Any]] {
                    self.MechanicModel.removeAll()
                    
                    
                    for DetailList in order {
                        
                        let newDetails = MechanicTableviewModel(DetailList: DetailList)
                        self.MechanicModel.append(newDetails!)
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                    
                    self.dismiss(animated: true, completion: nil)
                    self.finishedTableview.reloadData()
                    self.MechanicSegmented.isUserInteractionEnabled = true
                })
            }
                else if (statusmessage == 0) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                        self.dismiss(animated: true, completion: nil)
                        ToastView.show(message: descriptmessage!, controller: self)
                        self.MechanicSegmented.isUserInteractionEnabled = true
                    })
                    
                }
                else if (statusmessage == 1000) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                        self.dismiss(animated: true, completion: nil)
                        ToastView.show(message: Constants.wrong, controller: self)
                        self.MechanicSegmented.isUserInteractionEnabled = true
                    })
                    
                }
                    
                else if (statusmessage == 1001) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                        self.dismiss(animated: true, completion: nil)
                        ToastView.show(message: Constants.invalid, controller: self)
                        self.MechanicSegmented.isUserInteractionEnabled = true
                    })
                    
                }
                    
                else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                        self.dismiss(animated: true, completion: nil)
                        ToastView.show(message:Constants.occured, controller: self)
                        self.MechanicSegmented.isUserInteractionEnabled = true
                    })
                    
                }
                
            }
            
                
                catch let error as NSError {
                self.dismiss(animated: true, completion: nil)
                self.MechanicSegmented.isUserInteractionEnabled = true
                ToastView.show(message: "failed to load", controller: self)
            }
        }).resume()
        DispatchQueue.main.async {
            self.finishedTableview.reloadData()
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MechanicModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = finishedTableview.dequeueReusableCell(withIdentifier: "MechanicTableviewCell", for: indexPath) as? MechanicTableviewCell else { return UITableViewCell() }
        let transaction = MechanicModel[indexPath.row].finishedTransactionNo
        cell.serialNo.text = "\(transaction!)"
        cell.makeLbl.text = MechanicModel[indexPath.row].finishedMakerName
        cell.modelLbl.text = MechanicModel[indexPath.row].finishedModelName
        cell.plateLbl.text = MechanicModel[indexPath.row].finishedRegistrationNo
        let status = MechanicModel[indexPath.row].finishedBayName
        cell.statusLbl.text = "\(status!)"
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.separatorColor = UIColor.gray
        return CGFloat(60)
    }
    
    
    
    
    private func getDataDetails() {
        let url = "\(CallEngine.baseURL)\(CallEngine.LoadCardetailsapi)\(Constants.bayid)/\(Constants.sessions)"
        print(url)
        Alamofire.request(url).response { [weak self] (response) in
            guard self != nil else { return  }
            if let error = response.error {
                ToastView.show(message: "Network Error", controller: self!)
            } else {
                do {
                    let json = try JSON(data: response.data!)
                    let status = json[Constants.Status].intValue
                    let desc = json[Constants.Description].stringValue
                    Constants.orderidmechanic = json["OrderID"].intValue
                    ToastView.show(message: desc, controller: self!)
                    if (status == 1) {
                        let CarInfo = json[Constants.Cars].arrayValue
                        for cars in CarInfo {
                            
                            let RegistrationNo = cars[Constants.RegistrationNo].stringValue
                            DispatchQueue.main.async {
                                self!.platenumberlbl.text = RegistrationNo
                            }
                            
                            let carid = cars[Constants.CarID].intValue
                            DispatchQueue.main.async {
                                Constants.caridmechanic =  carid
                            }
                            
                            let Amount = cars["RecommendedAmount"].intValue
                            DispatchQueue.main.async {
                                Constants.mechanicrec =  Amount
                            }
                            
                            
                            let CarName = cars[Constants.ModelName].stringValue
                            DispatchQueue.main.async {
                                self!.carNamelbl.text = CarName
                            }
                            let recomd = cars["CheckLitre"].stringValue
                            DispatchQueue.main.async {
                                self!.rec = recomd
                                self!.milesBtn.setTitle("\(self!.rec) km", for: .normal)
                            }
                            
                        }
                        let Notes = json["Notes"].dictionaryValue
                        
                        
                        
                        let Orderlist = json["Orderdetail"].arrayValue
                        //                        if Orderlist.isEmpty == true {
                        //
                        //                            ToastView.show(message: "Sorry! No orders Available, Select Other Bay", controller: self!)
                        //                            self!.loadingBtn.isHidden = false
                        //                            self!.loaderlabel.isHidden = false
                        //
                        //                        }
                        //                         else {
                        for order in Orderlist {
                            
                            let OrderDetailID = order["OrderDetailID"].intValue
                            let ItemID = order["ItemID"].intValue
                            let ItemName = order["ItemName"].stringValue
                            let ItemImage = order["ItemImage"].stringValue
                            let Quantity = order["Quantity"].intValue
                            let Price = order["Price"].doubleValue
                            let TotalCost = order["TotalCost"].intValue
                            let LOYALTYPoints = order["LOYALTYPoints"].intValue
                            // let isComplementory = order["isComplementory"].stringValue
                            let StatusID = order["StatusID"].intValue
                            let ItemDate = order["ItemDate"].stringValue
                            let Mode = order["Mode"].stringValue
                            
                            let orders = Orderdetail(OrderDetailID: OrderDetailID, OrderID: Constants.orderidmechanic,ItemID: ItemID, ItemName: ItemName, ItemImage: ItemImage, Quantity: Quantity, Price: Price,  TotalCost: TotalCost, LOYALTYPoints: LOYALTYPoints, StatusID: StatusID, ItemDate: ItemDate, Mode: Mode, orderPrinterType: PrinterType.checkout)
                            self?.OrderDetails.append(orders)
                            DispatchQueue.main.async {
                                self?.collectionViewSlot.reloadData()
                            }
                        }
                        
                        self!.appearView()
                    }
                    else  if (status == 0) {
                        ToastView.show(message: desc, controller: self!)
                    }
                        
                    else  if (status == 1000) {
                        ToastView.show(message: Constants.wrong, controller: self!)
                    }
                        
                    else  if (status == 1001) {
                        ToastView.show(message: Constants.invalid, controller: self!)
                    }
                        
                    else {
                        ToastView.show(message: Constants.occured, controller: self!)
                    }
                    
                } catch {
                    debugPrint("🔥 Network Error : ", error)
                    ToastView.show(message: "Network Error", controller: self!)
                }
            }
        }
    }
    
    
    // MARK: - UICollectionViewDataSource protocol
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let verticalIndicator = scrollView.subviews.last as? UIImageView
        verticalIndicator?.backgroundColor = UIColor.white
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 30, left: 15, bottom: 30, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionViewSlot.frame.size.width/3.8, height: collectionViewSlot.frame.size.height/2.5)
    }
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return OrderDetails.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as? MechanicCell else { return UICollectionViewCell() }
        
        cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
        UIView.animate(withDuration: 0.3, animations: {
            cell.layer.transform = CATransform3DMakeScale(1.05,1.05,1)
        },completion: { finished in
            UIView.animate(withDuration: 0.1, animations: {
                cell.layer.transform = CATransform3DMakeScale(1,1,1)
            })
        })
        
        cell.Mpopulate(with: OrderDetails[indexPath.item].ItemName, image: OrderDetails[indexPath.item].ItemImage)
        
        let testButton = UIButton(type: .custom)
        testButton.frame = CGRect(x: 0, y: 0, width: 0.5 * notesBtn.frame.size.width, height: 0.5 * notesBtn.frame.size.height)
        //testButton.addTarget(self, action: #selector(self.deleteRecipe(_:)), for: .touchUpInside)
        testButton.backgroundColor = UIColor.DefaultApp
        let qty = OrderDetails[indexPath.row].Quantity
        testButton.setTitle("\(qty)", for: .normal)
        testButton.setTitleColor(UIColor.black, for: .normal)
        testButton.clipsToBounds = true
        testButton.layer.cornerRadius = 0.5 * testButton.frame.size.width
        testButton.isUserInteractionEnabled = false
        cell.contentView.addSubview(testButton)
        
        
        
        
        
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    //    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //        // handle tap events
    //        print("You selected cell #\(indexPath.item)!")
    //
    //    }
    
    
    
    
    
    
    
    
    
    @IBAction func SegmetedAction(_ sender: Any) {
        
        switch MechanicSegmented.selectedSegmentIndex
        {
        case 0:
            Showdetails()
        //   self.collectionViewSlot.reloadData()
        case 1:
            HideDetails()
            FinishedApi()
        //   flag = 1
        default:
            break
        }
    }
    
    
    
    
    
    @IBAction func notesAction(_ sender: Any) {
        
        print(Constants.CarIDData)
        print(Constants.orderidmechanic)
        
        var storyboard: UIStoryboard!
        var popController: UIViewController!
        storyboard = UIStoryboard(name: Constants.notespopup, bundle: nil)
        popController = storyboard.instantiateViewController(withIdentifier: Constants.notesPopupVc) as! notesPopup
        //let nav = UINavigationController(rootViewController: popController)
        popController.modalPresentationStyle = .popover
        let heightForPopOver = 300*2
        let popover = popController.popoverPresentationController
        popController.preferredContentSize = CGSize(width: 500 , height: heightForPopOver)
        popover?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 3)
        popover?.permittedArrowDirections =  UIPopoverArrowDirection.left
        popover?.backgroundColor = UIColor.white
        popover?.sourceView = self.notesBtn
        popover?.sourceRect = self.notesBtn.bounds
        self.present(popController, animated: true, completion: nil)
        
    }
    
    
    @IBAction func SeetingsBtnexp(_ sender: Any) {
        Constants.bayflag = 1
        var storyboard: UIStoryboard!
        var popController: UIViewController!
        
        storyboard = UIStoryboard(name: Constants.PopOver, bundle: nil)
        popController = storyboard.instantiateViewController(withIdentifier: Constants.PopOverVc) as! PopOver
        let nav = UINavigationController(rootViewController: popController)
        nav.modalPresentationStyle = UIModalPresentationStyle.popover
        let heightForPopOver = 90*3
        let popover = nav.popoverPresentationController
        popController.preferredContentSize = CGSize(width: 200 , height: heightForPopOver)
        popover?.permittedArrowDirections = .up
        popover?.backgroundColor = UIColor.white
        popover?.sourceView = self.assignserviceBtn
        popover?.sourceRect = self.assignserviceBtn.bounds//CGRect(x: self.assignBtn.bounds.midX, y: self.assignBtn.bounds.midY, width: 0, height: 0)
        self.present(nav, animated: true, completion: nil)
        
    }
    
    
    @IBAction func loadingBtnAction(_ sender: Any) {
        
        loaderWorks()
        
    }
    
    
    
    @IBAction func dropdownAction(_ sender: Any) {
        var storyboard: UIStoryboard!
        var popController: UIViewController!
        
        storyboard = UIStoryboard(name: "Mechanicpop", bundle: nil)
        popController = storyboard.instantiateViewController(withIdentifier: "MechanicpopVc") as! Mechanicpop
        let nav = UINavigationController(rootViewController: popController)
        nav.modalPresentationStyle = UIModalPresentationStyle.popover
        let heightForPopOver = 30*3
        let popover = nav.popoverPresentationController
        popController.preferredContentSize = CGSize(width: 230 , height: heightForPopOver)
        popover?.permittedArrowDirections = .left
        popover?.backgroundColor = UIColor.white
        popover?.sourceView = self.dropDwnBtn
        popover?.sourceRect = self.dropDwnBtn.bounds//CGRect(x: self.assignBtn.bounds.midX, y: self.assignBtn.bounds.midY, width: 0, height: 0)
        self.present(nav, animated: true, completion: nil)
    }
    
    
    
    
    
    func loaderWorks() {
        
        
        
        if Constants.bayid == 0 {
            ToastView.show(message: "Please Select BayName First!", controller: self)
        } else {
            flag = 1
            
            getDataDetails()
            
            
        }
    }
    
    
    
    func appearView() {
        loadingBtn.alpha = 5
        loaderlabel.alpha = 0
        loadingBtn.isHidden = true
        loaderlabel.isHidden = true
        
        
        UIView.animate(withDuration: 0.6, animations: {
            self.collectionViewSlot.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            self.collectionViewSlot.alpha = 5
            self.collectionViewSlot.alpha = 1
        }, completion: {
            finished in
            self.collectionViewSlot.transform = CGAffineTransform.identity
            self.loadingBtn.isHidden = true
            self.loaderlabel.isHidden = true
            self.collectionViewSlot.delegate = self
            self.collectionViewSlot.dataSource = self
            self.notesBtn.isUserInteractionEnabled = true
            self.checkcarBtn.isUserInteractionEnabled = true
            self.finishBtn.isUserInteractionEnabled = true
            self.dropDwnBtn.isUserInteractionEnabled = true
            self.carNamelbl.isHidden = false
            self.milesBtn.isHidden = false
            self.platenumberlbl.isHidden = false
            self.checkcarBtn.isSelected = true
            self.finishBtn.isSelected = true
            
        })
    }
    
    
    func disappearView() {
        loadingBtn.alpha = 5
        loaderlabel.alpha = 0
        loadingBtn.isHidden = false
        loaderlabel.isHidden = false
        
        
        UIView.animate(withDuration: 0.9, animations: {
            self.loadingBtn.alpha = 5
            self.loaderlabel.alpha = 1
        }, completion: {
            finished in
            self.loadingBtn.isHidden = false
            self.loaderlabel.isHidden = false
            self.collectionViewSlot.delegate = self
            self.collectionViewSlot.dataSource = self
            self.notesBtn.isUserInteractionEnabled = false
            self.checkcarBtn.isUserInteractionEnabled = false
            self.finishBtn.isUserInteractionEnabled = false
            self.dropDwnBtn.isUserInteractionEnabled = false
            self.carNamelbl.isHidden = true
            self.milesBtn.isHidden = true
            self.platenumberlbl.isHidden = true
            self.checkcarBtn.isSelected = false
            self.finishBtn.isSelected = false
            
        })
    }
    
    
    
    
    
    func SaveNotesData() {
        
        let parameters = [ Constants.SessionID: Constants.sessions,
                           Constants.NotesComment: DataNotes.comment,
                           Constants.NotesStatus: "0",
                           Constants.OrderID: Constants.orderidmechanic,
                           Constants.CarID: Constants.caridmechanic,
                           Constants.NotesImages: DataNotes.images]    as [String : Any]
        
        guard let url = URL(string: "\(CallEngine.baseURL)\(CallEngine.Notespost)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        let jsonS = NSString(data: httpBody, encoding: String.Encoding.utf8.rawValue)
        if let json = jsonS {
            print(json)
        }
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if response == nil {
                DispatchQueue.main.async {
                    ToastView.show(message: Constants.interneterror, controller: self)
                }
            }
            if let response = response {
                print(response)
            }
            
            if let data = data {
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {return}
                    print(json)
                    let status = json[Constants.Status] as? Int
                    let newmessage = json[Constants.Description] as? String
                    if (status == 1) {
                        print("sucess")
                         self.removeData()
                    }
                    else if (status == 0) {
                        DispatchQueue.main.async {
                            ToastView.show(message: newmessage!, controller: self)
                            self.removeData()
                        }
                    }
                    
                    else if (status == 1000) {
                        DispatchQueue.main.async {
                            ToastView.show(message: Constants.wrong, controller: self)
                            self.removeData()
                        }
                    }
                    
                    else if (status == 1001) {
                        DispatchQueue.main.async {
                            ToastView.show(message: Constants.invalid, controller: self)
                            self.removeData()
                        }
                    }
                    
                    else {
                        DispatchQueue.main.async {
                            ToastView.show(message: Constants.occured, controller: self)
                            self.removeData()
                        }
                    }
                    
                    
                } catch {
                    print(error)
                }
            }
            
            }.resume()
        
    }
    
    
    func SaveChecklist()  {
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data1 = try! encoder.encode(Checklist.CheckcarPost)
        guard let arreydetails = try? JSONSerialization.jsonObject(with: data1, options: []) as? Any else {return}
        
        let parameters = [
            Constants.OrderID: Constants.orderidmechanic,
            Constants.CarID: Constants.caridmechanic,
            Constants.SessionID: Constants.sessions,
            Constants.InspectionDetails: arreydetails as Any]  as [String : Any]
        
        let saveapi = ("\(CallEngine.baseURL)\(CallEngine.checklistpost)")
        let url = URL(string: saveapi)
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
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
                    ToastView.show(message: Constants.interneterror, controller: self)
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
                        print("sucess")
                    }
                    else if (status == 0) {
                        
                        DispatchQueue.main.async {
                            ToastView.show(message: newmessage!, controller: self)
                        }
                    }
                    
                    else if (status == 1000) {
                        
                        DispatchQueue.main.async {
                            ToastView.show(message: Constants.wrong, controller: self)
                        }
                    }
                    
                    else if (status == 1001) {
                        
                        DispatchQueue.main.async {
                            ToastView.show(message: Constants.invalid, controller: self)
                        }
                    }
                    
                    else {
                        
                        DispatchQueue.main.async {
                            ToastView.show(message: Constants.occured, controller: self)
                        }
                    }
                    
                } catch {
                    print(error)
                    ToastView.show(message: "Edit Failed! error occured", controller: self)
                }
                
            }
            }.resume()
        
    }
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func finshedAndSaveBtn(_ sender: Any) {
        AssignToFinished()
        flag = 0
    }
    
    func removeData() {
        DataNotes.comment.removeAll()
        DataNotes.images.removeAll()
        Checklist.CheckcarPost.removeAll()
    }
    
    
    
    
    @IBAction func checkcarBtn(_ sender: Any) {
        
        if let vc = self.parent as? ReceptionalistView {
            let storyboard = UIStoryboard(name: Constants.CheckCarController, bundle: nil)
            let newCarvc = storyboard.instantiateViewController(withIdentifier: Constants.CheckCarControllerVc) as! CheckCarController
            vc.switchViewController(vc: newCarvc, showFooter: false)
        }
        
    }
    
    
    
    func AssignToFinished() {
        
        
        let parameters = [
            Constants.OrderID: Constants.orderidmechanic,
            Constants.BayID: Constants.bayid,
            Constants.type: "bay",
            Constants.SessionID: Constants.sessions]  as [String : Any]
        
        let url = URL(string:"\(CallEngine.baseURL)\(CallEngine.WorkDone)")!
        
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
                    ToastView.show(message: Constants.interneterror, controller: self)
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
                        
                        if   (DataNotes.comment.isEmpty == false) ||  (DataNotes.images.isEmpty == false)  {
                            self.SaveNotesData()
                        }
                        if  ( Checklist.CheckcarPost.isEmpty == false) {
                            self.SaveChecklist()
                        }
                        ToastView.show(message: newmessage!, controller: self)
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                            if let parentVC = self.parent as? ReceptionalistView {
                                let storyboard = UIStoryboard(name: Constants.MechanicView, bundle: nil)
                                let vc = storyboard.instantiateViewController(withIdentifier: Constants.MechanicVc) as? MechanicView
                                parentVC.switchViewController(vc: vc!, showFooter: true)
                            }
                        })
                        
                    }
                        
                    else if (status == 0) {
                        
                        DispatchQueue.main.async {
                        ToastView.show(message: newmessage!, controller: self)
                        }
                    }
                    
                    else if (status == 1000) {
                        
                        DispatchQueue.main.async {
                            ToastView.show(message: Constants.wrong, controller: self)
                        }
                    }
                    
                    else if (status == 1001) {
                        
                        DispatchQueue.main.async {
                            ToastView.show(message: Constants.invalid, controller: self)
                        }
                    }
                    
                    else {
                        
                        DispatchQueue.main.async {
                            ToastView.show(message: Constants.occured, controller: self)
                        }
                    }
                    
                } catch {
                    print(error)
                    ToastView.show(message: "Edit Failed! error occured", controller: self)
                }
                
            }
            }.resume()
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let vc = self.parent as? ReceptionalistView {
            vc.addFooterView1(selected: 1)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
