//
//  cameraScan.swift
//  Garage
//
//  Created by Amjad on 02/09/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit


var addImage: UIImage!

class cameraScan: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func cmeraaction(_ sender: Any) {
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
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
         addImage = nil
        picker.dismiss(animated: true, completion: nil)
        dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(name: Notification.Name("imageadded"), object: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImaged = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            
            print(pickedImaged)
            print(addImage)
            addImage = nil
             print(addImage)
            addImage = pickedImaged
             print(addImage)
           
        NotificationCenter.default.post(name: Notification.Name("imageadded"), object: nil)
        picker.dismiss(animated: true, completion: nil)
        dismiss(animated: true, completion: nil)
//        capturingImage()
        
    }
    

}
}
