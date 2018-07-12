//
//  ReceptionalistView.swift
//  Garage
//
//  Created by Amjad Ali on 6/13/18.
//  Copyright © 2018 Amjad Ali. All rights reserved.
//

import UIKit

class ReceptionalistView: UIViewController  {
    
    @IBOutlet weak var tabLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var btnWelcome: UIButton!
    @IBOutlet weak var btnService: UIButton!
    @IBOutlet weak var btnCheckout: UIButton!
    
    @IBOutlet weak var serviceImage: UIImageView!
    
    //var MechanicVC:MechanicView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
        // Do any additional setup after loading the view.
        
       tabButtons_action(btnWelcome)
        
    }
    
    override func viewDidLayoutSubviews() {
      
        
    }
   
    
    
    @IBAction func tabButtons_action(_ sender: UIButton) {
        
        var storyboard: UIStoryboard!
        var vc: UIViewController!
        //select(sender)
        switch sender.tag {
        case btnWelcome.tag:
            storyboard = UIStoryboard(name: "WelcomeView", bundle: nil)
            vc = storyboard.instantiateViewController(withIdentifier: "WelcomeVc") as! WelcomeView
            btnWelcome.isSelected = true
            btnCheckout.isSelected = false
            btnService.isSelected = false
            
             break
        case btnService.tag:
            storyboard = UIStoryboard(name: "MechanicView", bundle: nil)
            vc = storyboard.instantiateViewController(withIdentifier: "MechanicVc") as! MechanicView
            btnService.isSelected = true
            btnWelcome.isSelected = false
            btnCheckout.isSelected = false
            break
        case btnCheckout.tag:
            storyboard = UIStoryboard(name: "CheckoutView", bundle: nil)
            vc = storyboard.instantiateViewController(withIdentifier: "CheckoutVc") as! CheckoutView
            btnCheckout.isSelected = true
            btnWelcome.isSelected = false
            btnService.isSelected = false
         
            break
            
        default:
            break
        }
        
        if vc != nil {
            switchViewController(vc: vc)
           }
    }
    

    
        func select(_ sender: UIButton) {
    
        
        if btnCheckout.isSelected == true {
            btnCheckout.isSelected = true
            btnWelcome.isSelected = false
            btnService.isSelected = false
        } else if btnService.isSelected == true {
            btnWelcome.isSelected = false
            btnCheckout.isSelected = false
        }
        else {
            btnWelcome.isSelected = false
            btnCheckout.isSelected = false

        }
        
        
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
    
    override func select(_ sender: Any?) {
        if btnWelcome.isSelected == true {
                    }

    }
    
    
    func setupbtnUI() {
        //scanBtn.layer.cornerRadius = scanBtn.frame.size.width/3.5
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}












