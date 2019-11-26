import Foundation
import UIKit
import CoreData


struct Common {
    
    /// Opens URL and Phone Number
    ///
    /// - Parameter phoneNumber: String a phone number
    static func makePhoneCall(phoneNumber: String) {
        let number = phoneNumber.replacingOccurrences(of: " ", with: "")
        self.openURL(urlString: "telprompt://\(number)")
    }
    
    /// Opens URL in browser
    ///
    /// - Parameter urlString: String a URL string
    static func openURL(urlString: String) {
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    /// Add a Child view controller on Parent as a subview
    ///
    /// - Parameter childController: Child Controller
    /// - Parameter parentController: Parent Controller
    /// - Parameter parentView: Parent's view to which subview will be added
    static func addChildController(childController: UIViewController, onParent parentController: UIViewController, onView parentView: UIView?) {
        parentController.addChild(childController)
        
        if let parentView = parentView {
            childController.view.bounds = parentView.bounds
            childController.view.frame.origin = CGPoint(x: 0, y: 0)
            parentView.addSubview(childController.view)
        }
        else {
            parentController.view.addSubview(childController.view)
        }
        childController.didMove(toParent: parentController)
    }
    
    /// Remove a Child view controller from Parent
    ///
    /// - Parameter childController: Child Controller to be removed
    static func hideContentController(childController: UIViewController) {
        childController.willMove(toParent: nil)
        childController.view.removeFromSuperview()
        childController.removeFromParent()
    }
    
    /// Add a Child view controller on Parent as a subview
    ///
    /// - Parameter childController: Child Controller
    /// - Parameter parentController: Parent Controller
    /// - Parameter parentView: Parent's view to which subview will be added
    /// - Parameter frame: Parent's view to which subview will be added
    static func addChildController(childController: UIViewController, onParent parentController: UIViewController, onView parentView: UIView, childframe frame: CGRect) {
        parentController.addChild(childController)
        childController.view.frame = frame
        parentView.addSubview(childController.view)
        childController.didMove(toParent: parentController)
    }
    
//    static func getItemsTotal(items: [CartItem]) -> Double {
//        var totalPrice = 0.0
//
//        for cartItem in items {
//            totalPrice += cartItem.totalPrice
//        }
//        return totalPrice
//    }
//
//    static func getItemsQuantity(items: [CartItem]) -> Float {
//        var quantity: Float = 0.0
//
//        for cartItem in items {
//            quantity += cartItem.quantity
//        }
//        return quantity
//    }
    
    /// Coredata utility method to delete all records in entity
    static func resetAllRecords(in entity : String) // entity = Your_Entity_Name
    {
        let context = DataController.context
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
    
    

}
