//
//  notesPopup.swift
//  Garage
//
//  Created by Amjad on 29/02/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit
import Alamofire

class notesPopup: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {

    
    @IBOutlet weak var Image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    
    @IBOutlet weak var notesComt: UITextView!
    
    var flag = 0
   var image: UIImage!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notesComt.delegate = self
       self.navigationController?.isNavigationBarHidden = true
        notesComt.text = "Write Note"
        notesComt.textColor = UIColor.lightGray
        
        
    }
    
    
    func textViewDidBeginEditing(_ notesComt: UITextView) {
        if notesComt.textColor == UIColor.lightGray {
            notesComt.text = nil
            notesComt.textColor = UIColor.black
        }
    }
    
    
    func textViewDidEndEditing(_ notesComt: UITextView) {
        if notesComt.text.isEmpty {
            notesComt.text = "Write Note"
            notesComt.textColor = UIColor.lightGray
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func PhotoaddBtn(_ sender: Any) {
        
        openCamera()
        
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
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            if flag == 0 {
                self.Image1.image = pickedImage
                flag = 1
            }
            else if flag == 1 {
                 self.image2.image = pickedImage
                 flag = 2
            }
            else if flag == 2 {
                self.image3.image = pickedImage
                flag = 0
            }
       image = pickedImage
        upload()

        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func upload() {
        
        // let params: Parameters = ["name": "abcd" "gender": "Male"]
        Alamofire.upload(multipartFormData:
            {
                //   DispatchQueue.main.async {
                (multipartFormData) in
                //  DispatchQueue.main.async {
                multipartFormData.append(UIImageJPEGRepresentation(self.image, 0.1)!, withName: "image", fileName: "file.jpeg", mimeType: "image/jpeg")
                //                for (key, value) in params
                //   }
                
                
                //                {
                //                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                //                }
                
                //   }
        }, to: "\(CallEngine.baseURL)\(CallEngine.notesImguploadapi)",headers:nil)
        { (result) in
            switch result {
                
            case .success(let upload,_,_ ):
                upload.uploadProgress(closure: { (progress) in
                    //Print progress
                })
                upload.responseJSON
                    
                    { response in
                        if let dict = response.result.value as? NSObject {
                            DispatchQueue.main.async {
                                let descript = dict.value(forKey: "Description") as! String
                                ToastView.show(message: descript, controller: self)
                                if let imagekey = dict.value(forKey: "Image") as? String {
                                    
                                   
                                }
                            }
                            
                            
                            //                         let descript = dict.value(forKey: "Description") as! String
                            //                        let descript = dict.value(forKey: "PlateNo") as! String
                        }
                        //                        if status == 1
                        //                        {
                        //                            print("DATA UPLOAD SUCCESSFULLY")
                        //                        }
                        //
                        //                        else if status == 0 {
                        //                            print("DATA UPLOAD FAILED")
                        //
                        //                        }
                        
                        
                }
            case .failure(let encodingError):
                break
                
            }
            
        }
        
        
    }
    
  

}
