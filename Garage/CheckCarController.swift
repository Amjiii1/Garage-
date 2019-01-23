//
//  CheckCarController.swift
//  Garage
//
//  Created by Amjad on 18/04/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit

class CheckCarController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    
    
    
    @IBOutlet weak var ChecklistTableview: UITableView!
    
  //  checkCell
    var lastSelectedIndexPath = NSIndexPath(row: -1, section: 0)
    let SectionTitles: [String] = ["Filter", "Gas", "Tire"]
    
    var sectionImages: [UIImage] = [
        UIImage(named: "icongeneral.png")!,
        UIImage(named: "icongeneral.png")!,
        UIImage(named: "icongeneral.png")!
    ]
    
    let s1Data: [String] = ["Good Filter For Future", "Gas leaked", "Punchered Tire is on move"]
    let s2Data: [String] = ["Good Filter For Future", "Punchered Tire is on move", "Good Filter For Future"]
    let s3Data: [String] = ["Good Filter For Future", "Good Filter For Future", "Gas leaked"]
    let s4Data: [String] = ["Gas leaked", "Punchered Tire is on move", "Good Filter For Future"]
    
    var sectionData: [Int: [String]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ChecklistTableview.delegate = self
        ChecklistTableview.dataSource = self
        sectionData = [0: s1Data, 1: s2Data, 2: s3Data]
       
        self.ChecklistTableview.allowsMultipleSelection = true
        self.ChecklistTableview.allowsMultipleSelectionDuringEditing = true
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (sectionData[section]?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        var cell = tableView.dequeueReusableCell(withIdentifier: "checkCell",
                                                 for: indexPath) as? CheckCarcell

      
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "checkCell") as? CheckCarcell
        }
        cell?.textLabel?.text = sectionData[indexPath.section]![indexPath.row]
        
        
        cell!.contentView.backgroundColor = UIColor.BlackApp
        
        cell!.checkboxA.addTarget(self, action:#selector(self.toggleSelcted(_:)), for: .touchUpInside)
        cell!.checkBoxB.addTarget(self, action:#selector(self.toggleSelctedB(_:)), for: .touchUpInside)
        cell!.checkBoxC.addTarget(self, action:#selector(self.toggleSelctedC(_:)), for: .touchUpInside)
        
        return cell!
        
    }
    
    
 
    @objc func toggleSelcted (_ sender: UIButton) {
        print("button presed")
        print(IndexPath.self)
        if sender.isSelected {
           print("Checkmark")
            sender.isSelected = false
            
        } else {
                print("unCheckmark")
            sender.isSelected = true
            
        }
        
    }
    @objc func toggleSelctedB (_ sender: UIButton) {
        print("button presed")
        
        if sender.isSelected {
            print("Checkmark")
            sender.isSelected = false
            
        } else {
            print("unCheckmark")
            sender.isSelected = true
            
        }
        
    }
    @objc func toggleSelctedC (_ sender: UIButton) {
        print("button presed")
        
        if sender.isSelected {
            print("Checkmark")
            sender.isSelected = false
            
        } else {
            print("unCheckmark")
            sender.isSelected = true
            
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 45
    }
    
    
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let cell = tableView.cellForRow(at: indexPath) {
//            cell.accessoryType = .checkmark
//        }
//    }
//
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        if let cell = tableView.cellForRow(at: indexPath) {
//            cell.accessoryType = .none
//        }
//    }
//
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SectionTitles[section]
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return SectionTitles.count

    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        let image = UIImageView(image: sectionImages[section])
        image.frame = CGRect(x: 5, y: 5, width: 35, height: 35)
        view.addSubview(image)

        let label = UILabel()
        label.text = SectionTitles[section]
        label.frame = CGRect(x: 45, y: 5, width: 100, height: 35)
       
        view.addSubview(label)
        return view
    }
    
//  func tableViewcollectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//        var whichPortalIsSelected: String = ""
//
//        // Get Cell Label
//        let indexPath = ChecklistTableview.indexPathForSelectedRow
//
//        // Tick the selected row
//    if indexPath!.row != lastSelectedIndexPath.row {
//
//        let newCell = ChecklistTableview.cellForRow(at: indexPath!)
//        newCell?.accessoryType = .checkmark
//
//        lastSelectedIndexPath = indexPath as! NSIndexPath
//
//            whichPortalIsSelected = newCell!.textLabel!.text!
//            print("You selected cell #\(lastSelectedIndexPath.row)!")
//            print("You selected portal #\(whichPortalIsSelected)!")
//
//            // Un-Tick unselected row
//        } else {
//        let newCell = ChecklistTableview.cellForRow(at: indexPath!)
//        newCell?.accessoryType = .none
//
//            whichPortalIsSelected = newCell!.textLabel!.text!
//            print("You unselected cell #\(indexPath!.row)!") //PPP
//            print("You unselected portal #\(whichPortalIsSelected)!") //PPP
//        }
//
//    }

    
    
    
    
    
    
    
    
    
    

    
    
    
    
    @IBAction func backBtn(_ sender: Any) {
        
        if let parentVC = self.parent as? ReceptionalistView {
            let storyboard = UIStoryboard(name: "MechanicView", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MechanicVc") as? MechanicView
            parentVC.switchViewController(vc: vc!, showFooter: true)
        }
    }
    
    
    
}
