//
//  LoginViewController.swift
//  Garage
//
//  Created by Amjad Ali on 6/13/18.
//  Copyright © 2018 Amjad Ali. All rights reserved.
//

import UIKit
import Alamofire

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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnUpArrow.isHidden = true
        btnHelp.isHidden = true
        btnCustomer.isHidden = true
        newFreeTrail.isHidden = true
        pinCodeTextField.layer.cornerRadius = 18.0
        pinCodeTextField.layer.borderWidth = 2.0
        pinCodeTextField.layer.borderColor = UIColor.white.cgColor
        businesssCodeTextField.layer.cornerRadius = 18.0
        businesssCodeTextField.layer.borderWidth = 2.0
        pinCodeTextField.layer.borderColor = UIColor.white.cgColor
        pinCodeTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        pinCodeTextField.delegate = self
        businesssCodeTextField.text = "POS-"
        //    arrowImage()
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = Date()
        let dateString = dateFormatter.string(from: date)
    
        if loggedIn() {
            businesssCodeTextField.addTarget(self, action: #selector(bussinessCodeDidChange(_:)), for: .editingChanged)
        }  else {
            businesssCodeTextField.addTarget(self, action: #selector(bussinessCodeDidChange(_:)), for: .editingChanged)
        }
    }
    
    
    
    
    fileprivate func loggedIn() -> Bool {
        
        businesssCodeTextField.text = UserDefaults.standard.string(forKey: Constants.loggedIn)
        return UserDefaults.standard.bool(forKey: Constants.loggedIn)
    }
    
    
    func arrowImage() {
        pinCodeTextField.rightViewMode = .always
        let emailImgContainer = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 25))
        let emailImg = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        emailImg.image = UIImage(named: "arrowlogin")
        emailImg.center = emailImgContainer.center
        emailImgContainer.addSubview(emailImg)
        pinCodeTextField.rightView = emailImgContainer
    }
    
    
    
    
    @IBAction func Pincodefield(_ sender: Any) {
        self.pinCodeTextField.isEnabled = true
        
    }
    
    

    func PincodeApi() {
        
        guard let url = URL(string: "\(CallEngine.baseURL)\(CallEngine.LoginApi)/\(pinCodeTextField.text!)/\(businesssCodeTextField.text!)") else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if response == nil {
                DispatchQueue.main.async {
                    ToastView.show(message: LocalizedString.interneterror, controller: self)
                    self.pinCodeTextField.isEnabled = true
                    self.businesssCodeTextField.isEnabled = true
                }
            }
            if let data = data {
                print(data)
                do {
                    guard  let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {return}
                    let descript = login(json: json)
                    if (descript.status == 1) {
                        DispatchQueue.main.async {
                            ToastView.show(message: Constants.loginSucs, controller: self)
                        }
                        if let tax = json[Constants.Tax] as? String {
                            Constants.tax = tax
                        }
                        
                        if let User = json[Constants.User] as? [String: Any] {
                            print(User)
                            if  let session = User[Constants.SessionA] as? String {
                                UserDefaults.standard.set(session, forKey: Constants.SessionA)
                                Constants.sessions = session
                            }
                            if  let ordertracker = User[Constants.SubUserIDA] as? Int {
                                Constants.ordertracker = String (ordertracker)
                            }
                            
                            if  let VATNo = User[Constants.VATNo] as? String {
                                Constants.VAT = VATNo
                            }
                            
                            if  let LocationName = User[Constants.LocationNameA] as? String {
                                Constants.LocationName = LocationName
                            }
                            
                            if  let FirstName = User[Constants.FirstNameA] as? String {
                                Constants.FirstName = FirstName
                            }
                            if  let userImage = User[Constants.userimage] as? String {
                                Constants.userImage = userImage
                            }
                        }
                        
                        if let receipt = json[Constants.ReceiptInfo] as? [String: Any] {//
                            print(receipt)
                            if  let CompanyPhones = receipt[Constants.CompanyPhonesA] as? String {
                                Constants.CompanyPhones = CompanyPhones
                            }
                            if  let InstagramLink = receipt[Constants.InstagramLinkA] as? String {
                                Constants.InstagramLink = InstagramLink
                            }
                            if  let SnapchatLink = receipt[Constants.SnapchatLinkA] as? String {
                                Constants.SnapchatLink = SnapchatLink
                            }
                            if  let Footer = receipt[Constants.FooterA] as? String {
                                Constants.Footer = Footer
                            }
                            if  let logo = receipt[Constants.CompanyLogoURL] as? String {
                                let url = NSURL(string:logo)
                                let data = NSData(contentsOf:url! as URL)
                                if data != nil {
                                    Constants.Logoimage = data!
                                }
                            }
                            
                        }
                         DispatchQueue.main.async {
                        let storyboard: UIStoryboard = UIStoryboard(name: Constants.ReceptionalistView, bundle: nil)
                        let initViewController: UIViewController = storyboard.instantiateViewController(withIdentifier: Constants.ReceptionalistVc) as! ReceptionalistView
                        self.present(initViewController, animated: true, completion: nil)
                        }
                        
                    } else if (descript.status == 0) {
                        DispatchQueue.main.async {
                            ToastView.show(message: Constants.UserExistent, controller: self)
                            
                            self.pinCodeTextField.isEnabled = true
                            self.businesssCodeTextField.isEnabled = true
                        }
                    }
                    else if (descript.status == 1000) {
                        DispatchQueue.main.async {
                            ToastView.show(message: LocalizedString.wrong, controller: self)
                            
                            self.pinCodeTextField.isEnabled = true
                            self.businesssCodeTextField.isEnabled = true
                        }
                    }
                        
                    else if (descript.status == 1001) {
                        DispatchQueue.main.async {
                            ToastView.show(message: LocalizedString.invalid, controller: self)
                            self.pinCodeTextField.isEnabled = true
                            self.businesssCodeTextField.isEnabled = true
                        }
                    }
                        
                    else {
                        DispatchQueue.main.async {
                            ToastView.show(message: LocalizedString.occured, controller: self)
                            self.pinCodeTextField.isEnabled = true
                            self.businesssCodeTextField.isEnabled = true
                        }
                    }
                    
                } catch {
                    
                    print(error)
                    DispatchQueue.main.async {
                        ToastView.show(message: Constants.Loginfailed, controller: self)
                        self.pinCodeTextField.isEnabled = true
                    }
//                    DispatchQueue.main.async {
//                        ToastView.show(message: Constants.Loginfailed, controller: self)
//                        self.pinCodeTextField.isEnabled = true
//                        self.businesssCodeTextField.isEnabled = true
//                    }
                }
                
                
                
            }
            
            
            }.resume()
        
    }
    
    
    
    @IBAction func toastexmple(_ sender: Any) {
        
        
    }
    
    
    @IBAction func BusinessCodeAction(_ sender: Any) {
        self.businesssCodeTextField.isEnabled = true
    }
    
    
    
    func BusinessApi() {
        
        
        guard let url = URL(string: "\(CallEngine.baseURL)\(CallEngine.BusinessCodeapi)/\(businesssCodeTextField.text!)") else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response,  error) in
            //            if response == nil {
            //                DispatchQueue.main.async {
            //                    ToastView.show(message: "Login failed! Check internet", controller: self)
            //                    self.businesssCodeTextField.isEnabled = true
            //                }
            //            }
            if let data = data {
                do {
                    guard  let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {return}
                    print(json)
                    let status = Course(json: json)
                    if (status.message == 1) {
                        DispatchQueue.main.async {
                            ToastView.show(message: Constants.BusinessCodeSuccess, controller: self)
                            self.businesssCodeTextField.isEnabled = true
                            UserDefaults.standard.set(self.businesssCodeTextField.text, forKey: Constants.loggedIn)
                            UserDefaults.standard.synchronize()
                            if let User = json[Constants.Data] as? [String: Any] {
                                if  let superuser = User[Constants.SuperUserID] as? Int {
                                    UserDefaults.standard.set(superuser, forKey: Constants.superuserA)
                                }
                            }
                            
                        }
                    }
                        
                    else if (status.message == 0) {
                        DispatchQueue.main.async {
                            ToastView.show(message: Constants.BusinessCodeFailed, controller: self)
                            self.businesssCodeTextField.isEnabled = true
                        }
                    }
                        
                    else if (status.message == 1000) {
                        DispatchQueue.main.async {
                            ToastView.show(message: LocalizedString.wrong, controller: self)
                            self.businesssCodeTextField.isEnabled = true
                        }
                    }
                        
                    else if (status.message == 1001) {
                        DispatchQueue.main.async {
                            ToastView.show(message: LocalizedString.invalid, controller: self)
                            self.businesssCodeTextField.isEnabled = true
                        }
                    }
                    else  {
                        DispatchQueue.main.async {
                            ToastView.show(message: LocalizedString.occured, controller: self)
                            self.businesssCodeTextField.isEnabled = true
                        }
                    }
                    
                } catch {
                    
                    print(error)
                    ToastView.show(message: " BusinessCode Failed! Try Again", controller: self)
                    self.businesssCodeTextField.isEnabled = true
                }
                
            }
            }.resume()
        
        
        
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let aSet = NSCharacterSet(charactersIn:"0123456789٠١٢٣٤٥٦٧٨٩").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
    }
    
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField.text!.count  == 4          {
            pinCodeTextField.isEnabled = false
            if L102Language.currentAppleLanguage() == "ar" {
                let NumberStr: String = textField.text!
                let Formatter = NumberFormatter()
                Formatter.locale = NSLocale(localeIdentifier: "EN") as Locale?
                if let final = Formatter.number(from: NumberStr) {
                    textField.text = "\(final)"
            }
                
            }
            PincodeApi()
            
        }
    }
    
    @objc func bussinessCodeDidChange(_ textField: UITextField) {
        
        if businesssCodeTextField.text!.count == 10 {
            businesssCodeTextField.isEnabled = false
            BusinessApi()
        }
            
        else if  businesssCodeTextField.text!.count > 10 {
            
            let alert = UIAlertController(title: LocalizedString.Alert, message: LocalizedString.limitExceeded, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: LocalizedString.OK, style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        //businesssCodeTextField.text = "POS-"
        pinCodeTextField.text = ""
        businesssCodeTextField.isEnabled = true
        pinCodeTextField.isEnabled = true
    }
    
    override func viewDidLayoutSubviews() {
        setupUI()
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    
    
    func setupUI() {
        btnUpArrow.layer.cornerRadius = btnUpArrow.frame.size.width/2
        btnHelp.layer.cornerRadius = btnHelp.frame.size.width/2
        btnCustomer.layer.cornerRadius = btnCustomer.frame.size.width/2
        businesssCodeTextField.layer.cornerRadius = 30.0
        pinCodeTextField.layer.cornerRadius = 30.0
    }
    

    
}
extension UIActivityIndicatorView {
    func dismissLoader() {
        self.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
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
        if(self.actualText.count > (self.text?.count)!) {
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
        if( self.text != nil && (self.text?.count)! > 0) {
            self.textFrom += String(describing: (self.text?.last!)!)
        }
        else {
            self.textFrom = ""
            self.text = ""
        }
        self.actualText = textFrom
        //self.text = self.dotPlaceholder()
    }
    
    @objc func editingDidFinish() {
        //self.isSecureTextEntry = false
        self.actualText = self.textFrom
        // self.text = self.dotPlaceholder()
    }
    
    //    func dotPlaceholder() -> String {
    //        var index = 0
    //        var dots = ""
    //        while index < (self.text?.characters.count)! {
    //            dots += "•"
    //            index += 1
    //        }
    //        return dots
}




extension String {
    func toImage() -> UIImage? {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters){
            return UIImage(data: data)
        }
        return nil
    }
}


extension String {

    var isDigit: Bool {
        get {
            return !unicodeScalars.isEmpty && CharacterSet.decimalDigits.contains(unicodeScalars.first!)
        }
    }
}
