//
//  CheckCarController.swift
//  Garagesa
//
//  Created by Amjad on 18/04/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher


struct Checklist {
    static var CheckcarPost = [checkCarPost]()
    
}


class CheckCarController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var ChecklistTableview: UITableView!
    
    
    var A = "A"
    var B = "B"
    var C = "C"
    
    
    
    var Inspectionlist = [InspectionList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ChecklistTableview.allowsMultipleSelection = true
        self.ChecklistTableview.allowsMultipleSelectionDuringEditing = true
        ChecklistTableview.delegate = self
        ChecklistTableview.dataSource = self
        ChecklistTableview.delegate = self
        getDetails()
        Constants.checkflag = 1
        Checklist.CheckcarPost.removeAll()
    }
    
    
    private func getDetails() {
        let url = ("\(CallEngine.baseURL)\(CallEngine.carinspection)/\(Constants.SuperUser)/\(Constants.sessions)")
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
                    let status = json[Constants.Status].intValue
                    let desc = json[Constants.Description].stringValue
                    
                    if (status == 1) {
                        let InspectionLst = json["InspectionList"].arrayValue
                        
                        var InspectionDtail = [InspectionDetails]()
                        
                        for details in InspectionLst {
                            let Inspection = details["InspectionDetails"].arrayValue
                            let InspectionID = details["InspectionID"].intValue
                            let Name = details["Name"].stringValue
                            let alternateName = details["AlternateName"].stringValue
                            let HeadDesc = details["Image"].stringValue
                            let HeadImage = details["Description"].stringValue
                            let HeadStatus = details["UserID"].intValue
                            InspectionDtail = []
                            for sub in Inspection {
                                let CarInspectionDetailID = sub["CarInspectionDetailID"].intValue
                                let CarInspectionID = sub["CarInspectionID"].intValue
                                let subName = sub["Name"].stringValue
                                let subAlternateName = sub["AlternateName"].stringValue
                                let subDescription = sub["Description"].stringValue
                                let Kilometer = sub["Kilometer"].stringValue
                                let subIsInspection = sub["IsInspection"].boolValue
                                let subIsReplace = sub["IsReplace"].boolValue
                                let subnspectWithoutR = sub["IsInspectWithoutReplace"].boolValue
                                
                                let newInspectionDetails = InspectionDetails(CarInspectionDetailID: CarInspectionDetailID, CarInspectionID: CarInspectionID, Name: subName, AlternateName: subAlternateName, Description: subDescription, Kilometer: Kilometer, IsInspection: subIsInspection, IsReplace: subIsReplace, IsInspectWithoutReplace: subnspectWithoutR)
                                InspectionDtail.append(newInspectionDetails)
                            }
                            let newInspectionList = InspectionList(InspectionDetails: InspectionDtail, InspectionID: InspectionID, Name: Name, AlternateName: alternateName, Image: HeadDesc, Description: HeadImage, UserID: HeadStatus)
                            self?.Inspectionlist.append(newInspectionList)
                            DispatchQueue.main.async {
                                self?.ChecklistTableview.reloadData()
                            }
                        }
                    }
                        
                    else  if (status == 0) {
                        DispatchQueue.main.async {
                            ToastView.show(message: desc, controller: self!)
                        }
                    }
                        
                    else  if (status == 1000) {
                        DispatchQueue.main.async {
                            ToastView.show(message: LocalizedString.wrong, controller: self!)
                        }
                    }
                        
                    else  if (status == 1001) {
                        DispatchQueue.main.async {
                            ToastView.show(message: LocalizedString.invalid, controller: self!)
                        }
                    }
                        
                    else {
                        DispatchQueue.main.async {
                            ToastView.show(message: LocalizedString.occured, controller: self!)
                        }
                    }
                    
                } catch {
                    debugPrint("🔥 Network Error : ", error)
                    ToastView.show(message: "🔥 Network Error", controller: self!)
                }
            }
        }
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Inspectionlist[section].InspectionDetails.count//sectionData[section]?.count else { return 0 }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "checkCell", for: indexPath) as? CheckCarcell else { return UITableViewCell() }
        
        
        if L102Language.currentAppleLanguage() == "ar" {
            cell.titleLabels.text = Inspectionlist[indexPath.section].InspectionDetails[indexPath.row].AlternateName
        } else {
            cell.titleLabels.text = Inspectionlist[indexPath.section].InspectionDetails[indexPath.row].Name
        }
        let checkboxA = Inspectionlist[indexPath.section].InspectionDetails[indexPath.row].IsInspection
        cell.checkboxA.isSelected = checkboxA
        let checkBoxB = Inspectionlist[indexPath.section].InspectionDetails[indexPath.row].IsReplace
        cell.checkBoxB.isSelected = checkBoxB
        let checkBoxC = Inspectionlist[indexPath.section].InspectionDetails[indexPath.row].IsInspectWithoutReplace
        cell.checkBoxC.isSelected = checkBoxC
        
        let indexofcell = (indexPath.section * 1000) + indexPath.row
        print(indexofcell)
        cell.checkboxA.tag = indexofcell
        cell.checkBoxB.tag = indexofcell
        cell.checkBoxC.tag = indexofcell
        cell.checkboxA.addTarget(self, action:#selector(self.tabA(_:)), for: .touchUpInside)
        cell.checkBoxB.addTarget(self, action:#selector(self.tabB(_:)), for: .touchUpInside)
        cell.checkBoxC.addTarget(self, action:#selector(self.tabC(_:)), for: .touchUpInside)
        cell.contentView.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        return cell
        
    }
    
    @objc func tabA(_ sender: UIButton){
        let row = sender.tag % 1000
        let section = sender.tag / 1000
        let count = [(Inspectionlist[section].InspectionDetails[row])]
        for details in count {
            
            let rowdetails = checkCarPost(CarInspectionDetailID: details.CarInspectionDetailID, CarInspectionID: details.CarInspectionID, Name: details.Name, AlternateName: details.AlternateName, Description: details.Description, Kilometer: details.Kilometer, IsInspection: true, IsReplace: false, IsInspectWithoutReplace: false)
            
            Checklist.CheckcarPost.append(rowdetails)
        }
        
        
    }
    
    @objc func tabB(_ sender: UIButton) {
        let row = sender.tag % 1000
        let section = sender.tag / 1000
        let count = [(Inspectionlist[section].InspectionDetails[row])]
        for details in count {
            
            let rowdetails = checkCarPost(CarInspectionDetailID: details.CarInspectionDetailID, CarInspectionID: details.CarInspectionID, Name: details.Name, AlternateName: details.AlternateName, Description: details.Description, Kilometer: details.Kilometer, IsInspection: false, IsReplace: true, IsInspectWithoutReplace: false)
            
            Checklist.CheckcarPost.append(rowdetails)
        }
    }
    
    
    @objc func tabC(_ sender: UIButton) {
        let row = sender.tag % 1000
        let section = sender.tag / 1000
        let count = [(Inspectionlist[section].InspectionDetails[row])]
        for details in count {
            
            let rowdetails = checkCarPost(CarInspectionDetailID: details.CarInspectionDetailID, CarInspectionID: details.CarInspectionID, Name: details.Name, AlternateName: details.AlternateName, Description: details.Description, Kilometer: details.Kilometer, IsInspection: false, IsReplace: false, IsInspectWithoutReplace: true)
            
            Checklist.CheckcarPost.append(rowdetails)
        }
        
    }
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.separatorColor = UIColor.gray
        return CGFloat(60)
        
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
         if L102Language.currentAppleLanguage() == "ar" {
            
            
        return Inspectionlist[section].AlternateName
         } else {
            return Inspectionlist[section].Name
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Inspectionlist.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let customeView = UIView()
        customeView.backgroundColor = UIColor.gray
        
        let mainStackView = UIStackView()
        mainStackView.axis = .horizontal
        mainStackView.alignment = .center
        mainStackView.distribution = .fill
        mainStackView.spacing = 10
      
        
        let titletStackView = UIStackView()
        titletStackView.axis = .horizontal
        titletStackView.alignment = .leading

        titletStackView.distribution = .fillEqually
        //titletStackView.alignment = .center
        titletStackView.spacing = 5//10
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = true
        if L102Language.currentAppleLanguage() == "ar" {
            
            
            label.text = Inspectionlist[section].AlternateName
        } else{
             label.text = Inspectionlist[section].Name
        }
       
        label.font = UIFont(name: "SFProDisplay-Bold", size: 18)//UIFont.systemFont(ofSize: 20.0)
        label.textColor = .white
        label.textAlignment = .left
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        label.widthAnchor.constraint(equalToConstant: 49.5).isActive = true

        print(label.widthAnchor)
//        titletStackView.addArrangedSubview(label)
        
        //let images = UIImage(named: Inspectionlist[section].Image)
        let url = URL(string: Inspectionlist[section].Image)
        let image = UIImageView()
        image.kf.setImage(with: url)
        print(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        image.widthAnchor.constraint(equalToConstant: 30).isActive = true
        image.contentMode = .scaleAspectFit
        if L102Language.currentAppleLanguage() == "ar" {
            titletStackView.addArrangedSubview(image)
           // label.textAlignment = .left
            titletStackView.addArrangedSubview(label)
            A = "C"
            B = "B"
            C = "A"
        } else {
           // label.textAlignment = .right
            titletStackView.addArrangedSubview(label)
             titletStackView.addArrangedSubview(image)
        }
        
        let buttonStackView = UIStackView()
        buttonStackView.axis = .horizontal
        buttonStackView.alignment = .center
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 15
        let buttonA = UIButton()
        
        buttonA.setTitle(A, for: .normal)
        buttonA.titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 18)//UIFont.boldSystemFont(ofSize: 18)
        //        buttonA.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
        buttonA.translatesAutoresizingMaskIntoConstraints = false
        buttonA.widthAnchor.constraint(equalToConstant: 30).isActive = true
        let buttonB = UIButton()
        buttonB.setTitle(B, for: .normal)
        buttonB.titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 18)
        //        buttonB.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
        let buttonC = UIButton()
        buttonC.setTitle(C, for: .normal)
        buttonC.titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 18)
        //        buttonC.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
        //        buttonA.tag = section
        //        buttonA.addTarget(self, action: #selector(selectAType(_:)), for: .touchUpInside)
        //        buttonB.tag = section
        //        buttonB.addTarget(self, action: #selector(selectBType(_:)), for: .touchUpInside)
        //        buttonC.tag = section
        //        buttonC.addTarget(self, action: #selector(selectCType(_:)), for: .touchUpInside)
        buttonStackView.addArrangedSubview(buttonA)
        buttonStackView.addArrangedSubview(buttonB)
        buttonStackView.addArrangedSubview(buttonC)
         if L102Language.currentAppleLanguage() == "ar" {
            mainStackView.addArrangedSubview(buttonStackView)
            mainStackView.addArrangedSubview(titletStackView)
         } else {
             mainStackView.addArrangedSubview(titletStackView)
             mainStackView.addArrangedSubview(buttonStackView)
        }
        mainStackView.frame = CGRect(x: 25, y: 0, width: tableView.frame.width - 50, height: 40)
        customeView.addSubview(mainStackView)
        return customeView
    }
    
    
    @objc private func selectCType(_ sender: UIButton) {
        let section = sender.tag
        var count: Int = 0
        if L102Language.currentAppleLanguage() == "ar" {
            
            count = Inspectionlist[section].AlternateName.count
        } else{
            count = Inspectionlist[section].Name.count
        }
        
        for i in 0...count {
            print(section)
            let index = IndexPath(row: i, section: section)
            if let cell = ChecklistTableview.cellForRow(at: index) as? CheckCarcell {
                cell.checkBoxC.isSelected = true
                cell.checkBoxB.isSelected = false
                cell.checkboxA.isSelected = false
            }
        }
    }
    
    @objc private func selectBType(_ sender: UIButton) {
        let section = sender.tag
        print("selectBType")
        var count: Int = 0
        if L102Language.currentAppleLanguage() == "ar" {
            
           count = Inspectionlist[section].AlternateName.count
        } else{
            count = Inspectionlist[section].Name.count
        }
        for i in 0...count {
            let index = IndexPath(row: i, section: section)
            if let cell = ChecklistTableview.cellForRow(at: index) as? CheckCarcell {
                cell.checkBoxB.isSelected = true
                cell.checkboxA.isSelected = false
                cell.checkBoxC.isSelected = false
            }
        }
    }
    
    @objc private func selectAType(_ sender: UIButton) {
        let section = sender.tag
        print("selectAType")
       var count: Int = 0
        if L102Language.currentAppleLanguage() == "ar" {
            
             count = Inspectionlist[section].AlternateName.count
        } else{
             count = Inspectionlist[section].Name.count
        }
        for i in 0...count {
            let index = IndexPath(row: i, section: section)
            if let cell = ChecklistTableview.cellForRow(at: index) as? CheckCarcell {
                cell.checkboxA.isSelected = true
                cell.checkBoxB.isSelected = false
                cell.checkBoxC.isSelected = false
            }
        }
    }
    
    
    
    
    
    
    @IBAction func savecontinueBtn(_ sender: Any) {
         DispatchQueue.main.async {
            
            if let parentVC = self.parent as? ReceptionalistView {
                let storyboard = UIStoryboard(name: "MechanicView", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "MechanicVc") as? MechanicView
                parentVC.switchViewController(vc: vc!, showFooter: true)
            }
        }//)
        
        
    }
    
    
    
    
    @IBAction func backBtn(_ sender: Any) {
        Constants.checkflag = 0
        if let parentVC = self.parent as? ReceptionalistView {
            let storyboard = UIStoryboard(name: "MechanicView", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MechanicVc") as? MechanicView
            parentVC.switchViewController(vc: vc!, showFooter: true)
        }
    }
}
