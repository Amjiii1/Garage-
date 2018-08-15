//
//  LoginViewController.swift
//  Garage
//
//  Created by Amjad Ali on 6/13/18.
//  Copyright © 2018 Amjad Ali. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var btnUpArrow: UIButton!
    @IBOutlet weak var btnHelp: UIButton!
    @IBOutlet weak var btnCustomer: UIButton!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var pinCodeTextField: SecureTextFieldWithCustomFont!
    @IBOutlet var newFreeTrail: CustomButton!
    @IBOutlet var businesssCodeTextField: UITextField!
    
    @IBOutlet weak var logoImage: UIImageView!
    
    
    let companyRightButton: UIButton = UIButton(type: .custom)
    let viewRightOfCompanyField = UIView(frame:
        CGRect(x: 0, y: 0, width: 70, height: 25))
    var reachability: Reachability?
    var anything = true
    var reveal = true
    
    
    var savedCode = false {
        didSet {
            changeViewForSavedCode()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pinCodeTextField.layer.cornerRadius = 15.0
        pinCodeTextField.layer.borderWidth = 2.0
        pinCodeTextField.layer.borderColor = UIColor.white.cgColor
        businesssCodeTextField.layer.cornerRadius = 15.0
        businesssCodeTextField.layer.borderWidth = 2.0
        pinCodeTextField.layer.borderColor = UIColor.white.cgColor
        pinCodeTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
         businesssCodeTextField.addTarget(self, action: #selector(bussinessCodeDidChange(_:)), for: .editingChanged)
     
               businesssCodeTextField.text = "POS-"
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField.text!.characters.count  == 4          {
             self.performSegue(withIdentifier: "ReceptionalistVc", sender: nil)
        }
    }
    
    @objc func bussinessCodeDidChange(_ textField: UITextField) {
       // businesssCodeTextField.text = "POS-"
      
         //   businesssCodeTextField.isEnabled = true
        if businesssCodeTextField.text!.characters.count == 10 {
            businesssCodeTextField.isEnabled = false
        }
        //  businesssCodeTextField.isEnabled = false
        
        else {
            businesssCodeTextField.isEnabled = true
        }
    
    }
    override func viewWillAppear(_ animated: Bool) {
        businesssCodeTextField.isEnabled = true
    }
    
    
  

    
    
    override func viewWillDisappear(_ animated: Bool) {
//        self.businesssCodeTextField.resignFirstResponder()
//        self.pinCodeTextField.resignFirstResponder()
        
    }
    
    override func viewDidLayoutSubviews() {
        setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setupUI() {
        btnUpArrow.layer.cornerRadius = btnUpArrow.frame.size.width/2
        btnHelp.layer.cornerRadius = btnHelp.frame.size.width/2
        btnCustomer.layer.cornerRadius = btnCustomer.frame.size.width/2
    }
    
    @IBAction func BusinnesscodeBtn(_ sender: Any) {
//        businesssCodeTextField.text = "POS-"
//        if businesssCodeTextField.text!.characters.count == 6 {
//            businesssCodeTextField.isHidden = true
//        }
//        else {
//            businesssCodeTextField.isHidden = false
//        }
    }
    @IBAction func editCompanyCode(_ sender: Any) {
      // businesssCodeTextField.text = "POS-"
//        if businesssCodeTextField.text!.characters.count == 6 {
//            businesssCodeTextField.isHidden = true
//        }
//        else {
//        businesssCodeTextField.isHidden = false
//    }
    }
        
    
    
    func checkSavedTohide() {
//        if(savedCode == true) {
//            self.companyCode.isHidden = false
//            self.editButton.isHidden = false
//            self.businesssCodeTextField.isHidden = true
//            companyCode.text = businesssCodeTextField.text
//
//        }
//        else {
//            self.companyCode.isHidden = true
//            self.editButton.isHidden = true
//            self.businesssCodeTextField.isHidden = false
//        }
    }
    
    
    
    func addButtonToCompanyCodeTextField() {
    
//    self.businesssCodeTextField.clearButtonMode = .whileEditing
//
//    companyRightButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
//
//    var imageForButton = UIImage(named: Constants.saveButtonImageName)
//    imageForButton = (imageForButton!.withRenderingMode(.alwaysTemplate))
//  //  companyRightButton.imageView!.tintColor = UIColor.init(netHex: ColorsCode.mainColor)
//    companyRightButton.setImage(imageForButton, for: UIControlState())
//    //button.setImage(UIImage(named: Constants.saveButtonImageName), forState: .Normal)
//    companyRightButton.addTarget(self, action: #selector(LoginViewController.submitCompanyCode(_:)), for: .touchUpInside)
//
//    //button.setImage(UIImage(named: Constants.saveButtonImageName), forState: .Normal)
//    viewRightOfCompanyField.addSubview(companyRightButton)
////    viewRightOfCompanyField.addSubview(cancelRightButton)
//
//
//    self.businesssCodeTextField.rightView = viewRightOfCompanyField
//    self.businesssCodeTextField.rightViewMode = .always
//
//    //        self.companyCodeTextField.leftView = UIView(frame:
//    //            CGRectMake(0, 0, 25, 25))
//    //        self.companyCodeTextField.leftViewMode = .Always
//
//    businesssCodeTextField.layer.masksToBounds = true;
}
    
    
    
    
    
    
    
    func changeViewForSavedCode() {
        
        
//        if(savedCode == false) {
//            self.businesssCodeTextField.isHidden = false
//            if businesssCodeTextField.text!.characters.count  == 6  {
//                self.businesssCodeTextField.isHidden = true
//            }
//        else {
//                businesssCodeTextField.isHidden = true
//
//
//    }
//
//        }
    }
    
    func setCompanyCodeCancelButton () {
////        if(Defaults.getLastCompanyCode() != userDefaultsValues.lastLegitCompany || Defaults.getSavedCompanyCode() != userDefaultsValues.lastLegitCompany) {
//            self.cancelRightButton.isHidden = false
//
//        else {
//
//            self.cancelRightButton.isHidden = true
//
//    }
}
        func submitCompanyCode(_ sender:AnyObject) {
        
//        self.businesssCodeTextField.resignFirstResponder()
//
//        if(self.businesssCodeTextField.text!.characters.count > 0) {
//            // ARSLineProgress.showWithPresentCompetionBlock {
//
//            self.companyRightButton.isHidden = true
//            //Loader.startLoadingInsideView(viewRightOfCompanyField)
//            self.saveCompanyCode({ (success) in
//
//                self.dismissKeyboard()
//             //   Loader.stopLoading()
//            })
            
            
            //}
        }
        //        #endif
    
    
    func saveCompanyCode(_ completion: @escaping (_ success: Bool,_ message:String) -> Void) {
//        reachability =  Reachability()!
//        if reachability!.isReachable {
//            if reachability!.isReachableViaWiFi {
//                print("Reachable via WiFi")
//            } else {
//                print("Reachable via Cellular")
//
//            }
//
////            saveCompanyCodeWithNet({ (success,message) in
////
////                if(!success) {
////                    if(message.contains("ncorrect") || message.contains("input")) {
////                        completion(success,message)
////                    }
////                    else {
////                        Utilities.showInfo(title: "Internet issue", body: "Trying offline.")
////                        self.saveCompanyCodeWithOutNet({ (success,message) in
////
////                            completion(success,message)
////                        })
////                    }
////                }
////                else {
////                    completion(success,message)
////                }
////            })
//
//        }
//        else {
//            print("Network not reachable")
//
////            saveCompanyCodeWithOutNet({ (success,message) in
////
////                completion(success,message)
////            })
//        }
//
//    }
    
  

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
}

class SecureTextFieldWithCustomFont : UITextField {
    var isSecure = false
    var actualText = ""
    var textFrom = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        //if self.isSecureTextEntry {
        // Listen for changes.
        self.addTarget(self, action: #selector(self.editingDidBegin), for: .editingDidBegin)
        self.addTarget(self, action: #selector(self.editingDidChange), for: .editingChanged)
        self.addTarget(self, action: #selector(self.editingDidFinish), for: .editingDidEnd)
        //}
    }
    
    override func text(in range: UITextRange) -> String? {
        
        if self.isEditing || self.isSecure == false {
            return super.text!
        }
        else {
            return self.actualText
        }
    }
    
    @objc func editingDidBegin() {
        //self.isSecureTextEntry = true
        self.text = ""
        self.textFrom = ""
        self.actualText = ""
    }
    @objc func editingDidChange() {
        if(self.actualText.characters.count > (self.text?.characters.count)!) {
            self.text = ""
            self.textFrom = ""
            self.actualText = ""
        }
        else {
            finishTF()
        }
        
        
        
    }
    func finishTF() {
        self.actualText = self.text!
        if( self.text != nil && (self.text?.characters.count)! > 0) {
            self.textFrom += String(describing: (self.text?.characters.last!)!)
        }
        else {
            self.textFrom = ""
            self.text = ""
        }
        self.actualText = textFrom
        self.text = self.dotPlaceholder()
    }
    
    @objc func editingDidFinish() {
        //self.isSecureTextEntry = false
        self.actualText = self.textFrom
        self.text = self.dotPlaceholder()
    }
    
    func dotPlaceholder() -> String {
        var index = 0
        var dots = ""
        while index < (self.text?.characters.count)! {
            dots += "•"
            index += 1
        }
        return dots
    }
    
    
    
}
