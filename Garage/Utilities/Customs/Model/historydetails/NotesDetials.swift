//
//  NotesDetials.swift
//  Garage
//
//  Created by Amjad on 04/09/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit
import Kingfisher

class NotesDetials: UIViewController {
    
    @IBOutlet weak var notescomment: UITextView!
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    
    @IBOutlet weak var image3: UIImageView!
    
    
    //Localization
    
    let Nocommentsadded = NSLocalizedString("Nocommentsadded", comment: "")
    
    
    //Localization
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        comment()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        image1.isUserInteractionEnabled = true
        image1.addGestureRecognizer(tapGestureRecognizer)
        let tapGestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        image2.isUserInteractionEnabled = true
        image2.addGestureRecognizer(tapGestureRecognizer1)
        let tapGestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        image3.isUserInteractionEnabled = true
        image3.addGestureRecognizer(tapGestureRecognizer3)
    }
    
    
    
    func comment() {
        
        
        
        for comment in HistoryDetails.savecarNotes {
            
            
            if comment.NotesComment != "" {
                self.notescomment.text = comment.NotesComment
            } else {
                notescomment.text = Nocommentsadded
                notescomment.textColor     = UIColor.black
                notescomment.textAlignment = .center
            }
            
            for  image in comment.Notes {
                // DispatchQueue.main.async {
                
                if self.image1.image == nil {
                    if let url = URL(string: image) {
                        self.image1.kf.indicatorType = .activity
                        self.image1.kf.setImage(with: url)
                        
                    }
                } else if self.image2.image == nil {
                    if let url = URL(string: image) {
                        self.image2.kf.indicatorType = .activity
                        self.image2.kf.setImage(with: url)
                    }
                } else if self.image3.image == nil {
                    if let url = URL(string: image) {
                        self.image3.kf.indicatorType = .activity
                        self.image3.kf.setImage(with: url)
                    }
                }
                
                
                
            }
            
            
            
        }
        
        if self.notescomment.text == "" {
            notescomment.text = Nocommentsadded
            notescomment.textColor     = UIColor.black
            notescomment.textAlignment = .center
        }
        
        
        
        
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        let newImageView = UIImageView(image: tappedImage.image)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
    
    
    
    
    
    
    
}
