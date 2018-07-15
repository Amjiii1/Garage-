//
//  WelcomeView.swift
//  Garage
//
//  Created by Amjad Ali on 7/9/18.
//  Copyright © 2018 Amjad Ali. All rights reserved.
//

import UIKit

class WelcomeView: UIViewController {

    
    
    
 

   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func addNewCaeBtn(_ sender: Any) {
        
       let storyboard = UIStoryboard(name: "AddnewCar", bundle: nil)
        let newCarvc = storyboard.instantiateViewController(withIdentifier: "addNewCarVc") as! addNewCar
        addChildViewController(newCarvc)
 
        view.addSubview(newCarvc.view)
        view.addConstraint(NSLayoutConstraint(item: newCarvc, attribute: .top, relatedBy: .equal, toItem: self.topLayoutGuide, attribute: .bottom, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: newCarvc, attribute: .bottom, relatedBy: .equal, toItem: self.bottomLayoutGuide, attribute:.top, multiplier: 1, constant: 0))

        view.addConstraint(NSLayoutConstraint(item: newCarvc, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute,multiplier: 1, constant: 300))
        view.addConstraint(NSLayoutConstraint(item: newCarvc, attribute: .trailingMargin, relatedBy: .equal, toItem: view, attribute: .trailingMargin, multiplier: 1, constant: 0))
        // Notify the child that it was moved to a parent
        newCarvc.didMove(toParentViewController: self)
        
        
        
        // Notify the child that it's about to be moved away from its parent
  //      child.willMove(toParentViewController: nil)
        // Remove the child
 //       child.removeFromParentViewController()
        // Remove the child view controller's view from its parent
//      child.view.removeFromSuperview()
        
                
         }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
