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
    
    var savedCode = false {
        didSet {
            changeViewForSavedCode()
        }
    }
    
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
        businesssCodeTextField.text = "POS-"
        arrowImage()
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = Date()
        let dateString = dateFormatter.string(from: date) 
        if loggedIn() {
            businesssCodeTextField.addTarget(self, action: #selector(bussinessCodeDidChange(_:)), for: .editingChanged)
        }  else {
            businesssCodeTextField.addTarget(self, action: #selector(bussinessCodeDidChange(_:)), for: .editingChanged)
        }
        //  Constants.SuperUser = UserDefaults.standard.integer(forKey: "superuser")
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
                    ToastView.show(message: Constants.interneterror, controller: self)
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
                        }
                        
                        let storyboard: UIStoryboard = UIStoryboard(name: Constants.ReceptionalistView, bundle: nil)
                        let initViewController: UIViewController = storyboard.instantiateViewController(withIdentifier: Constants.ReceptionalistVc) as! ReceptionalistView
                        self.present(initViewController, animated: true, completion: nil)
                        
                    } else if (descript.status == 0) {
                        DispatchQueue.main.async {
                            ToastView.show(message: Constants.UserExistent, controller: self)
                            
                            self.pinCodeTextField.isEnabled = true
                            self.businesssCodeTextField.isEnabled = true
                        }
                    }
                    else if (descript.status == 1000) {
                        DispatchQueue.main.async {
                            ToastView.show(message: Constants.wrong, controller: self)
                            
                            self.pinCodeTextField.isEnabled = true
                            self.businesssCodeTextField.isEnabled = true
                        }
                    }
                        
                    else if (descript.status == 1001) {
                        DispatchQueue.main.async {
                            ToastView.show(message: Constants.invalid, controller: self)
                            self.pinCodeTextField.isEnabled = true
                            self.businesssCodeTextField.isEnabled = true
                        }
                    }
                        
                    else {
                        DispatchQueue.main.async {
                            ToastView.show(message: Constants.occured, controller: self)
                            self.pinCodeTextField.isEnabled = true
                            self.businesssCodeTextField.isEnabled = true
                        }
                    }
                    
                } catch {
                    
                    print(error)
                    DispatchQueue.main.async {
                        ToastView.show(message: Constants.Loginfailed, controller: self)
                        self.pinCodeTextField.isEnabled = true
                        self.businesssCodeTextField.isEnabled = true
                    }
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
                            ToastView.show(message: Constants.wrong, controller: self)
                            self.businesssCodeTextField.isEnabled = true
                        }
                    }
                        
                    else if (status.message == 1001) {
                        DispatchQueue.main.async {
                            ToastView.show(message: Constants.invalid, controller: self)
                            self.businesssCodeTextField.isEnabled = true
                        }
                    }
                    else  {
                        DispatchQueue.main.async {
                            ToastView.show(message: Constants.occured, controller: self)
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
    
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField.text!.characters.count  == 4          {
            pinCodeTextField.isEnabled = false
            PincodeApi()
            
        }
    }
    
    @objc func bussinessCodeDidChange(_ textField: UITextField) {
        
        if businesssCodeTextField.text!.characters.count == 10 {
            businesssCodeTextField.isEnabled = false
            BusinessApi()
        }
            
        else if  businesssCodeTextField.text!.characters.count > 10 {
            
            let alert = UIAlertController(title: "Alert", message: "limit Exceeded", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        //businesssCodeTextField.text = "POS-"
        pinCodeTextField.text = ""
        businesssCodeTextField.isEnabled = true
        pinCodeTextField.isEnabled = true
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    override func viewDidLayoutSubviews() {
        setupUI()
        //        businesssCodeTextField.layer.cornerRadius = 30.0
        //        pinCodeTextField.layer.cornerRadius = 30.0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    func setupUI() {
        btnUpArrow.layer.cornerRadius = btnUpArrow.frame.size.width/2
        btnHelp.layer.cornerRadius = btnHelp.frame.size.width/2
        btnCustomer.layer.cornerRadius = btnCustomer.frame.size.width/2
        businesssCodeTextField.layer.cornerRadius = 30.0
        pinCodeTextField.layer.cornerRadius = 30.0
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
        //            saveCompanyCodeWithNet({ (success,message) in
        //
        //                if(!success) {
        //                    if(message.contains("ncorrect") || message.contains("input")) {
        //                        completion(success,message)
        //                    }
        //                    else {
        //                        Utilities.showInfo(title: "Internet issue", body: "Trying offline.")
        //                        self.saveCompanyCodeWithOutNet({ (success,message) in
        //
        //                            completion(success,message)
        //                        })
        //                    }
        //                }
        //                else {
        //                    completion(success,message)
        //                }
        //            })
        //
        //        }
        //        else {
        //            print("Network not reachable")
        //
        //            saveCompanyCodeWithOutNet({ (success,message) in
        //
        //                completion(success,message)
        //            })
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





