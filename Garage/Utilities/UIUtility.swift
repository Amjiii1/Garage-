//
//  UIUtility.swift
//  Garage
//
//  Created by Amjad on 15/05/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit



enum AlertTitle: String {
    case Success
    case Error
    case Info
}


class UIUtility: NSObject {
 
    static func showNoInternetAlert() {
        showAlert(title: "Please check your internet")
    }
    
    static func showAlert(title: String, heading: AlertTitle = AlertTitle.Error) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: heading.rawValue, message: title, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                alert.dismiss(animated: true, completion: nil)
            }
            alert.addAction(okAction)
            let alertWindow = UIWindow(frame: UIScreen.main.bounds)
            alertWindow.windowLevel = UIWindow.Level.alert
            alertWindow.rootViewController = UIViewController()
            alertWindow.makeKeyAndVisible()
            alertWindow.rootViewController?.present(alert, animated: true, completion: nil)
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            appDelegate.navigationVC?.present(alert, animated: true, completion: nil)
//             UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
    static func shakeView(view: UIView) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: view.center.x - 10, y: view.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: view.center.x + 10, y: view.center.y))
        view.layer.add(animation, forKey: "position")
    }
    
    
    static func showAlertInController(title: String, message: String, viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: LocalizedString.OK, style: .default) { (action) in 
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(okAction)
        viewController.present(alert, animated: true, completion: nil)
    }
    
    class func boldString(_ string: String,fontName :String, fontSize:CGFloat) -> NSMutableAttributedString {
        let attrString = NSMutableAttributedString(string: string)
        let boldRange = (string as NSString).range(of: string)
        attrString.beginEditing()
        attrString.addAttribute(NSAttributedString.Key.font, value: UIFont(name: fontName, size: (fontSize))!, range: boldRange)
        attrString.endEditing()
        return attrString
    }
    
    class func drawInRectWithString(_ mutableString:NSMutableAttributedString,frame:CGRect){
        let mutableStringRect = frame
        mutableString.draw(in: mutableStringRect.integral)
    }
    class func drawInRectWithStringBold(_ value:String,frame:CGRect,fontName :String, fontSize:CGFloat){
        let mutableString = NSMutableAttributedString(attributedString: UIUtility.boldString(value, fontName: fontName, fontSize: fontSize))
        let mutableStringRect = frame
        mutableString.draw(in: mutableStringRect.integral)
    }
    
    class func getXReport(reponseObject:[String:Any],isZreport:Bool = false) -> Xreport {
        
        let totalSales:CGFloat = reponseObject["TotalSales"] as! CGFloat
        let minusDiscount:CGFloat = reponseObject["MinusDiscount"] as! CGFloat
        let minusVoid:CGFloat = reponseObject["MinusVoid"] as! CGFloat
        let minusComplimentary:CGFloat = reponseObject["MinusComplimentory"] as! CGFloat
        let minuesReturns:CGFloat = reponseObject["MinusReturn"] != nil ?  reponseObject["MinusReturn"] as! CGFloat : 0.0
        let tax:CGFloat = reponseObject["MinusTax"] as! CGFloat
        let netSales:CGFloat = reponseObject["NetSales"] as! CGFloat
        let plusGratuity:CGFloat = reponseObject["PlusGratuity"] as! CGFloat
        let plusCharges:CGFloat = reponseObject["PlusCharges"] as! CGFloat
        let totalTendered:CGFloat = reponseObject["TotalTendered"] as! CGFloat
        let cash:CGFloat = reponseObject["Cash"] as! CGFloat
        let credit:CGFloat = reponseObject["Card"] as! CGFloat
        let loyalty:CGFloat = reponseObject["Loyality"] as! CGFloat
        let giftCard:CGFloat = reponseObject["GiftCard"] as! CGFloat
        let coupons:CGFloat = reponseObject["Coupons"] as! CGFloat
        let totalTrNTypes:CGFloat = reponseObject["TotalTransactionType"] != nil ?  reponseObject["TotalTransactionType"] as! CGFloat : reponseObject["TotalTransactionType"] as! CGFloat
        let totalOrders:Int = reponseObject["TotalOrders"] as! Int
        
        let TotalCardOrders:Int = reponseObject["TotalCashOrders"] != nil ? reponseObject["TotalCashOrders"] as! Int : 0
        let TotalCashOrders:Int = reponseObject["TotalCardOrders"] != nil ? reponseObject["TotalCardOrders"] as! Int : 0
        let TotalVoidOrders:Int = reponseObject["TotalVoidOrders"] != nil ? reponseObject["TotalVoidOrders"] as! Int : 0
        let TotalRefundOrders:Int = reponseObject["TotalReturnOrders"] != nil ? reponseObject["TotalReturnOrders"] as! Int : 0
        let TotalMultiPayOrders:Int = reponseObject["TotatMultiPaymentOrders"] != nil ? reponseObject["TotatMultiPaymentOrders"] as! Int : 0
//        let Open:String = reponseObject["Open"] as! String
//        let Close:String = reponseObject["Close"] as! String
        
        
        
        
//        var ledger:CGFloat = 0.0
//        if(!isZreport){
//            ledger = reponseObject["TotalCityLedger"] as! CGFloat
//        }
        
        return Xreport(
            totalSales: NSString(format:"%.2f", totalSales) as String,
            minusDiscount: NSString(format:"%.2f", minusDiscount) as String,
            minusVoid: NSString(format:"%.2f", minusVoid) as String,
            minusComplimentary: NSString(format:"%.2f", minusComplimentary) as String,
            minuesReturns: NSString(format:"%.2f", minuesReturns) as String,
            tax: NSString(format:"%.2f", tax) as String,
            netSales: NSString(format:"%.2f", netSales) as String,
            plusGratuity: NSString(format:"%.2f", plusGratuity) as String,
            plusCharges: NSString(format:"%.2f", plusCharges) as String,
            totalTendered: NSString(format:"%.2f", totalTendered) as String,
            cash: NSString(format:"%.2f", cash) as String,
            credit: NSString(format:"%.2f", credit) as String,
            loyalty: NSString(format:"%.2f", loyalty) as String,
            giftCard: NSString(format:"%.2f", giftCard) as String,
            coupons: NSString(format:"%.2f", coupons) as String,
            totalTrNTypes: NSString(format:"%.2f", totalTrNTypes) as String,
            totalOrders: NSString(format:"%d", totalOrders) as String,
//            isZreport:isZreport,
//            Open: Open,
//            Close: Close,
            totalCashOrders: NSString(format:"%d", TotalCashOrders) as String,
            totalCardOrders: NSString(format:"%d", TotalCardOrders) as String,
            totalVoidOrders: NSString(format:"%d", TotalVoidOrders) as String,
            totalRefundOrders: NSString(format:"%d", TotalRefundOrders) as String,
            totalMultiPayOrders: NSString(format:"%d", TotalMultiPayOrders) as String
         //   ledger: NSString(format:"%.2f", ledger) as String
        )
    }

}
