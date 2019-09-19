//
//  Loader.swift
//  MarnPOS-P2P
//
//  Created by Admin on 25/06/2018.
//  Copyright © 2018 Amjad Ali. All rights reserved.
//

import Foundation
import UIKit

class Loader1: NSObject {
    
    static private var parentView: UIView!
    static private var blurView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
    
    static private let shapeLayer = CAShapeLayer()
    static private var animation = CABasicAnimation()
    
    static private let ANIMATION_DURATION: Double = 3
    
    static private var keepAnimating: Bool = true
    
    class func show(view: UIView) {
        DispatchQueue.main.async {
        parentView = view
        blurView.backgroundColor = UIColor.black.withAlphaComponent(0.25)
        
        shapeLayer.path = loadingPath.cgPath
            shapeLayer.strokeColor = (UIColor.DefaultApp as! CGColor) //UIColor.init(netHex: 0x2D9D8A).cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 10.0
        shapeLayer.lineCap = kCALineCapRound
        
        
        blurView.layer.addSublayer(shapeLayer)
        parentView.addSubview(blurView)

        self.animateFirstCycle()
        }
    }
    
    class func hide() {
        DispatchQueue.main.async {
        keepAnimating = false
        shapeLayer.removeFromSuperlayer()
        blurView.removeFromSuperview()
        if parentView != nil {
            parentView.removeFromSuperview()
        }
        }
    }
    
    private class func animateFirstCycle() {
        DispatchQueue.main.async {
        if keepAnimating {
            CATransaction.begin()
            animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = 0.0
            animation.toValue = 1.0
            
            CATransaction.setCompletionBlock({
                self.animateLastCycle()
            })
            
            animation.duration = ANIMATION_DURATION
            animation.isRemovedOnCompletion = true
            animation.fillMode = kCAFillModeForwards
            shapeLayer.add(animation, forKey: "drawLineAnimation")
            CATransaction.commit()
        }
        }
    }
    
    private class func animateLastCycle() {
        DispatchQueue.main.async {
        if keepAnimating {
            CATransaction.begin()
            
            animation = CABasicAnimation(keyPath: "strokeStart")
            animation.fromValue = 0.0
            animation.toValue = 1.0
            
            CATransaction.setCompletionBlock({
                self.animateFirstCycle()
            })
            
            animation.duration = ANIMATION_DURATION
            animation.isRemovedOnCompletion = true
            animation.fillMode = kCAFillModeForwards
            shapeLayer.add(animation, forKey: "drawLineAnimation")
            CATransaction.commit()
        }
        }
    }
    
    static private var loadingPath: UIBezierPath {
        let loaderWidth = parentView.frame.size.width * 0.15
        let xAxis = (parentView.frame.size.width - loaderWidth)/2
        let yAxis = (parentView.frame.size.height - loaderWidth)/2
        let bezierPath = UIBezierPath(roundedRect: CGRect(x: xAxis, y: yAxis, width: loaderWidth, height: loaderWidth), cornerRadius: 10.0)
        return bezierPath
    }
    
    /// Apple logo bezier path generated from Paintcode.
    static private var loadingPathApple: UIBezierPath {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 185.37, y: 151.25))
        bezierPath.addCurve(to: CGPoint(x: 176.66, y: 166.91), controlPoint1: CGPoint(x: 182.92, y: 156.91), controlPoint2: CGPoint(x: 180.02, y: 162.12))
        bezierPath.addCurve(to: CGPoint(x: 165.44, y: 180.47), controlPoint1: CGPoint(x: 172.08, y: 173.44), controlPoint2: CGPoint(x: 168.33, y: 177.96))
        bezierPath.addCurve(to: CGPoint(x: 151.02, y: 186.82), controlPoint1: CGPoint(x: 160.96, y: 184.59), controlPoint2: CGPoint(x: 156.16, y: 186.7))
        bezierPath.addCurve(to: CGPoint(x: 137.7, y: 183.64), controlPoint1: CGPoint(x: 147.33, y: 186.82), controlPoint2: CGPoint(x: 142.88, y: 185.77))
        bezierPath.addCurve(to: CGPoint(x: 123.36, y: 180.47), controlPoint1: CGPoint(x: 132.5, y: 181.52), controlPoint2: CGPoint(x: 127.73, y: 180.47))
        bezierPath.addCurve(to: CGPoint(x: 108.61, y: 183.64), controlPoint1: CGPoint(x: 118.78, y: 180.47), controlPoint2: CGPoint(x: 113.87, y: 181.52))
        bezierPath.addCurve(to: CGPoint(x: 95.87, y: 186.99), controlPoint1: CGPoint(x: 103.35, y: 185.77), controlPoint2: CGPoint(x: 99.11, y: 186.88))
        bezierPath.addCurve(to: CGPoint(x: 81.13, y: 180.47), controlPoint1: CGPoint(x: 90.94, y: 187.2), controlPoint2: CGPoint(x: 86.03, y: 185.03))
        bezierPath.addCurve(to: CGPoint(x: 69.39, y: 166.43), controlPoint1: CGPoint(x: 78, y: 177.74), controlPoint2: CGPoint(x: 74.08, y: 173.06))
        bezierPath.addCurve(to: CGPoint(x: 56.98, y: 141.78), controlPoint1: CGPoint(x: 64.36, y: 159.35), controlPoint2: CGPoint(x: 60.22, y: 151.14))
        bezierPath.addCurve(to: CGPoint(x: 51.77, y: 112.4), controlPoint1: CGPoint(x: 53.51, y: 131.67), controlPoint2: CGPoint(x: 51.77, y: 121.88))
        bezierPath.addCurve(to: CGPoint(x: 58.81, y: 84.33), controlPoint1: CGPoint(x: 51.77, y: 101.54), controlPoint2: CGPoint(x: 54.12, y: 92.18))
        bezierPath.addCurve(to: CGPoint(x: 73.57, y: 69.41), controlPoint1: CGPoint(x: 62.51, y: 78.03), controlPoint2: CGPoint(x: 67.42, y: 73.06))
        bezierPath.addCurve(to: CGPoint(x: 93.52, y: 63.78), controlPoint1: CGPoint(x: 79.72, y: 65.76), controlPoint2: CGPoint(x: 86.36, y: 63.9))
        bezierPath.addCurve(to: CGPoint(x: 108.95, y: 67.37), controlPoint1: CGPoint(x: 97.43, y: 63.78), controlPoint2: CGPoint(x: 102.57, y: 64.99))
        bezierPath.addCurve(to: CGPoint(x: 121.18, y: 70.97), controlPoint1: CGPoint(x: 115.31, y: 69.76), controlPoint2: CGPoint(x: 119.39, y: 70.97))
        bezierPath.addCurve(to: CGPoint(x: 134.75, y: 66.73), controlPoint1: CGPoint(x: 122.52, y: 70.97), controlPoint2: CGPoint(x: 127.06, y: 69.55))
        bezierPath.addCurve(to: CGPoint(x: 153.2, y: 63.46), controlPoint1: CGPoint(x: 142.03, y: 64.11), controlPoint2: CGPoint(x: 148.17, y: 63.03))
        bezierPath.addCurve(to: CGPoint(x: 183.88, y: 79.61), controlPoint1: CGPoint(x: 166.83, y: 64.56), controlPoint2: CGPoint(x: 177.07, y: 69.93))
        bezierPath.addCurve(to: CGPoint(x: 165.78, y: 110.61), controlPoint1: CGPoint(x: 171.69, y: 86.99), controlPoint2: CGPoint(x: 165.66, y: 97.34))
        bezierPath.addCurve(to: CGPoint(x: 177.01, y: 136.38), controlPoint1: CGPoint(x: 165.89, y: 120.95), controlPoint2: CGPoint(x: 169.64, y: 129.55))
        bezierPath.addCurve(to: CGPoint(x: 188.23, y: 143.74), controlPoint1: CGPoint(x: 180.35, y: 139.55), controlPoint2: CGPoint(x: 184.08, y: 142))
        bezierPath.addCurve(to: CGPoint(x: 185.37, y: 151.25), controlPoint1: CGPoint(x: 187.33, y: 146.35), controlPoint2: CGPoint(x: 186.38, y: 148.85))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: 154.11, y: 28.24))
        bezierPath.addCurve(to: CGPoint(x: 145.25, y: 50.91), controlPoint1: CGPoint(x: 154.11, y: 36.34), controlPoint2: CGPoint(x: 151.15, y: 43.91))
        bezierPath.addCurve(to: CGPoint(x: 120.18, y: 63.28), controlPoint1: CGPoint(x: 138.13, y: 59.23), controlPoint2: CGPoint(x: 129.52, y: 64.04))
        bezierPath.addCurve(to: CGPoint(x: 119.99, y: 60.21), controlPoint1: CGPoint(x: 120.06, y: 62.31), controlPoint2: CGPoint(x: 119.99, y: 61.29))
        bezierPath.addCurve(to: CGPoint(x: 129.39, y: 37.31), controlPoint1: CGPoint(x: 119.99, y: 52.44), controlPoint2: CGPoint(x: 123.38, y: 44.11))
        bezierPath.addCurve(to: CGPoint(x: 140.84, y: 28.71), controlPoint1: CGPoint(x: 132.39, y: 33.86), controlPoint2: CGPoint(x: 136.21, y: 30.99))
        bezierPath.addCurve(to: CGPoint(x: 153.94, y: 25), controlPoint1: CGPoint(x: 145.46, y: 26.46), controlPoint2: CGPoint(x: 149.83, y: 25.21))
        bezierPath.addCurve(to: CGPoint(x: 154.11, y: 28.24), controlPoint1: CGPoint(x: 154.06, y: 26.08), controlPoint2: CGPoint(x: 154.11, y: 27.17))
        bezierPath.close()
        bezierPath.miterLimit = 4
        return bezierPath
    }
    
}

class Loader {

    static let loaderView = UIImageView()
    static let imagesListArray: NSMutableArray = []
    static let fakeTempView = UIView()
    
    class func startLoading() {
        DispatchQueue.main.async {
        if let rootVC = UIApplication.shared.keyWindow?.rootViewController {
            fakeTempView.frame = rootVC.view.frame
            rootVC.view.addSubview(fakeTempView)
            let loaderWidth:CGFloat = 135.0
            let loaderHeight:CGFloat = 135.0
            var frame = CGRect(x: 0, y: 0, width: loaderWidth, height: loaderHeight)
            frame.origin.x = (rootVC.view.frame.width / 2) - (loaderWidth/2)
            frame.origin.y = (rootVC.view.frame.height / 2) - (loaderHeight/2)
            loaderView.frame = frame
            rootVC.view.addSubview(loaderView)
            rootVC.view.bringSubview(toFront: fakeTempView)
            rootVC.view.bringSubview(toFront: loaderView)
        }
        loaderView.startAnimating()
        }
    }
    
    
    
    
    
    class func loadLoader() {
        for position in 0...50 {
            print(position)
            let strImageName : String = "\(position).png"
            let image  = UIImage(named:strImageName)
            imagesListArray.add(image!)
        }
        loaderView.animationImages = imagesListArray as NSArray as? [UIImage]
        loaderView.animationDuration = 4
        fakeTempView.backgroundColor = UIColor.black
        fakeTempView.alpha = 0.3
    }
    
    class func startLoadingInCenter(_ view: UIView){
        fakeTempView.frame = view.frame
        let loaderWidth:CGFloat = 135.0
        let loaderHeight:CGFloat = 135.0
        var frame = CGRect(x: 0, y: 0, width: loaderWidth, height: loaderHeight)
        frame.origin.x = (view.frame.width / 2) - (loaderWidth/2)
        frame.origin.y = (view.frame.height / 2) - (loaderHeight/2)
        loaderView.frame = frame
        view.addSubview(fakeTempView)
        view.addSubview(loaderView)
        loaderView.startAnimating()
    }

    class func startLoadingInsideView(_ view: UIView){
        let loaderWidth:CGFloat = view.frame.height
        let loaderHeight:CGFloat = view.frame.height
        let frame = CGRect(x: 10, y: 0, width: loaderWidth, height: loaderHeight)
        loaderView.frame = frame
        view.addSubview(loaderView)
        view.bringSubview(toFront: loaderView)
        if let rootVC = UIApplication.shared.keyWindow?.rootViewController {
            fakeTempView.frame = rootVC.view.frame
            rootVC.view.addSubview(fakeTempView)
        }
        loaderView.startAnimating()
    }
    
    class func stopLoading(){
        DispatchQueue.main.async {
            fakeTempView.removeFromSuperview()
            loaderView.removeFromSuperview()
            loaderView.stopAnimating()
        }
    }

}
