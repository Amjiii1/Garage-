//
//  CarScannerView.swift
//  Garage
//
//  Created by Amjad Ali on 7/19/18.
//  Copyright © 2018 Amjad Ali. All rights reserved.
//

import AVFoundation  
import UIKit



class CarScannerView: UIViewController , AVCaptureMetadataOutputObjectsDelegate, UITextFieldDelegate {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
  //  var scanEnabled: Bool = false
    
    @IBOutlet weak var camerView: UIView!
    
  
    @IBOutlet weak var addplateTextfield: UITextField!
    
    
    
    
    
    
    
    @IBAction func scannerBackBtn(_ sender: Any) {
        
     if let parentVC = self.parent as? ReceptionalistView {
            let storyboard = UIStoryboard(name: "WelcomeView", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "WelcomeVc") as? WelcomeView
            parentVC.switchViewController(vc: vc!, showFooter: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        capturingImage()
        addplateTextfield.isUserInteractionEnabled = false
        addplateTextfield.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        
        
    }
   
    
    func capturingImage() {
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
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            failed()
            return
        }

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = camerView.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        camerView.layer.addSublayer(previewLayer)


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
        if let parentVC = self.parent as? ReceptionalistView {
            let storyboard = UIStoryboard(name: "AddnewCar", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "addNewCarVc") as? addNewCar
            parentVC.switchViewController(vc: vc!, showFooter: false)
        }

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
        Constants.platenmb = addplateTextfield.text!
        if let parentVC = self.parent as? ReceptionalistView {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear , animations: {
            let storyboard = UIStoryboard(name: "AddnewCar", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "addNewCarVc") as? addNewCar
                
            parentVC.switchViewController(vc: vc!, showFooter: false)
          }, completion: nil)
          
        }
        //}
    }
    
    
    @IBAction func addPlateNmbBtn(_ sender: Any)  {       
        addplateTextfield.backgroundColor = UIColor.darkGray
        addplateTextfield.attributedPlaceholder = NSAttributedString(string: "Enter Plate number", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white,.font: UIFont.boldSystemFont(ofSize: 14.0)])
        addplateTextfield.isUserInteractionEnabled = true
        
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
 
}

}



