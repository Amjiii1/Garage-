//
//  ReceptionalistView.swift
//  Garage
//  Created by Amjad Ali on 6/13/18.
//  Copyright © 2018 Amjad Ali. All rights reserved.
//

import UIKit

class ReceptionalistView: UIViewController  {
    
    @IBOutlet weak var tabLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var serviceImage: UIImageView!
    @IBOutlet weak var footerViewContainer: UIView!

    //var MechanicVC:MechanicView!
    override func viewDidLoad() {
        super.viewDidLoad()
            // Do any additional setup after loading the view.
     //  tabButtons_action(btnWelcome)
         setupUI()
    }
    
    override func viewDidLayoutSubviews() {
       
    }
    
    func switchViewController(vc: UIViewController) {
       
        vc.view.frame = CGRect(x: 0, y: 0, width: containerView.frame.size.width, height: containerView.frame.size.height)
       
            if  childViewControllers.count > 0 {
                let viewControllers:[UIViewController] = childViewControllers
                for viewContoller in viewControllers  {
                    viewContoller.willMove(toParentViewController: nil)
                    viewContoller.view.removeFromSuperview()
                    viewContoller.removeFromParentViewController()
            }
        }
        
        self.addChildViewController(vc)
        self.containerView.addSubview(vc.view)
        vc.didMove(toParentViewController: self)
    }
    
   func setupUI() {
    
    let newOrderItem = Bundle.main.loadNibNamed("FooterViewWithTabs", owner: self, options: nil)?[0] as! FooterViewWithTabs
        footerViewContainer.addSubview(newOrderItem)
    newOrderItem.frame = CGRect(x: 0, y: 0, width: footerViewContainer.frame.size.width, height: footerViewContainer.frame.size.height)
    
    }
    }













