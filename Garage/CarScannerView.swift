//
//  CarScannerView.swift
//  Garage
//
//  Created by Amjad Ali on 7/19/18.
//  Copyright © 2018 Amjad Ali. All rights reserved.
//

import AVFoundation  
import UIKit
import Alamofire



class CarScannerView: UIViewController , AVCaptureMetadataOutputObjectsDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    //  var scanEnabled: Bool = false
    
    @IBOutlet weak var camerView: UIView!
    @IBOutlet weak var addVintextfield: UITextField!
    @IBOutlet weak var addplateTextfield: UITextField!
    @IBOutlet weak var camerabtnOutlet: UIButton!
    @IBOutlet weak var imageview: UIImageView!
    
    var myImage: UIImage!
    
    var flag = 0
    
    @IBAction func scannerBackBtn(_ sender: Any) {
        //self.dismiss(animated: true, completion: nil)
        if let parentVC = self.parent as? ReceptionalistView {
            let storyboard = UIStoryboard(name: Constants.WelcomeView, bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: Constants.WelcomeVc) as? WelcomeView
            parentVC.switchViewController(vc: vc!, showFooter: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        capturingImage()
        addplateTextfield.isUserInteractionEnabled = false
        addplateTextfield.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        addVintextfield.isUserInteractionEnabled = false
        //  editVinPlateImage()
        
        
    }
    
    
    
    func editVinPlateImage() {
        
        addVintextfield.rightViewMode = .always
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 25))
        let Img = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        Img.image = UIImage(named: "editbilal")
        Img.center = Img.center
        container.addSubview(Img)
        addVintextfield.rightView = container
        addplateTextfield.rightViewMode = .always
        let Pcontainer = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 25))
        let PImg = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        PImg.image = UIImage(named: "editbilal")
        PImg.center = PImg.center
        Pcontainer.addSubview(PImg)
        addplateTextfield.rightView = Pcontainer
        
        
    }
    
    
    
    
    
    
    
    @IBAction func cameraBtn(_ sender: Any) {
        ToastView.show(message: "Under real time testing wil be in available next version", controller: self)
        //openCamera()
    }
    
    
    func openCamera()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self// as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImaged = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            
            print(pickedImaged)
            self.imageview.image = nil
            self.imageview.image = pickedImaged
            print(imageview.image)
            myImage = pickedImaged
            upload()
            
        }
        flag = 1
        
        picker.dismiss(animated: true, completion: nil)
        
        capturingImage()
        
    }
    
    
    func upload() {
        DispatchQueue.main.async {
            //   let params: Parameters = ["name": "abcd", "gender": "Male"]
            
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                
                multipartFormData.append(UIImageJPEGRepresentation(self.myImage!, 0.0)!, withName: "image", fileName: "file.jpeg", mimeType: "image/jpeg")
                
                // for (key, value) in params {
                //                            multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                //}
            }, to:"http://garageapi.isalespos.com/api/car/scan/plateno")
            { (result) in
                switch result {
                case .success(let upload, _, _):
                    
                    upload.uploadProgress(closure: { (Progress) in
                        print("Upload Progress: \(Progress.fractionCompleted)")
                    })
                    
                    upload.responseJSON { response in
                        //self.delegate?.showSuccessAlert()
                        print(response.request)  // original URL request
                        print(response.response) // URL response
                        print(response.data)     // server data
                        print(response.result)   // result of response serialization
                        //                        self.showSuccesAlert()
                        //self.removeImage("frame", fileExtension: "txt")
                        if let JSON = response.result.value as? NSObject {
                            DispatchQueue.main.async {
                                let descript = JSON.value(forKey: "Description") as! String
                                print(descript)
                                ToastView.show(message: descript, controller: self)
                                if let Platenmb = JSON.value(forKey: "PlateNo") as? String {
                                    self.addplateTextfield.text  = Platenmb
                                }
                            }
                        }
                    }
                    
                case .failure(let encodingError):
                    //self.delegate?.showFailAlert()
                    print(encodingError)
                }
            }
            
        }
        
        //       // let params: Parameters = ["name": "abcd" "gender": "Male"]
        //        Alamofire.upload(multipartFormData:
        //            {
        //            //    DispatchQueue.main.async {
        //                (multipartFormData) in
        //              //  DispatchQueue.main.async {
        //                multipartFormData.append(UIImageJPEGRepresentation(self.imageview.image!, 0.1)!, withName: "image", fileName: "file.jpeg", mimeType: "image/jpeg")
        ////                for (key, value) in params
        //             //   }
        //
        //
        ////                {
        ////                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
        ////                }
        //
        //              //  }
        //        }, to: "http://garageapi.isalespos.com/api/car/scan/plateno",headers:nil)
        //        { (result) in
        //            switch result {
        //
        //            case .success(let upload,_,_ ):
        //                upload.uploadProgress(closure: { (progress) in
        //                    //Print progress
        //                })
        //                upload.responseJSON
        //                    { response in
        //                        if let dict = response.result.value as? NSObject {
        //                               DispatchQueue.main.async {
        //                              let descript = dict.value(forKey: "Description") as! String
        //                            ToastView.show(message: descript, controller: self)
        //                            if let Platenmb = dict.value(forKey: "PlateNo") as? String {
        //
        //                                   self.addplateTextfield.text  = Platenmb
        //                                }
        //                            }
        //
        //
        ////                         let descript = dict.value(forKey: "Description") as! String
        ////                        let descript = dict.value(forKey: "PlateNo") as! String
        //                        }
        ////                        if status == 1
        ////                        {
        ////                            print("DATA UPLOAD SUCCESSFULLY")
        ////                        }
        ////
        ////                        else if status == 0 {
        ////                            print("DATA UPLOAD FAILED")
        ////
        ////                        }
        //
        //
        //                }
        //            case .failure(let encodingError):
        //                break
        //
        //            }
        //
        //        }
        //
        
    }
    
    
    
    func capturingImage() {
        self.view.layoutIfNeeded()
        view.backgroundColor = UIColor.black
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.code39]
        } else {
            failed()
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        
        
        
        self.view.layoutIfNeeded()
        previewLayer.frame.size = camerView.frame.size
        previewLayer.frame = camerView.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        
        if flag == 0 {
            self.view.layoutIfNeeded()
            camerView.layer.addSublayer(previewLayer)
        }
        
        
        
        captureSession.startRunning()
        
    }
    
    
    
    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }
        
        //  dismiss(animated: true)
    }
    
    
    func found(code: String) {
        print(code)
        
        addVintextfield.backgroundColor = UIColor.darkGray
        addVintextfield.isUserInteractionEnabled = true
        addVintextfield.text = code
        if code.characters.count  > 17  {
            addVintextfield.text = String(code.characters.dropFirst())
        }
        
        
        
        //        if let parentVC = self.parent as? ReceptionalistView {
        //            let storyboard = UIStoryboard(name: "AddnewCar", bundle: nil)
        //            let vc = storyboard.instantiateViewController(withIdentifier: "addNewCarVc") as? addNewCar
        //            parentVC.switchViewController(vc: vc!, showFooter: false)
        //        }
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    func showLoader() {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    
    
    
    @IBAction func continueBtn(_ sender: Any) {
        
        
        
        
        if addplateTextfield.text! == "" && addVintextfield.text! == "" {
            ToastView.show(message: "Please Enter any one Field", controller: self)
        }
        else if addplateTextfield.text! == "" {
            Constants.vinnmb = addVintextfield.text!
        }
        else if addVintextfield.text! == ""{
            Constants.platenmb = addplateTextfield.text!
        }
        
        if let parentVC = self.parent as? ReceptionalistView {
            // UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear , animations: {
            let storyboard = UIStoryboard(name: Constants.AddnewCar, bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: Constants.addNewCarVc) as? addNewCar
            
            parentVC.switchViewController(vc: vc!, showFooter: false)
            //  }, completion: nil)
            
        }
        
    }
    
    
    
    @IBAction func addPlateNmbBtn(_ sender: Any)  {
        addVintextfield.isUserInteractionEnabled = false
        addplateTextfield.backgroundColor = UIColor.darkGray
        addplateTextfield.attributedPlaceholder = NSAttributedString(string: "Enter Plate number", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white,.font: UIFont.boldSystemFont(ofSize: 14.0)])
        addplateTextfield.isUserInteractionEnabled = true
        
    }
    
    
    @IBAction func addVinAction(_ sender: Any) {
        addplateTextfield.isUserInteractionEnabled = false
        addVintextfield.backgroundColor = UIColor.darkGray
        addVintextfield.attributedPlaceholder = NSAttributedString(string: "Enter Vin number", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white,.font: UIFont.boldSystemFont(ofSize: 14.0)])
        addVintextfield.isUserInteractionEnabled = true
    }
    
    
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        var currentText = textField.text!.replacingOccurrences(of: "-", with: "")
        if currentText.count >= 4 {
            currentText.insert("-", at: currentText.index(currentText.startIndex, offsetBy: 3))
        }
        textField.text = currentText
        if textField.text!.characters.count  == 8          {
            
            addplateTextfield.resignFirstResponder()
            
        }
        else if textField.text!.characters.count  > 8  {
            let alert = UIAlertController(title: "Alert", message: "limit Exceeded", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    
}




