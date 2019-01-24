//
//  notesPopup.swift
//  Garage
//
//  Created by Amjad on 29/02/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit
import Alamofire


//struct  images {
//    let image1 = String
//    let image2 = String
//    let image3 = String
//}



class notesPopup: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    
    
    @IBOutlet weak var Image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    
    @IBOutlet weak var notesComt: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timelbl: UILabel!
    
    let dateFormatter : DateFormatter = DateFormatter()
    
    var flag = 0
    var image: UIImage!
    var images = [String]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notesComt.delegate = self
        self.navigationController?.isNavigationBarHidden = true
        notesComt.text = "Write Note"
        notesComt.textColor = UIColor.lightGray
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE, dd LLL yyyy"
        let nameOfMonth = dateFormatter.string(from: now)
        let time = Date()
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "hh:mm"
        let todaytime = timeFormatter.string(from:time)
        dateLabel.text = nameOfMonth
        timelbl.text = todaytime
   
        
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
    
    
    @IBAction func SaveButton(_ sender: Any) {
        print(images)
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
        
        Alamofire.upload(multipartFormData:
            {
                (multipartFormData) in
                multipartFormData.append(UIImageJPEGRepresentation(self.image, 0.1)!, withName: "image", fileName: "file.jpeg", mimeType: "image/jpeg")
                
        }, to: "\(CallEngine.baseURL)\(CallEngine.notesImguploadapi)",headers:nil)
        { (result) in
            switch result {
                
            case .success(let upload,_,_ ):
                upload.uploadProgress(closure: { (progress) in
                })
                upload.responseJSON
                    
                    { response in
                        if let dict = response.result.value as? NSObject {
                            DispatchQueue.main.async {
                                let descript = dict.value(forKey: "Description") as! String
                                ToastView.show(message: descript, controller: self)
                                if let imagekey = dict.value(forKey: "Image") as? String {
                                    self.images.append(imagekey)
                                }
                            }
                            
                            
                        }
                }
            case .failure(let encodingError):
                break
                
            }
            
        }
        
        
    }
    
    
    
}
