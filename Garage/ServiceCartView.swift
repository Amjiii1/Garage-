//
//  ServiceCartView.swift
//  Garage
//
//  Created by Amjad Ali on 7/31/18.
//  Copyright © 2018 Amjad Ali. All rights reserved.
//

import UIKit
import Alamofire 
import SwiftyJSON





struct Items {
    static var nameArray = [AnyObject]()
    static var Product = [ReceiptModel]()
}


class ServiceCartView: UIViewController, UISearchBarDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var serviceSearch: UITextField!
    @IBOutlet weak var kilometers: UIButton!
    @IBOutlet weak var Reassignoutlet: UIButton!
    @IBOutlet weak var subcategoryBtn: UIButton!
    @IBOutlet weak var receiptOutlet: UIButton!
    @IBOutlet weak var itemBtn: UIButton!
    @IBOutlet weak var category: UIButton!
    @IBOutlet weak var colectionview: UICollectionView!
    @IBOutlet weak var cellview: CollectionViewCell!
    
    var categories = [Category]()
    // var Product = [ReceiptModel]()
    var nameArray = [String]()
    var Searchitems = [Item]()
    
    var currentState = 0
    var categoryIndex = 0
    var subCategoryIndex = 0
    var count = 0
    var updateprice  = 0
    let dateFormatter : DateFormatter = DateFormatter()
    var meanValuesArray : [String] = ["","0","1","1", "0", ""]
    var scores = ["x" : 1, "y" : 1, "z" : 1, "t": 1]
    
    var new = [Int]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(Items.nameArray)")
        serviceSearch.attributedPlaceholder = NSAttributedString(string: "Search a Service Name", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        subcategoryBtn.isHidden = true
        itemBtn.isHidden = true
        colectionview.delegate = self
        colectionview.dataSource = self
        category.backgroundColor = UIColor.gray
        getData()
        self.receiptOutlet.setTitle("\( Constants.totalprice) SAR", for: .normal)
        
      
        serviceSearch.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(ServiceCartView.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)
    }
    
    deinit {
        
        NotificationCenter.default.removeObserver(self, name: Notification.Name("NotificationIdentifier"), object: nil)
    }
    
    
    
    @objc func methodOfReceivedNotification(notification: Notification) {
        self.receiptOutlet.setTitle("\( Constants.totalprice) SAR", for: .normal)
    }
    
    
    
    private func getData() {
        let url = "\(CallEngine.baseURL)\(CallEngine.productapi)\(Constants.sessions)"
        print(url)
        Alamofire.request(url).response { [weak self] (response) in
            if response == nil {
                DispatchQueue.main.async {
                    ToastView.show(message: "Login failed! Check internet", controller: self!)
                }
            }
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
                        let categoriesList = json["CategoriesList"].arrayValue
                        
                        var subCategories = [SubCategory]()
                        var items = [Item]()
                        
                        
                        for cat in categoriesList {
                            let subCategoriesList = cat["SubCategoriesList"].arrayValue
                            let categoryID = cat["CategoryID"].intValue
                            let name = cat["Name"].stringValue
                            let alternateName = cat["AlternateName"].stringValue
                            let catDesc = cat["Description"].stringValue
                            let catImage = cat["Image"].stringValue
                            let catStatus = cat["Status"].intValue
                            let catDisplayOrder = cat["DisplayOrder"].intValue
                            let catLastUpdatedDate = cat["LastUpdatedDate"].stringValue
                            
                            subCategories = []
                            
                            for sub in subCategoriesList {
                                let itemsList = sub["ItemsList"].arrayValue
                                let subCategoryID = sub["CategoryID"].intValue
                                let subSubCategoryID = sub["SubCategoryID"].intValue
                                let subName = sub["Name"].stringValue
                                let subAlternateName = sub["AlternateName"].stringValue
                                let subDescription = sub["Description"].stringValue
                                let subImage = sub["Image"].stringValue
                                let subStatus = sub["Status"].intValue
                                let subDisplayOrder = sub["DisplayOrder"].intValue
                                let subLastUpdatedDate = sub["LastUpdatedDate"].stringValue
                                
                                items = []
                                self!.Searchitems = []
                                
                                for item in itemsList {
                                    let itemID = item["ItemID"].intValue
                                    let itemName = item["Name"].stringValue
                                    let itemAlternateName = item["AlternateName"].stringValue
                                    let itemDescription = item["Description"].stringValue
                                    let price = item["Price"].intValue
                                    let itemImage = item["Image"].stringValue
                                    let barcode = item["Barcode"].stringValue
                                    let itemType = item["ItemType"].stringValue
                                    let itemStatus = item["Status"].intValue
                                    let itemLastUpdatedDate = item["LastUpdatedDate"].stringValue
                                    let itemDisplayOrder = item["DisplayOrder"].intValue
                                    let itemCategoryID = item["CategoryID"].intValue
                                    let itemSubCategoryID = item["SubCategoryID"].intValue
                                    
                                    let modifiers = [Modifier]()
                                    
                                    let newItem = Item(itemID: itemID, name: itemName, alternateName: itemAlternateName, desc: itemDescription, price: price, image: itemImage, barcode: barcode, itemType: itemType, status: itemStatus, lastUpdatedDate: itemLastUpdatedDate, displayOrder: itemDisplayOrder, categoryID: itemCategoryID, subCategoryID: itemSubCategoryID, modifiers: modifiers)
                                    items.append(newItem)
                                    self!.Searchitems.append(newItem)
                                }
                                let newSubCategory = SubCategory(items: items, categoryID: subCategoryID, subCategoryID: subSubCategoryID, name: subName, alternateName: subAlternateName, desc: subDescription, image: subImage, status: subStatus, displayOrder: subDisplayOrder, lastUpdatedDate: subLastUpdatedDate)
                                subCategories.append(newSubCategory)
                            }
                            let newCategory = Category(subCategories: subCategories, categoryID: categoryID, name: name, alternateName: alternateName, desc: catDesc, image: catImage, status: catStatus, displayOrder: catDisplayOrder, lastUpdatedDate: catLastUpdatedDate)
                            self?.categories.append(newCategory)
                            DispatchQueue.main.async {
                                self?.colectionview.reloadData()
                            }
                        }
                    }
                } catch {
                    debugPrint("🔥 Network Error : ", error)
                }
            }
        }
    }
    
    
    
    @IBAction func HomeButtonTemp(_ sender: Any) {
        
        removeDataa()
        if let parentVC = self.parent as? ReceptionalistView {
            let storyboard = UIStoryboard(name: "WelcomeView", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "WelcomeVc") as? WelcomeView
            parentVC.switchViewController(vc: vc!, showFooter: true)
        }
    }
    
    
    
    
    
    
    @IBAction func oncategoryTab(_ sender: Any) {
        subcategoryBtn.isHidden = true
        itemBtn.isHidden = true
        
        category.backgroundColor = UIColor.gray
        
        currentState = 0
        reloadData()
    }
    
    @IBAction func OnSubcategorytab(_ sender: Any) {
        subcategoryBtn.isHidden = false
        itemBtn.isHidden = true
        
        subcategoryBtn.backgroundColor = UIColor.gray
        category.backgroundColor = UIColor.darkGray
        currentState = 1
        reloadData()
    }
    
    @IBAction func onitemTab(_ sender: Any) {
        
        itemBtn.backgroundColor = UIColor.gray
        subcategoryBtn.backgroundColor = UIColor.darkGray
        category.backgroundColor = UIColor.darkGray
        
        currentState = 2
        reloadData()
    }
    
    
    private func reloadData() {
        print("Current State : ", currentState)
        print("Category Index : ", categoryIndex)
        print("Sub Category Index : ", subCategoryIndex)
        //        print("Category Count : ", categories.count)
        //        print("SuCategory Count : ", categories[categoryIndex].subCategories.count)
        //        print("Item Count : ", categories[categoryIndex].subCategories[subCategoryIndex].items.count)
        DispatchQueue.main.async {
            self.colectionview.reloadData()
        }
    }
    
    override func viewDidLayoutSubviews() {
        //                addBtn.layer.cornerRadius = addBtn.frame.size.width/2
        //                 subtractBtn.layer.cornerRadius = subtractBtn.frame.size.width/2
        //         productView.layer.cornerRadius = 16.0
        //        productView.layer.masksToBounds = true
    }
    
    @IBAction func receptBtn(_ sender: Any) {
        self.receiptOutlet.setTitle("\( Constants.totalprice) SAR", for: .normal)
        Receiptdetails()
    }
    
    @IBAction func nextBtn(_ sender: Any) {
        
        print(Items.Product.first as Any)
        
        if   (Items.Product.first != nil)    {
            
            PunchOder()
            removeDataa()
            
        }
        else {
            
            ToastView.show(message: "Please Select Items!", controller: self)
            
        }
        
        
        
        
        
    }
    
    func removeDataa() {
        Items.nameArray.removeAll()
        Items.Product.removeAll()
        Constants.platenmb = "0"
        Constants.vinnmb = "0"
        Constants.CarIDData = 0
        Constants.totalprice = 0
        Constants.counterQTY = 1
        
    }
    
    
    
    @IBAction func REassignBtn(_ sender: Any) {
        var storyboard: UIStoryboard!
        var popController: UIViewController!
        
        storyboard = UIStoryboard(name: "PopOver", bundle: nil)
        popController = storyboard.instantiateViewController(withIdentifier: "PopOverVc") as! PopOver
        let nav = UINavigationController(rootViewController: popController)
        nav.modalPresentationStyle = UIModalPresentationStyle.popover
        let heightForPopOver = 80 * 3
        let popover = nav.popoverPresentationController
        popController.preferredContentSize = CGSize(width: 200 , height: heightForPopOver)
        popover?.permittedArrowDirections = .up
        popover?.backgroundColor = UIColor.white
        popover?.sourceView = self.Reassignoutlet
        popover?.sourceRect = self.Reassignoutlet.bounds
        self.present(nav, animated: true, completion: nil)
    }
    
    @IBAction func backBtn(_ sender: Any) {
        Items.Product.removeAll()
        Items.nameArray.removeAll()
        Constants.totalprice = 0
        if let parentVC = (self.parent as? ReceptionalistView) {
            let storyboard = UIStoryboard(name: "AddnewCar", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "addNewCarVc") as? addNewCar
            parentVC.switchViewController(vc: vc!, showFooter: false)
        }
    }
    
    func Receiptdetails() {
        var storyboard: UIStoryboard!
        var popController: UIViewController!
        storyboard = UIStoryboard(name: "Receiptpopover", bundle: nil)
        popController = storyboard.instantiateViewController(withIdentifier: "ReceiptpopVc") as! Receiptpop
        let nav = UINavigationController(rootViewController: popController)
        nav.modalPresentationStyle = UIModalPresentationStyle.popover
        let heightForPopOver = 160 * 3
        let popover = nav.popoverPresentationController
        popController.preferredContentSize = CGSize(width: 500 , height: heightForPopOver)
        popover?.permittedArrowDirections = .up
        popover?.backgroundColor = UIColor.white
        popover?.sourceView = self.receiptOutlet
        popover?.sourceRect = self.receiptOutlet.bounds
        self.present(nav, animated: true, completion: nil)
    }
}





extension ServiceCartView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        switch currentState {
        case 1:
            return categories[categoryIndex].subCategories.count
        case 2:
            return categories[categoryIndex].subCategories[subCategoryIndex].items.count
        default:
            return categories.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        
        switch currentState {
        case 1:
            cell.populate(with: categories[categoryIndex].subCategories[indexPath.row].name, image: categories[categoryIndex].subCategories[indexPath.row].image)
            cell.plusBtn.isHidden = true
            cell.minusBtn.isHidden = true
            cell.countLbl.isHidden = true
        case 2:
            cell.populate(with: categories[categoryIndex].subCategories[subCategoryIndex].items[indexPath.row].name, image: categories[categoryIndex].subCategories[subCategoryIndex].items[indexPath.row].image)
            cell.plusBtn.isHidden = false
            cell.minusBtn.isHidden = false
            cell.countLbl.isHidden = false
            //      new = [(categories[categoryIndex].subCategories[subCategoryIndex].items[indexPath.row].itemID)]
            //             print(new)
            
            count = count+1
            print("\(count)")
            cell.decorate(for: "\(count)", in: self)
            print(count)
        default:
            cell.populate(with: categories[indexPath.row].name, image: categories[indexPath.row].image)
            // cell.cellDelegate = self
            cell.index = indexPath
            cell.plusBtn.isHidden = true
            cell.minusBtn.isHidden = true
            cell.countLbl.isHidden = true
            cell.countLbl.text = "\(count)"
            print("\(count)")
            // cell.decorate(for: "\(count)", in: self)
            
            
        }
        
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    }
   
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: colectionview.frame.size.width / 3.4, height: colectionview.frame.size.height / 2.7)
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
       
        let cell = colectionview.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 2.0
        cell?.layer.borderColor = UIColor.clear.cgColor
     
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        
        switch currentState {
        case 0:
            
            currentState = 1
            cell.plusBtn.isHidden = true
            cell.minusBtn.isHidden = true
            cell.countLbl.isHidden = true
            categoryIndex = indexPath.row
            subcategoryBtn.isHidden = false
            itemBtn.isHidden = true
            reloadData()
            subcategoryBtn.backgroundColor = UIColor.gray
            category.backgroundColor = UIColor.darkGray
           
        case 1:
            currentState = 2
            cell.plusBtn.isHidden = false
            cell.minusBtn.isHidden = false
            cell.countLbl.isHidden = false
            subCategoryIndex = indexPath.row
            subcategoryBtn.isHidden = false
            itemBtn.isHidden = false
            
            reloadData()
            itemBtn.backgroundColor = UIColor.gray
            subcategoryBtn.backgroundColor = UIColor.darkGray
            
        default:
            let new = cell.countLbl.text
            let stringArray = new!.components(separatedBy: CharacterSet.decimalDigits.inverted)
            for item in stringArray {
                if let number = Int(item) {
                    Constants.counterQTY = number
                }
            }
            let name = [(categories[categoryIndex].subCategories[subCategoryIndex].items[indexPath.row])]
            cell.plusBtn.tag = indexPath.row
            cell.minusBtn.tag = indexPath.row
            print(indexPath.row)
            
            for newname in name {
                let product = ReceiptModel(Name: newname.name, Price: Double(newname.price*Constants.counterQTY), ItemID: newname.itemID, Quantity:  Constants.counterQTY, Mode: Constants.mode, OrderDetailID: 0, Status: 201)
                
                Items.Product.append(product)
                
                
                
                //                 let price = newname.price*Constants.counterQTY
                //                Constants.totalprice = Constants.totalprice + price
                //                self.receiptOutlet.setTitle("\( Constants.totalprice) SAR", for: .normal)
                
//                let dict = [
//                    "Name": newname.name, "Price":newname.price*Constants.counterQTY, "Quantity": Constants.counterQTY, "ItemID": newname.itemID, "Mode": Constants.mode, "OrderDetailID": 0, "Status": 201] as [String : Any]
                
                let price = newname.price*Constants.counterQTY
                Constants.totalprice = Constants.totalprice + Double(price)
                self.receiptOutlet.setTitle("\( Constants.totalprice) SAR", for: .normal)
                
                
            }
            let cell = colectionview.cellForItem(at: indexPath)
            cell?.layer.borderWidth = 2.0
            cell?.layer.borderColor = UIColor.DefaultApp.cgColor
            
            
            break
        }
        
    }
    
    
    
    func PunchOder() {
        
        
//        if Constants.flagEdit != 0 {
            
      
       
//          if Constants.flagEdit != 0 {
//
//        for models in Items.Product {
//            print(models)
//            if models.Status == 201 {
//                  print(models)
//                Items.Product.append(models)
//            } else {
//
//                Items.Product.removeAll()
//
//            }
//
//
//        }
//        }
        if Constants.flagEdit != 0 {
            
            for models in Items.Product {
                if models.Status == 201 {
                    print(models)
                   Items.Product.append(models)
                    
                } else {
                    
                   Items.Product.removeAll()
                    
                }
                
                
            }
        }
        
        
        
   if Constants.flagEdit != 0 {
    
    for System in Items.nameArray {
        
        Items.Product.append(System as! ReceiptModel)
    }
        }
    
       
        print(Items.Product)
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data1 = try! encoder.encode(Items.Product)
//           let json = String(data: data1, encoding: String.Encoding.utf8)
//          let testd = Int(json!.filter { !" \n\t\\r\\".contains($0) })
       
        
        
        guard let test = try? JSONSerialization.jsonObject(with: data1, options: []) as? Any else {return}
       print(test)
        var urlorderpunch = ""
        
        print(Constants.OrderIDData)
        
        let parameters = [
            "SessionID": Constants.sessions,
            "CarID": Constants.CarIDData,
            "OrderTakerID":Constants.ordertracker,
            "BayID": Constants.bayid,
            "OrderID": Constants.OrderIDData,
            "OrderPunchDt": Constants.currentdate,
            "OrderNo":Constants.OrderNoData,
            "Items": test as Any]  as [String : Any]
        
        if Constants.flagEdit != 0 {
            
            urlorderpunch = "\(CallEngine.baseURL)\(CallEngine.OrderEdit)"    //BASE
            print(urlorderpunch)
            let url = URL(string: urlorderpunch)
            var request = URLRequest(url: url!)
            request.httpMethod = "PUT"
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
                        let status = json["Status"] as? Int
                        let newmessage = json["Description"] as? String
                        if (status == 1) {
                            
                            ToastView.show(message: newmessage!, controller: self)
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                                print("hello")
                                if let parentVC = self.parent as? ReceptionalistView {
                                    let storyboard = UIStoryboard(name: "WelcomeView", bundle: nil)
                                    let vc = storyboard.instantiateViewController(withIdentifier: "WelcomeVc") as? WelcomeView
                                    parentVC.switchViewController(vc: vc!, showFooter: true)
                                }
                            })
                        }
                        else if (status == 0) {
                            
                            print(status!)
                            DispatchQueue.main.async {
                                ToastView.show(message: newmessage!, controller: self)
                            }
                        }
                        
                    } catch {
                        print(error)
                        ToastView.show(message: "Edit Failed! error occured", controller: self)
                    }
                    
                }
                }.resume()
            
        }
        else {
            
            let url = URL(string: "\(CallEngine.baseURL)\(CallEngine.OrderPunchApi)")!
            
            print(urlorderpunch)
            
            //let url = URL(string: urlorderpunch)
            var request = URLRequest(url: url)
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
                        let status = json["Status"] as? Int
                        let newmessage = json["Description"] as? String
                        if (status == 1) {
                            
                            ToastView.show(message: newmessage!, controller: self)
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                                print("hello")
                                if let parentVC = self.parent as? ReceptionalistView {
                                    let storyboard = UIStoryboard(name: "WelcomeView", bundle: nil)
                                    let vc = storyboard.instantiateViewController(withIdentifier: "WelcomeVc") as? WelcomeView
                                    parentVC.switchViewController(vc: vc!, showFooter: true)
                                }
                            })
                        }
                        else if (status == 0) {
                            
                            print(status!)
                            DispatchQueue.main.async {
                                ToastView.show(message: newmessage!, controller: self)
                            }
                        }
                        
                    } catch {
                        print(error)
                        ToastView.show(message: "Edit Failed! error occured", controller: self)
                    }
                    
                }
                }.resume()
            
        }
    }
}



enum mathFunction {
    /// When Addition is to done
    case Add
    
    
    case Subtract
    
    
    
    
}


