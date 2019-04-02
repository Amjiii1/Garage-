//
//  ReceiptBuilder.swift
//  Garage
//
//  Created by Amjad on 13/06/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import Foundation
import UIKit

class ReceiptBuilder {


    private let scale: CGFloat = 3.0
    let singleLineSpace = [NSAttributedStringKey.font: UIFont(name: FontsHelper.SanFranciscoProDisplay.medium.rawValue, size: 20.0)!]

    let sfProDisplay_semiBoldFontAttributes_90 = [NSAttributedStringKey.font: UIFont(name: FontsHelper.SanFranciscoProDisplay.medium.rawValue, size: 40.0)!]
    let sfProDisplay_mediumFontAttributes_27 = [NSAttributedStringKey.font: UIFont(name: FontsHelper.SanFranciscoProDisplay.medium.rawValue, size: 27.0)!]
    let sfProDisplay_boldFontAttributes_27 = [NSAttributedStringKey.font: UIFont(name: FontsHelper.SanFranciscoProDisplay.bold.rawValue, size: 27.0)!]
     let sfProDisplay_heavyFontAttributes_37bold = [NSAttributedStringKey.font: UIFont(name: FontsHelper.SanFranciscoProDisplay.bold.rawValue, size: 37.0)!]
    let sfProDisplay_heavyFontAttributes_37 = [NSAttributedStringKey.font: UIFont(name: FontsHelper.SanFranciscoProDisplay.medium.rawValue, size: 37.0)!]
    let sfProDisplay_heavyFontAttributes_30 = [NSAttributedStringKey.font: UIFont(name: FontsHelper.SanFranciscoProDisplay.medium.rawValue, size: 30.0)!]
    let sfProDisplay_semiBoldFontAttributes_30 = [NSAttributedStringKey.font: UIFont(name: FontsHelper.SanFranciscoProDisplay.medium.rawValue, size: 30.0)!]
    let sfProDisplay_mediumFontAttributes_30 = [NSAttributedStringKey.font: UIFont(name: FontsHelper.SanFranciscoProDisplay.medium.rawValue, size: 30.0)!]
    let sfProDisplay_mediumFontAttributes_32 = [NSAttributedStringKey.font: UIFont(name: FontsHelper.SanFranciscoProDisplay.medium.rawValue, size: 32.0)!]

    let geezaPro_boldFontAttributes_27 = [NSAttributedStringKey.font: UIFont(name: FontsHelper.SanFranciscoProDisplay.medium.rawValue, size: 27.0)!]
    let geezaPro_boldFontAttributes_30 = [NSAttributedStringKey.font: UIFont(name: FontsHelper.SanFranciscoProDisplay.medium.rawValue, size: 30.0)!]


    // MARK:- Public Methods

    /// Draws mutableString in given frame
    /// - Parameters:
    ///     - mutableString: NSMutableAttributedString
    ///     - frame: CGRect
    /// - Returns: Void
    func drawInRectWithString(mutableString: NSMutableAttributedString, frame: CGRect) {
        let mutableStringRect = frame
        mutableString.draw(in: mutableStringRect.integral)
    }

    /// Returns small separator
    /// - Returns: UIImage
    func getSeparatorSmall() -> UIImage {
        return getSeparator(width: CGFloat(Constants._4inchScale*0.84))
    }

    /// Returns full width separator
    /// - Returns: UIImage
    func getSeparator() -> UIImage {
        return getSeparator(width: CGFloat(Constants._4inchScale))
    }

    /// Creates a white image of given size
    /// - Parameters:
    ///     - size: CGSize
    /// - Returns: UIImage
    func getWhiteImage(size: CGSize)-> UIImage {
        return getWhiteImage(rect: CGRect(origin: CGPoint(x: 0, y: 0), size: size))
    }

    /// Converts string into image
    /// - Parameters:
    ///     - topImage: UIImage
    ///     - bottomImage: UIImage
    /// - Returns: UIImage
    func convertStringIntoImage(string: NSAttributedString, width: CGFloat, spaceAfter: CGFloat) -> UIImage {
        let stringDrawingOptions: NSStringDrawingOptions = [NSStringDrawingOptions.usesLineFragmentOrigin]
        let stringSize: CGSize = (string.boundingRect(with: CGSize(width: width, height: 10000), options: stringDrawingOptions, context: nil)).size
        let size = CGSize(width: width, height: stringSize.height + spaceAfter)
        return textToImage(drawText: string, textSize: stringSize, size: size)
    }

    /// Merges two image i.e. top image with bottom image under top image
    /// - Parameters:
    ///     - topImage: UIImage
    ///     - bottomImage: UIImage
    /// - Returns: UIImage
    func mergeImageTopToBottom(topImage: UIImage, bottomImage: UIImage) -> UIImage {
        let size = CGSize(width: topImage.size.width, height: topImage.size.height + bottomImage.size.height)
        UIGraphicsBeginImageContext(size)
        topImage.draw(in: CGRect(x: 0, y: 0, width: size.width, height: topImage.size.height))
        bottomImage.draw(in: CGRect(x: 0, y: topImage.size.height, width: size.width, height: bottomImage.size.height))
        let finalImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return finalImage!
    }

    /// Merges image with string (i.e. creates image of string first then merges)
    /// - Parameters:
    ///     - topImage: UIImage
    ///     - string: NSAttributedString
    ///     - width: CGFloat
    ///     - spaceAfter: CGFloat
    /// - Returns: UIImage
    func appendStringInImage(topImage: UIImage, string: NSAttributedString, width: CGFloat, spaceAfter: CGFloat) -> UIImage {
        let bottomImage = convertStringIntoImage(string: string, width: width, spaceAfter: spaceAfter)
        return mergeImageTopToBottom(topImage: topImage, bottomImage: bottomImage)
    }

    // MARK:- Private Methods

    /// Creates white colored image
    /// - Parameters:
    ///     - rect: CGRect
    /// - Returns: UIImage
    private func getWhiteImage(rect: CGRect) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(rect.size, _: false, _: scale)
        UIColor.white.setFill()
        UIRectFill(rect)
        let img: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return img
    }

    /// Draws text on image
    /// - Parameters:
    ///     - text: NSAttributedString
    ///     - textSize: CGSize
    ///     - size: CGSize
    /// - Returns: UIImage
    private func textToImage(drawText text: NSAttributedString, textSize: CGSize, size: CGSize) -> UIImage {
        let backGroundImage = getWhiteImage(rect: CGRect(origin: CGPoint(x: 0, y: 0), size: size))
        // Setup the image context using the passed image
        UIGraphicsBeginImageContextWithOptions(backGroundImage.size, false, scale)
        // Put the image into a rectangle as large as the original image
        backGroundImage.draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: backGroundImage.size))
        // Create a point within the space that is as bit as the image
        let rect = CGRect(x: (size.width-textSize.width)/2, y: (size.height-textSize.height)/2, width: size.width, height: textSize.height)
        // Draw the text into an image
        text.draw(with: rect, options: [NSStringDrawingOptions.usesLineFragmentOrigin], context: nil)
        // Create a new image out of the images we have created
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        // End the context now that we have the image we need
        UIGraphicsEndImageContext()
        //Pass the image back up to the caller
        return newImage!
    }

    /// Returns separator image
    /// - Parameters:
    ///     - width: CGFloat
    /// - Returns: UIImage
    func getSeparator(width: CGFloat)-> UIImage {
        let rect = CGRect(x: 0, y: 0, width: width, height: 2)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, scale)
        UIRectFill(rect)
        let separator: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        let backgroundImage = getWhiteImage(rect: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: Int(Constants._4inchScale), height: 6)))
        return drawImageOnImageInCenter(backgroundImage, centerImage: separator)
    }

    /// Draws image on another image i.e. centerImage in the middle of backgroundImage
    /// - Parameters:
    ///     - backgroundImage: UIImage
    ///     - centerImage: UIImage
    /// - Returns: UIImage
    private func drawImageOnImageInCenter(_ backgroundImage: UIImage, centerImage: UIImage) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(backgroundImage.size, _: false, _: scale)
        backgroundImage.draw(in: CGRect(x: 0, y: 0, width: backgroundImage.size.width, height: backgroundImage.size.height))
        centerImage.draw(in: CGRect(x: (backgroundImage.size.width-centerImage.size.width)/2, y: (backgroundImage.size.height-centerImage.size.height)/2, width: centerImage.size.width, height: centerImage.size.height))
        let resultImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return resultImage
    }

}
