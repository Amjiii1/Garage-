//
//  CollectionViewCell.swift
//  Garage
//
//  Created by Amjad on 22/02/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit
import Kingfisher


protocol tableviewNew {
    func onClickCell(index: Int)
    
}

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var countLbl: UILabel!
    @IBOutlet weak var minusBtn: UIButton!
    @IBOutlet weak var plusBtn: UIButton!
    
    weak var controller: ServiceCartView!
    var name: String!
    
    func decorate(for name: String, in controller: ServiceCartView) {
        self.name = name
        print(self.name)
        print(name)
        self.controller = controller
        self.countLbl.text = "1x"
    }
    func changeScore(offset: Int) {
        var score = self.controller.scores[self.name] ?? 0
        print("score: \(score)")
        score += offset
        
        self.controller.scores[self.name] = score
          print("self.controller.scores[self.name]: \(self.controller.scores[self.name])")
        
        self.countLbl.text = "\(score)x"
        
    }
    
    var cellDelegate: tableviewNew?
    var index: IndexPath?
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
        subtitle.text?.removeAll()
       // self.countLbl.text = "\(Constants.counterQTY)x"
     //   print(Constants.counterQTY)
    }
    func populate(with model: String, image: String) {
    
        subtitle.text = model.capitalized
        if let url = URL(string: image) {
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(with: url)
        }
    }
    
    
    @IBAction func addbtn(_ sender: Any) {
//       Constants.counterQTY = Constants.counterQTY + 1
//        let b = "x"
//        let num = String(Constants.counterQTY) + b
//        countLbl.text = num
//        cellDelegate?.onClickCell(index: (index?.row)!)
        self.changeScore(offset: 1)
        
    }
    
    
    @IBAction func minusbtn(_ sender: Any) {
//          Constants.counterQTY = Constants.counterQTY - 1
//        let b = "x"
//        let num = String(Constants.counterQTY) + b
//        countLbl.text = num
//         cellDelegate?.onClickCell(index: (index?.row)!)
         self.changeScore(offset: -1)
    }
    
    
    
    override func layoutSubviews() {
       plusBtn.layer.cornerRadius = plusBtn.frame.size.width/2
         minusBtn.layer.cornerRadius = minusBtn.frame.size.width/2
        
    //    plusBtn.layer.cornerRadius = plusBtn.frame.size.height/2
    
        super.layoutSubviews()
    }
}
