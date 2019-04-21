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

class ServiceCartView: UIViewController, UISearchBarDelegate, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var serviceSearch: UITextField!
    @IBOutlet weak var kilometers: UIButton!
    @IBOutlet weak var Reassignoutlet: UIButton!
    @IBOutlet weak var subcategoryBtn: UIButton!
    @IBOutlet weak var receiptOutlet: UIButton!
    @IBOutlet weak var itemBtn: UIButton!
    @IBOutlet weak var category: UIButton!
    @IBOutlet weak var colectionview: UICollectionView!
    @IBOutlet weak var cellview: CollectionViewCell!
    @IBOutlet weak var Nextoutlet: UIButton!
    @IBOutlet weak var searchView: UIView!
    
    private var SearchbarTbl: UITableView!
    var categories = [Category]()
    // var Product = [ReceiptModel]()
    var nameArray = [String]()
    var Searchitems = [Item]()
    var itemsfilter = [Item]()
    var searchResultController: SearchResultsController!
    var tblSearchResult: UITableView?
    var searchActive : Bool = false
    
    var data = ["San Francisco","New York","San Jose","Chicago","Los Angeles","Austin","Seattle"]
    
    var filtered:[String] = []

    
    
    
    
    var currentState = 0
    var categoryIndex = 0
    var subCategoryIndex = 0
    var count = 0
    var updateprice  = 0
    let dateFormatter : DateFormatter = DateFormatter()
    var meanValuesArray : [String] = ["","0","1","1", "0", ""]
    var scores = ["x" : 1, "y" : 1, "z" : 1, "t": 1]
    
    var new = [Int]()
    
    var AllData:Array<Dictionary<String,String>> = []
    var SearchData:Array<Dictionary<String,String>> = []
    var search:String=""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getSearchData()
        
        AllData = [["pic":"list0.jpg", "name":"Angel Mark", "msg":"Hi there, I would like read your...", "time":"just now", "unread":"12"],
                   ["pic":"list1.jpg", "name":"John Doe", "msg":"I would prefer reading on night...", "time":"56 second ago", "unread":"2"],
                   ["pic":"list2.jpg", "name":"Krishta Hide", "msg":"Okey Great..!", "time":"2m ago", "unread":"0"],
                   ["pic":"list3.jpg", "name":"Keithy Pamela", "msg":"I am waiting there", "time":"5h ago", "unread":"0"]
        ]
        
        SearchData=AllData
        
       // getSearchData()
        
        
        
        
        print("\(Items.nameArray)")
        serviceSearch.attributedPlaceholder = NSAttributedString(string: "Search a Service Name", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        subcategoryBtn.isHidden = true
        itemBtn.isHidden = true
        colectionview.delegate = self
        colectionview.dataSource = self
        category.backgroundColor = UIColor.darkGray
        getData()
         BindinfItems()
        self.receiptOutlet.titleLabel?.lineBreakMode = .byWordWrapping
        self.receiptOutlet.setTitle(String(format: "%.2f \nSAR", Constants.totalprice), for: .normal)
        self.receiptOutlet.titleLabel?.textAlignment = .center
        serviceSearch.delegate = self
         // DispatchQueue.main.async {
      //      self.Customsearchtableview()
     //   }
//        serviceSearch.addTarget(self, action: #selector(SearchFunction), for: .touchDown)
//        serviceSearch.addTarget(self, action: #selector(textFieldDidChanges(_:)), for: UIControlEvents.editingChanged)
        NotificationCenter.default.addObserver(self, selector: #selector(ServiceCartView.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)
    }
    
    deinit {
        
        NotificationCenter.default.removeObserver(self, name: Notification.Name("NotificationIdentifier"), object: nil)
    }
    
    
    
    
    
    @objc func methodOfReceivedNotification(notification: Notification) {
        self.receiptOutlet.titleLabel?.lineBreakMode = .byWordWrapping
        self.receiptOutlet.setTitle(String(format: "%.2f \nSAR", Constants.totalprice), for: .normal)
        self.receiptOutlet.titleLabel?.textAlignment = .center
    }
    
    
    func BindinfItems() {
        
        if Constants.editcheckout == 1 {
            OrderEdit()
        }
        
        
    }
    
    @objc func textFieldDidChanges(_ textField: UITextField) {
        
        print(Searchitems)
        if textField.text  != "" {
            if (serviceSearch.text?.count)! != 0 {
                self.Searchitems.removeAll()
                for str in Searchitems {
                    let range = str.name.range(of: textField.text!, options: .caseInsensitive, range: nil, locale: nil)
                    print(str)
                    if range != nil {
                        self.Searchitems.append(str)
                    }
                    
                }
            }
            SearchbarTbl.reloadData()
            
        } else {
            
            serviceSearch.resignFirstResponder()
            serviceSearch.text = ""
            self.Searchitems.removeAll()
            for str in Searchitems {
                Searchitems.append(str)
            }
            SearchbarTbl.reloadData()
            
        }
      
    }
    
    
//
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
//    {
//        if string.isEmpty
//        {
//            search = String(search.characters.dropLast())
//        }
//        else
//        {
//            search=textField.text!+string
//        }
//
//        print(search)
//        let predicate=NSPredicate(format: "SELF.name CONTAINS[cd] %@", search)
//        let arr=(AllData as NSArray).filtered(using: predicate)
//
//        if arr.count > 0
//        {
//            SearchData.removeAll(keepingCapacity: true)
//            SearchData=arr as! Array<Dictionary<String,String>>
//        }
//        else
//        {
//            SearchData=AllData
//        }
//        SearchbarTbl.reloadData()
//        return true
//    }
    
    
        
        @objc func SearchFunction() {
           // serviceSearch.inputView = UIView()
          //  serviceSearch.inputAccessoryView = UIView()
         //   serviceSearch.resignFirstResponder()
            SearchbarTbl.isHidden = false
        }

//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        view.endEditing(true)
//       // colectionview.endEditing(true)
//        SearchbarTbl.isHidden = true
//        serviceSearch.resignFirstResponder()
//    }
    
    
   
        
        
        func Customsearchtableview()  {
            self.view.layoutIfNeeded()
            SearchbarTbl = UITableView(frame: CGRect(x: self.serviceSearch.frame.origin.x, y:self.serviceSearch.frame.origin.y+self.serviceSearch.frame.size.height + 125.5, width: self.serviceSearch.frame.width, height: 300))
            print(self.serviceSearch.frame.origin.y+self.serviceSearch.frame.size.height)
            SearchbarTbl.register(UITableViewCell.self, forCellReuseIdentifier: "MyCellS")
            SearchbarTbl.dataSource = self
            SearchbarTbl.delegate = self
            SearchbarTbl.backgroundColor = UIColor.darkGray
            self.view.addSubview(SearchbarTbl)
            SearchbarTbl.isHidden = true
            
        }
       
//        let searchController = UISearchController(searchResultsController: searchResultController)
//       // serviceSearch.delegate = self
//        self.present(searchController, animated:true, completion: nil)
        
//        if textField.text  != "" {
//            if (serviceSearch.text?.count)! != 0 {
//              //  self.items.removeAll()
//                for str in Searchitems {
//                    let range = str.name.range(of: textField.text!, options: .caseInsensitive, range: nil, locale: nil)
//                    if range != nil {
//              //          self.items.append(str)
//                //        categories[categoryIndex].subCategories[subCategoryIndex].items.append(str)
//                    }
//                    print(str)
//                }
//            }
//            self.colectionview.reloadData()
//
//        } else {
//
//            serviceSearch.resignFirstResponder()
//            serviceSearch.text = ""
//       //     self.items.removeAll()
//            for str in Searchitems {
//            //    items.append(str)
//            }
//            self.colectionview.reloadData()
//
//        }

  
    
  
    
    // MARK:- TableView Delegates
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
       print(Searchitems.count)
         //   return categories[categoryIndex].subCategories[subCategoryIndex].Searchitems.count
        
        return categories[categoryIndex].subCategories[subCategoryIndex].items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyCellS", for: indexPath as IndexPath)
       
          cell.textLabel!.text = categories[categoryIndex].subCategories[subCategoryIndex].items[indexPath.row].name
        
        
//         var Data:Dictionary<String,String> = SearchData[indexPath.row]
            cell.backgroundColor = UIColor.darkGray
            cell.textLabel?.textColor = UIColor.white
            return cell
        
    }
    
    
    
    
    @IBAction func SearchAction(_ sender: Any) {
        
        let searchController = UISearchController(searchResultsController: searchResultController)
        serviceSearch.delegate = self
        self.present(searchController, animated:true, completion: nil)
    }
    
    
    
    
    
    
    
    func OrderEdit() {
        
        guard let orderdetails = URL(string: "\(CallEngine.baseURL)\(CallEngine.OrderDetails)/\(Constants.editOrderid)/\(Constants.sessions)" ) else { return }
        
        let session = URLSession.shared
        
        session.dataTask(with: orderdetails){ (data, response, error) in
            if response == nil {
                DispatchQueue.main.async {
                    ToastView.show(message: Constants.interneterror, controller: self)
                }
            }
            if let data = data {
                print(data)
                
                do {
                    guard  let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {return}
                    print(json)
                    let details = Cardetails(json: json)
                    if (details.status == 1) {
                        if  let OrderID = json[Constants.OrderID] as? Int {
                            DispatchQueue.main.async {
                                Constants.OrderIDData = OrderID
                                print(Constants.OrderIDData)
                            }
                        }
                        
                        if let cars = json[Constants.Cars] as? [[String: Any]] {
                            for items in cars {
                                print("\(items)")
                                
                                if  let CarID = items[Constants.CarID] as? Int {
                                    DispatchQueue.main.async {
                                        Constants.CarIDData = CarID
                                    }
                                    
                                }
                                if  let CarName = items[Constants.CarName] as? String {
                                    DispatchQueue.main.async {
                                        Constants.CarNameData = CarName
                                    }
                                    
                                }
                                if  let ModelID = items[Constants.ModelID] as? Int {
                                    DispatchQueue.main.async {
                                        Constants.ModelIDData = ModelID
                                    }
                                    
                                }
                                if  let MakeID = items[Constants.MakeID] as? Int {
                                    DispatchQueue.main.async {
                                        Constants.MakeIDData = MakeID
                                    }
                                    
                                }
                                if  let Color = items[Constants.Color] as? String {
                                    DispatchQueue.main.async {
                                        Constants.ColorData = Color
                                    }
                                    
                                }
                                if  let CustomerID = items[Constants.CustomerID] as? Int {
                                    DispatchQueue.main.async {
                                        Constants.CustomerIDData = String (CustomerID)
                                    }
                                    
                                }
                                
                            }
                            
                        }
                        
                        
                        if let order = json["Orderdetail"] as? [[String: Any]] {
                            for orders in order {
                                print(orders)
                                let Name = orders["ItemName"] as! String
                                let Price = orders["Price"] as! Double
                                let ItemID = orders["ItemID"] as! Int
                                let Quantity = orders["Quantity"] as! Int
                                let OrderDetails = orders["OrderDetailID"] as! Int
                                let editproducts = ReceiptModel(Name: Name, Price: Price, ItemID: ItemID, Quantity: Quantity, Mode: Constants.modeupdate,OrderDetailID: OrderDetails, Status: 202)
                                Items.Product.append(editproducts)
                                let price = Price * Double(Constants.counterQTY)
                                Constants.totalprice = Constants.totalprice + Double(price)
                            }
                        }
                        DispatchQueue.main.async {
                             print(Constants.totalprice)
                            self.receiptOutlet.titleLabel?.lineBreakMode = .byWordWrapping
                            self.receiptOutlet.setTitle(String(format: "%.2f \nSAR", Constants.totalprice), for: .normal)
                            self.receiptOutlet.titleLabel?.textAlignment = .center
                        }
                        
                    }
                        
                    else if (details.status == 0) {
                        DispatchQueue.main.async {
                            ToastView.show(message: details.description, controller: self)
                        }
                    }
                    
                    else if (details.status == 1000) {
                        DispatchQueue.main.async {
                            ToastView.show(message: Constants.wrong, controller: self)
                        }
                    }
                    else if (details.status == 1001) {
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
                    
                    DispatchQueue.main.async {
                        ToastView.show(message: "Failed to load! error occured", controller: self)
                    }
                    
                }
                
            }
            
            
            }.resume()
        
    }
    
    private func getSearchData() {
        guard let url = URL(string: "\(CallEngine.baseURL)\(CallEngine.productapi)\(Constants.sessions)") else { return }

        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if response == nil {
                DispatchQueue.main.async {
                    ToastView.show(message: Constants.interneterror, controller: self)

                }
            }
            if let data = data {
                print(data)
                do {
                    guard  let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {return}
                    let status = json[Constants.Status] as? Int
                    let newmessage = json[Constants.Description] as? String
                    if (status == 1) {
                       print(json)
                         if let CategoriesList = json["CategoriesList"] as? [[String: Any]] {
                            print(CategoriesList)
                            if let SubCategoriesList = CategoriesList["SubCategoriesList"] as? [AnyObject] {
                                print(SubCategoriesList)
//
                            }

                        }


                    } else if (status == 0) {
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
                    DispatchQueue.main.async {
                        ToastView.show(message: "Login failed! Try Again", controller: self)

                    }
                }


            }


            }.resume()
    }
//
    
    
    
    
    
    
    
    
    
    private func getData() {
        let url = "\(CallEngine.baseURL)\(CallEngine.productapi)\(Constants.sessions)"
        Alamofire.request(url).response { [weak self] (response) in
            if response == nil {
                DispatchQueue.main.async {
                    ToastView.show(message: Constants.interneterror, controller: self!)
                }
            }
            guard self != nil else { return }
            if let error = response.error {
                ToastView.show(message: Constants.interneterror, controller: self!)
            } else {
                do {
                    let json = try JSON(data: response.data!)
                    print("🌎 Response : ", json)
                    let status = json[Constants.Status].intValue
                    let desc = json[Constants.Description].stringValue
                    
                    if (status == 1) {
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
                                    let price = item["Price"].doubleValue
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
                                 //   DispatchQueue.main.async {
                                    
                                   // self!.Customsearchtableview()
                                  //  }
                                }
                               

                                
                                
//                                print(items)
                                let newSubCategory = SubCategory(items: items , Searchitems: self!.Searchitems , categoryID: subCategoryID, subCategoryID: subSubCategoryID, name: subName, alternateName: subAlternateName, desc: subDescription, image: subImage, status: subStatus, displayOrder: subDisplayOrder, lastUpdatedDate: subLastUpdatedDate)
                                subCategories.append(newSubCategory)
                            }
                            let newCategory = Category(subCategories: subCategories, categoryID: categoryID, name: name, alternateName: alternateName, desc: catDesc, image: catImage, status: catStatus, displayOrder: catDisplayOrder, lastUpdatedDate: catLastUpdatedDate)
                            self?.categories.append(newCategory)
                            DispatchQueue.main.async {
                                self?.colectionview.reloadData()
//                                self?.SearchbarTbl.reloadData()
//                                self!.Customsearchtableview()
                            }
                        }
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
                }
            }
        }
    }
    
    
    
    @IBAction func HomeButtonTemp(_ sender: Any) {
        
        
        if let parentVC = self.parent as? ReceptionalistView {
            let storyboard = UIStoryboard(name: "WelcomeView", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "WelcomeVc") as? WelcomeView
            parentVC.switchViewController(vc: vc!, showFooter: true)
            removeDataa()
            
        }
    }
    
    
    
    
    
    
    @IBAction func oncategoryTab(_ sender: Any) {
        subcategoryBtn.isHidden = true
        itemBtn.isHidden = true
        
        category.backgroundColor = UIColor.darkGray
        
        currentState = 0
        reloadData()
    }
    
    @IBAction func OnSubcategorytab(_ sender: Any) {
        subcategoryBtn.isHidden = false
        itemBtn.isHidden = true
        
        subcategoryBtn.backgroundColor = UIColor.darkGray
        category.backgroundColor = UIColor.BlackApp
        currentState = 1
        reloadData()
    }
    
    @IBAction func onitemTab(_ sender: Any) {
        
        itemBtn.backgroundColor = UIColor.darkGray
        subcategoryBtn.backgroundColor = UIColor.BlackApp
        category.backgroundColor = UIColor.BlackApp
        
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
    
   
    
    @IBAction func receptBtn(_ sender: Any) {
            Receiptdetails()
    }
    
    @IBAction func nextBtn(_ sender: Any) {
        
        print(Items.Product.first as Any)
        
        if   (Items.Product.first != nil)    {
            Nextoutlet.isUserInteractionEnabled = false
            PunchOder()
            
            
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
       Constants.OrderIDData = 0
    }
    
    
    
    @IBAction func REassignBtn(_ sender: Any) {
        var storyboard: UIStoryboard!
        var popController: UIViewController!
        
        storyboard = UIStoryboard(name: Constants.PopOver, bundle: nil)
        popController = storyboard.instantiateViewController(withIdentifier: Constants.PopOverVc) as! PopOver
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
        if Constants.editcheckout != 0 {
            
            ToastView.show(message: "Sorry! You can't step back!", controller: self)
        } else
        {
        
        
        Items.Product.removeAll()
        Items.nameArray.removeAll()
        Constants.totalprice = 0
        if let parentVC = (self.parent as? ReceptionalistView) {
            let storyboard = UIStoryboard(name: Constants.AddnewCar, bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: Constants.addNewCarVc) as? addNewCar
            parentVC.switchViewController(vc: vc!, showFooter: false)
        }
        }
    }
    
    func Receiptdetails() {
        var storyboard: UIStoryboard!
        var popController: UIViewController!
        storyboard = UIStoryboard(name: Constants.Receiptpopover, bundle: nil)
        popController = storyboard.instantiateViewController(withIdentifier: Constants.ReceiptpopVc) as! Receiptpop
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
        
//        print(categories[categoryIndex].subCategories[subCategoryIndex].items.count)
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
        
        cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
        UIView.animate(withDuration: 0.3, animations: {
            cell.layer.transform = CATransform3DMakeScale(1.05,1.05,1)
        },completion: { finished in
            UIView.animate(withDuration: 0.1, animations: {
                cell.layer.transform = CATransform3DMakeScale(1,1,1)
            })
        })
    
        switch currentState {
        case 1:
            cell.populate(with: categories[categoryIndex].subCategories[indexPath.row].name, image: categories[categoryIndex].subCategories[indexPath.row].image)
            cell.plusBtn.isHidden = true
            cell.minusBtn.isHidden = true
            cell.countLbl.isHidden = true
           //  serviceSearch.isUserInteractionEnabled = false
        case 2:
            cell.populate(with: categories[categoryIndex].subCategories[subCategoryIndex].items[indexPath.row].name, image: categories[categoryIndex].subCategories[subCategoryIndex].items[indexPath.row].image)
            cell.plusBtn.isHidden = false
            cell.minusBtn.isHidden = false
            cell.countLbl.isHidden = false
           //  serviceSearch.isUserInteractionEnabled = true
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
           //  serviceSearch.isUserInteractionEnabled = false
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
//    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//
////        let cell = colectionview.cellForItem(at: indexPath)
////        cell?.layer.borderWidth = 2.0
////        cell?.layer.borderColor = UIColor.clear.cgColor
//
//    }
    
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
            subcategoryBtn.backgroundColor = UIColor.darkGray
            category.backgroundColor = UIColor.BlackApp
           // serviceSearch.isUserInteractionEnabled = false
           
        case 1:
            currentState = 2
            cell.plusBtn.isHidden = false
            cell.minusBtn.isHidden = false
            cell.countLbl.isHidden = false
            subCategoryIndex = indexPath.row
            subcategoryBtn.isHidden = false
            itemBtn.isHidden = false
            
            reloadData()
            itemBtn.backgroundColor = UIColor.darkGray
            subcategoryBtn.backgroundColor = UIColor.BlackApp
           // serviceSearch.isUserInteractionEnabled = true
            
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
                
                
                print(newname.price)
                let pp = Double(newname.price)
                print(pp)
                
                let product = ReceiptModel(Name: newname.name, Price: (newname.price * Double(Constants.counterQTY)).myRounded(toPlaces: 2), ItemID: newname.itemID, Quantity:  Constants.counterQTY, Mode: Constants.mode, OrderDetailID: 0, Status: 201)
                
                Items.Product.append(product)
                let price = newname.price * Double(Constants.counterQTY)
                Constants.totalprice = (Constants.totalprice + Double(price)).myRounded(toPlaces: 2)
            //    self.receiptOutlet.titleLabel?.numberOfLines = 0
                self.receiptOutlet.titleLabel?.lineBreakMode = .byWordWrapping
                self.receiptOutlet.setTitle(String(format: "%.2f \nSAR", Constants.totalprice), for: .normal)
                self.receiptOutlet.titleLabel?.textAlignment = .center
                
                
//                button.titleLabel?.numberOfLines = 0
//                button.titleLabel?.lineBreakMode = .byWordWrapping
//                button.setTitle("Foo\nBar", for: .normal)
//                button.titleLabel?.textAlignment = .center
                
            }
//            let cell = colectionview.cellForItem(at: indexPath)
//            cell?.layer.borderWidth = 2.0
//            cell?.layer.borderColor = UIColor.DefaultApp.cgColor
            
            
            break
        }
        
    }
    
    
    
    func PunchOder() {
        
        

        if Constants.flagEdit != 0 || Constants.editcheckout != 0 {
            
            for models in Items.Product {
                if models.Status == 201 {
                    print(models)
                   Items.Product.append(models)
                    
                } else {
                    
                   Items.Product.removeAll()
                    
                }
                
            }
        }
        
   if Constants.flagEdit != 0 || Constants.editcheckout != 0 {
    
    for System in Items.nameArray {
        
        Items.Product.append(System as! ReceiptModel)
    }
        }
        
        if Constants.editcheckout != 0 {
            
            Constants.orderstatus = 104
            
            
        }
        else{
            if Constants.flagEdit != 0  {
                if Constants.bayid != 0 {
                    
                   Constants.orderstatus = 102
                }
                else {
                    Constants.orderstatus = 101
                }
            }
        }
    
       
        print(Items.Product)
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data1 = try! encoder.encode(Items.Product)
        guard let test = try? JSONSerialization.jsonObject(with: data1, options: []) as? Any else {return}
        var urlorderpunch = ""
        print(test)
        
        
        print(Constants.OrderIDData)
        
     
        let parameters = [
            Constants.SessionID: Constants.sessions,
            Constants.CarID: Constants.CarIDData,
            Constants.OrderTakerID:Constants.ordertracker,
            Constants.BayID: Constants.bayid,
            Constants.OrderID: Constants.OrderIDData,
            Constants.OrderPunchDt: Constants.currentdate,
            Constants.OrderNo:Constants.OrderNoData,
            Constants.StatusID: Constants.orderstatus,
            Constants.Items: test as Any]  as [String : Any]
        
         if Constants.flagEdit != 0 || Constants.editcheckout != 0 {
            
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
                            
                            ToastView.show(message: newmessage!, controller: self)
                             DispatchQueue.main.async {
                          //  DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                                if Constants.editcheckout != 0 {
                                    if let parentVC = self.parent as? ReceptionalistView {
                                        let storyboard = UIStoryboard(name: Constants.CheckoutView, bundle: nil)
                                        let vc = storyboard.instantiateViewController(withIdentifier: Constants.CheckoutVc) as? CheckoutView
                                        parentVC.switchViewController(vc: vc!, showFooter: true)
                                        self.removeDataa()
                                        self.Nextoutlet.isUserInteractionEnabled = true
                                        
                                    }
                                    
                                } else {
                                if let parentVC = self.parent as? ReceptionalistView {
                                    let storyboard = UIStoryboard(name: Constants.WelcomeView, bundle: nil)
                                    let vc = storyboard.instantiateViewController(withIdentifier: Constants.WelcomeVc) as? WelcomeView
                                    parentVC.switchViewController(vc: vc!, showFooter: true)
                                    self.removeDataa()
                                    self.Nextoutlet.isUserInteractionEnabled = true
                                }
                                }
                            }//})
                        }
                        else if (status == 0) {
                            
                            DispatchQueue.main.async {
                                ToastView.show(message: newmessage!, controller: self)
                                 self.Nextoutlet.isUserInteractionEnabled = true
                            }
                        }
                        else if (status == 1000) {
                            
                            DispatchQueue.main.async {
                                ToastView.show(message: Constants.wrong, controller: self)
                                 self.Nextoutlet.isUserInteractionEnabled = true
                            }
                        }
                        
                        else if (status == 1001) {
                            
                            DispatchQueue.main.async {
                                ToastView.show(message: Constants.invalid, controller: self)
                                 self.Nextoutlet.isUserInteractionEnabled = true
                            }
                        }
                        
                        else  {
                            
                            DispatchQueue.main.async {
                                ToastView.show(message: Constants.occured, controller: self)
                                 self.Nextoutlet.isUserInteractionEnabled = true
                            }
                        }
                        
                    } catch {
                         DispatchQueue.main.async {
                            print(error)
                        ToastView.show(message: "Edit Failed! error occured", controller: self)
                         self.Nextoutlet.isUserInteractionEnabled = true
                        }
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
                            
                            ToastView.show(message: newmessage!, controller: self)
                            DispatchQueue.main.async {
                          //  DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                                if let parentVC = self.parent as? ReceptionalistView {
                                    let storyboard = UIStoryboard(name: Constants.WelcomeView, bundle: nil)
                                    let vc = storyboard.instantiateViewController(withIdentifier: Constants.WelcomeVc) as? WelcomeView
                                    parentVC.switchViewController(vc: vc!, showFooter: true)
                                    self.removeDataa()
                                    self.Nextoutlet.isUserInteractionEnabled = true
                                }
                            }//  })
                        }
                        else if (status == 0) {
                            
                            print(status!)
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
                            
                        else  {
                            
                            DispatchQueue.main.async {
                                ToastView.show(message: Constants.occured, controller: self)
                            }
                        }
                        
                    } catch {
                         DispatchQueue.main.async {
                        print(error)
                        ToastView.show(message: "Edit Failed! error occured", controller: self)
                        }
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


