//
//  ReceptionalistView.swift
//  Garage
//  Created by Amjad Ali on 6/13/18.
//  Copyright © 2018 Amjad Ali. All rights reserved.
//

import UIKit


class ReceptionalistView: UIViewController  {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var footerViewContainer: UIView!
    @IBOutlet weak var footerViewHeightConstraint: NSLayoutConstraint!
    
    var footerViewheight: CGFloat = 0.0
    var orginalHeight: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // GeneralNibView.frame.size = settingContianerPop.frame.size
        
    }
    
    @IBOutlet weak var profileBtnOutlet: UIButton!
    override func viewWillAppear(_ animated: Bool) {
        
        footerViewHeightConstraint.constant = headerView.frame.size.height
        if footerViewHeightConstraint.multiplier > 0 {
            footerViewheight = footerViewHeightConstraint.constant
        }
        orginalHeight = UIScreen.main.bounds.height
        showView(index: 1)
        
    }
    
    @IBAction func profileBtn(_ sender: Any) {
        showLocationTable ()
        //   self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    @IBAction func logoutButton(_ sender: Any) {
        Constants.platenmb = "0"
        Constants.vinnmb = "0"
        Constants.CarIDData = 0
        Constants.sessions = ""
        dismiss(animated: true, completion: nil)
    }
    
    
    
    func showLocationTable () {
        var storyboard: UIStoryboard!
        var popController: UIViewController!
        storyboard = UIStoryboard(name: "profilepop", bundle: nil)
        popController = storyboard.instantiateViewController(withIdentifier: "profilepop") as! profilePOpViewController
        let nav = UINavigationController(rootViewController: popController)
        nav.modalPresentationStyle = UIModalPresentationStyle.popover
        let heightForPopOver = 70*3
        let popover = nav.popoverPresentationController
        popController.preferredContentSize = CGSize(width: 300 , height: heightForPopOver)
        popover?.permittedArrowDirections = .up
        popover?.backgroundColor = UIColor.white
        popover?.sourceView = self.profileBtnOutlet
        popover?.sourceRect = self.profileBtnOutlet.bounds
        self.present(nav, animated: true, completion: nil)
        
    }
    
    
    
    
    func showView(index: Int) {
        
        var storyboard: UIStoryboard!
        var vc: UIViewController!
        switch index {
        case 1:
            storyboard = UIStoryboard(name: "WelcomeView", bundle: nil)
            vc = storyboard.instantiateViewController(withIdentifier: "WelcomeVc") as! WelcomeView
            break
            
        case 2:
            storyboard = UIStoryboard(name: "MechanicView", bundle: nil)
            vc = storyboard.instantiateViewController(withIdentifier: "MechanicVc") as! MechanicView
            break
        case 3:
            storyboard = UIStoryboard(name: "CheckoutView", bundle: nil)
            vc = storyboard.instantiateViewController(withIdentifier: "CheckoutVc") as! CheckoutView
            break
        default:
            break
            //            let url = URL(string: "https://www.marnpos.com/#/home")
            //            let requestObj = URLRequest(url: url! as URL)
            //            WebView.loadRequest(requestObj)
            
        }
        
        if vc != nil {
            switchViewController(vc: vc, showFooter: true)
        }
    }
    
    func removeAllChildViewControllers() {
        
        
        if childViewControllers.count > 0 {
            let viewControllers:[UIViewController] = childViewControllers
            for viewContoller in viewControllers  {
                viewContoller.willMove(toParentViewController: nil)
                viewContoller.view.removeFromSuperview()
                viewContoller.removeFromParentViewController()
                
            }
        }
    }
    
    func switchViewController(vc: UIViewController, showFooter: Bool) {
        removeAllChildViewControllers()
        var height: CGFloat = 0.0
        if showFooter {
            self.view.layoutIfNeeded()
            height = orginalHeight - headerView.frame.size.height - footerViewheight
            footerViewHeightConstraint.constant = footerViewheight
            
        } else {
            self.view.layoutIfNeeded()
            height = orginalHeight - headerView.frame.size.height
            footerViewHeightConstraint.constant = 0
            
            
        }
        self.view.layoutIfNeeded()
        vc.view.frame = CGRect(x: 0, y: 0, width: containerView.frame.size.width, height: height)
        self.addChildViewController(vc)
        self.containerView.addSubview(vc.view)
        vc.didMove(toParentViewController: self)
        
    }
    
    func removeFooterView() {
        for subView in footerViewContainer.subviews {
            subView.removeFromSuperview()
        }
        footerViewHeightConstraint.constant = 0
        self.view.layoutIfNeeded()
    }
    
    func addFooterView1(selected: Int) {
        removeFooterView()
        footerViewHeightConstraint.constant = footerViewheight
        self.view.layoutIfNeeded()
        let footerViewWithTabs = Bundle.main.loadNibNamed("FooterViewWithTabs", owner: self, options: nil)?[0] as! FooterViewWithTabs
        footerViewWithTabs.tabButtons_action(footerViewWithTabs.buttons[selected])
        footerViewWithTabs.delegate = self
        footerViewWithTabs.frame = CGRect(x: 0, y: 0, width: footerViewContainer.frame.size.width, height: footerViewContainer.frame.size.height)
        footerViewContainer.addSubview(footerViewWithTabs)
    }
    
    func addFooterView2() {
        removeFooterView()
        footerViewHeightConstraint.constant = footerViewheight
        self.view.layoutIfNeeded()
        let footerViewWithTabs = Bundle.main.loadNibNamed("FooterViewWithTabs", owner: self, options: nil)?[0] as! FooterViewWithTabs
        footerViewWithTabs.tabButtons_action(footerViewWithTabs.btnWelcome)
        footerViewWithTabs.delegate = self
        footerViewWithTabs.frame = CGRect(x: 0, y: 0, width: footerViewContainer.frame.size.width, height: footerViewContainer.frame.size.height)
        footerViewContainer.addSubview(footerViewWithTabs)
    }
    
}

extension ReceptionalistView: FooterViewWithTabsDelegate {
    func selectedButtonIndex(index: Int) {
        showView(index: index)
    }
}











