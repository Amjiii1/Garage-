//
//  Historydetailview.swift
//  Garage
//
//  Created by Amjad on 25/08/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit

class Historydetailview: UIViewController {
    
    @IBOutlet weak var orderdetailsBtn: UIButton!
    @IBOutlet weak var checklistBtn: UIButton!
    
    @IBOutlet weak var notesBtn: UIButton!
    
    @IBOutlet weak var cointainerBtn: UIStackView!
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var orderlabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE, dd LLL yyyy"
        let nameOfMonth = dateFormatter.string(from: now)
        dateLabel.text = nameOfMonth
        orderlabel.text = "#\(Constants.historytrans)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //        for i in 1...5 {
        //            if (self.tabButtonsStackView.viewWithTag(i) as? UIButton) != nil {
        //
        //            }
        //        }
        
        
        DispatchQueue.main.async {
            // to open General tab by default
            if let button = self.cointainerBtn.viewWithTag(1) as? UIButton  {
                print(button)
                self.buttonsAction(button)
            }
        }
    }
    
    
    
    
    
    func changeView(index: Int) {
        
        
        for vc in self.children {
            vc.willMove(toParent: nil)
            vc.removeFromParent()
            vc.view.removeFromSuperview()
        }
        
        var storyboard: UIStoryboard!
        var vc: UIViewController!
        switch index {
        case 1:
            vc = UIStoryboard(name: "detailsView", bundle: nil).instantiateViewController(withIdentifier: "DetailsviewVc") as? Detailsview
            break
            
        case 2:
            
            vc = UIStoryboard(name: "checklistdetails", bundle: nil).instantiateViewController(withIdentifier: "ChecklistDetialsVc") as? ChecklistDetials
            break
        case 3:
            vc = UIStoryboard(name: "NotesDetails", bundle: nil).instantiateViewController(withIdentifier: "NotesDetialsVc") as? NotesDetials
            break
        default:
            break
            //            let url = URL(string: "https://www.marnpos.com/#/home")
            //            let requestObj = URLRequest(url: url! as URL)
            //            WebView.loadRequest(requestObj)
            
        }
        
        if vc != nil {
            vc?.view.frame.size = containerView.frame.size
            vc?.view.frame.origin = CGPoint(x: 0, y: 0)
            addChild(vc!)
            containerView.addSubview((vc?.view)!)
            vc?.didMove(toParent: self)
//            UIView.transition(with: containerView, duration: 0.3, options: .transitionFlipFromLeft, animations: {
//            }) { (completed) in
//            }
        }
    }
    
    @IBAction func reOrderBtn(_ sender: Any) {
        
        if let parentVC = self.parent as? ReceptionalistView {
            let storyboard = UIStoryboard(name: Constants.ServiceCart, bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: Constants.ServiceCartVc) as? ServiceCartView
            parentVC.switchViewController(vc: vc!, showFooter: false)
        }
        
        
        
    }
    
    
    @IBAction func dissmissHistoryDetails(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    @IBAction func buttonsAction(_ sender: UIButton) {
        
        for i in 1...3 {
            if let button = cointainerBtn.viewWithTag(i) as? UIButton {
                button.isSelected = false
                
            }
        }
      //  tabBar.selectionIndicatorImage = UIImage().createSelectionIndicator(color: BLUE, size: CGSize(width: tabBar.frame.width/CGFloat(tabBar.items!.count), height:  tabBar.frame.height), lineWidth: 2.0)
        sender.isSelected = true
        changeView(index: sender.tag)
    }
    
    
}


extension UIImage {
    func createSelectionIndicator(color: UIColor, size: CGSize, lineWidth: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(x: 0, y: size.height - lineWidth, width: size.width, height: lineWidth))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
