//
//  Common.swift
//  Pradeep-ProficiencyExercise
//
//  Created by Pradeep on 03/07/20.
//  Copyright © 2020 Pradeep. All rights reserved.
//

import Foundation
import UIKit

struct Common {
    static func verifyUrl (urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
    static func scaleUIImageToSize(image: UIImage) -> UIImage {
        let hasAlpha = false
        let size: CGSize = CGSize(width: 90, height: 70)
        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
        image.draw(in: CGRect(origin: .zero, size: size))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return scaledImage
    }
}
struct Constants {
    static let apiString: String = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
    static let blankImageName: String = "noImage"
    static let messageTitle: String = "Message"
    static let messageBody: String = "Internet Connection not Available!"
    static let alertOk: String = "OK"
    static let canadaCellIdentifier: String = "canadaCell"
    static let rowHeight: CGFloat = 70.0
    static let leadingValue: CGFloat = 10.0
    static let trailingValue: CGFloat = 15.0
    static let imageWidth: CGFloat = 90.0
    static let imageHeight: CGFloat = 70.0
    static let titleFontSize: CGFloat = 20.0
    static let descriptionFontSize: CGFloat = 14.0
}
