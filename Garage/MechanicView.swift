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

class MechanicView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var Subview: UIView!
    @IBOutlet weak var loadingBtn: UIButton!
    @IBOutlet weak var assignserviceBtn: UIButton!
    @IBOutlet weak var notesBtn: UIButton!
    @IBOutlet weak var collectionViewSlot: UICollectionView!
    @IBOutlet weak var loaderlabel: UILabel!
    @IBOutlet weak var checkcarBtn: UIButton!
    @IBOutlet weak var finishBtn: UIButton!
    @IBOutlet weak var carNamelbl: UILabel!
    @IBOutlet weak var platenumberlbl: UILabel!
    
     var OrderDetails = [Orderdetail]()
     let reuseIdentifier = "MechanicCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    notesBtn.isUserInteractionEnabled = false
        checkcarBtn.isUserInteractionEnabled = false
        carNamelbl.isHidden = true
        platenumberlbl.isHidden = true
        
        assignserviceBtn.setTitle("\(Constants.bayname)", for: .normal)
    }
    
    
    private func getData() {
        let url = "\(CallEngine.baseURL)\(CallEngine.LoadCardetailsapi)\(Constants.bayid)/\(Constants.sessions)"
        print(url)
        Alamofire.request(url).response { [weak self] (response) in
            guard self != nil else { return }
            if let error = response.error {
                debugPrint("🔥 Network Error : ", error)
            } else {
                do {
                    let json = try JSON(data: response.data!)
                    print("🌎 Response : ", json)
                    let status = json["Status"].intValue
                    let desc = json["Description"].stringValue
                    if ((status == 1) && (desc == "Success")) {
                        
                        let CarInfo = json[Constants.Cars].arrayValue
                          for cars in CarInfo {
                            
                        
                        
                            let CheckLitre = cars[Constants.CheckLitre].stringValue
                                DispatchQueue.main.async {
                                   // self.check.text = CheckLitre
                                }
                            
                            
                         
                            let RegistrationNo = cars[Constants.RegistrationNo].stringValue
                                DispatchQueue.main.async {
                                    self!.platenumberlbl.text = RegistrationNo
                                }
                            
                            
                            let RecommendedAmount = cars[Constants.RecommendedAmount].stringValue
                                DispatchQueue.main.async {
                                    //  self.recommendedAmount.text =  RecommendedAmount
                                }
                            
                            
                            
                             let CarName = cars[Constants.CarName].stringValue
                                DispatchQueue.main.async {
                                    self!.carNamelbl.text = CarName//
                                }
                                
                            
                            
                            }
                        
                        
                            
                            
                        
    
                        
                        let Notes = json["Notes"].dictionaryValue
                        
                        
                        
                        let Orderlist = json["Orderdetail"].arrayValue
                        for order in Orderlist {
                           
                      let OrderDetailID = order["OrderDetailID"].intValue
                             let OrderID = order["OrderID"].intValue
                            let ItemID = order["ItemID"].intValue
                             let ItemName = order["ItemName"].stringValue
                            let ItemImage = order["ItemImage"].stringValue
                             let Quantity = order["Quantity"].intValue
                             let Price = order["Price"].intValue
                             let TotalCost = order["TotalCost"].intValue
                            let LOYALTYPoints = order["LOYALTYPoints"].intValue
                           // let isComplementory = order["isComplementory"].stringValue
                            let StatusID = order["StatusID"].intValue
                             let ItemDate = order["ItemDate"].stringValue
                             let Mode = order["Mode"].stringValue
                            
                            let orders = Orderdetail(OrderDetailID: OrderDetailID, OrderID: OrderID,ItemID: ItemID, ItemName: ItemName, ItemImage: ItemImage, Quantity: Quantity, Price: Price,  TotalCost: TotalCost, LOYALTYPoints: LOYALTYPoints, StatusID: StatusID, ItemDate: ItemDate, Mode: Mode)
                           self?.OrderDetails.append(orders)
                        DispatchQueue.main.async {
                            self?.collectionViewSlot.reloadData()
                           }
                        }
                    }
                } catch {
                    debugPrint("🔥 Network Error : ", error)
                }
            }
        }
    }
    
    
    // MARK: - UICollectionViewDataSource protocol
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 30, left: 15, bottom: 30, right: 15)
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MechanicCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        cell.subtitle.text = OrderDetails[indexPath.item].ItemName
      
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }
    
    
    
    
    @IBAction func notesAction(_ sender: Any) {
        var storyboard: UIStoryboard!
        var popController: UIViewController!
        
        storyboard = UIStoryboard(name: "notespopup", bundle: nil)
        popController = storyboard.instantiateViewController(withIdentifier: "notesPopupVc") as! notesPopup
        let nav = UINavigationController(rootViewController: popController)
        nav.modalPresentationStyle = UIModalPresentationStyle.popover
        let heightForPopOver = 250*2
        let popover = nav.popoverPresentationController
        popController.preferredContentSize = CGSize(width: 500 , height: heightForPopOver)
        popover?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 3)
        popover?.permittedArrowDirections = .left
        popover?.backgroundColor = UIColor.white
        popover?.sourceView = self.notesBtn
        popover?.sourceRect = self.notesBtn.bounds
        self.present(nav, animated: true, completion: nil)
    }
    
    
    
    
    
    @IBAction func SeetingsBtnexp(_ sender: Any) {
        var storyboard: UIStoryboard!
        var popController: UIViewController!
        
        storyboard = UIStoryboard(name: "PopOver", bundle: nil)
        popController = storyboard.instantiateViewController(withIdentifier: "PopOverVc") as! PopOver
        let nav = UINavigationController(rootViewController: popController)
        nav.modalPresentationStyle = UIModalPresentationStyle.popover
        let heightForPopOver = 80*3
        let popover = nav.popoverPresentationController
        popController.preferredContentSize = CGSize(width: 200 , height: heightForPopOver)
        popover?.permittedArrowDirections = .up
        popover?.backgroundColor = UIColor.white
        popover?.sourceView = self.assignserviceBtn
        popover?.sourceRect = self.assignserviceBtn.bounds//CGRect(x: self.assignBtn.bounds.midX, y: self.assignBtn.bounds.midY, width: 0, height: 0)
        assignserviceBtn.setTitle("\(Constants.bayname)", for: .normal)
        self.present(nav, animated: true, completion: nil)
        
    }
    
    
    @IBAction func loadingBtnAction(_ sender: Any) {
        
        if Constants.bayid == 0 {
            
           ToastView.show(message: "Please Select BayName First!", controller: self)
            
        } else {
            getData()
      
            appearView()
        }
      
         // DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
       
//        UIView.animate(withDuration: 0.5, delay: 0.4,
//                       options: [.repeat, .autoreverse, .curveEaseOut],
//                       animations: {
////                               self.collectionViewSlot.delegate = self
////                                self.collectionViewSlot.dataSource = self
////                                self.notesBtn.isUserInteractionEnabled = true
////                                carNamelbl.isHidden = true
////                               platenumberlbl.isHidden = true
//
//        }, completion: nil)
    }
    
    
    
    
    
    
    
    func appearView() {
        loadingBtn.alpha = 5
        loaderlabel.alpha = 0
        loadingBtn.isHidden = true
        loaderlabel.isHidden = true
       
        
        UIView.animate(withDuration: 0.9, animations: {
            self.loadingBtn.alpha = 5
            self.loaderlabel.alpha = 1
        }, completion: {
            finished in
            self.loadingBtn.isHidden = true
            self.loaderlabel.isHidden = true
            self.collectionViewSlot.delegate = self
            self.collectionViewSlot.dataSource = self
            self.notesBtn.isUserInteractionEnabled = true
            self.checkcarBtn.isUserInteractionEnabled = true
            self.carNamelbl.isHidden = false
            self.platenumberlbl.isHidden = false
            self.checkcarBtn.isSelected = true
            self.finishBtn.isSelected = true
            
        })
    }
    
    
    
    
    @IBAction func checkcarBtn(_ sender: Any) {
        
        if let vc = self.parent as? ReceptionalistView {
            let storyboard = UIStoryboard(name: "CheckCarController", bundle: nil)
            let newCarvc = storyboard.instantiateViewController(withIdentifier: "CheckCarControllerVc") as! CheckCarController
            vc.switchViewController(vc: newCarvc, showFooter: false)
        }
        
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
