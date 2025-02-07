//
//  Extension.swift
//  Smart Device Developement Project
//
//  Created by Ang Bryan on 29/7/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import Foundation
import UIKit
import MapKit

extension UIColor{
    
    static let darktextcolor = UIColor().colorFromHex("#c2373e")
    static let lighttextcolor = UIColor().colorFromHex("#ff9c97")
    static let graphcolor = UIColor().colorFromHex("#2E8B57")
    static let graphcolorbrown = UIColor().colorFromHex("#9A7B4F")
    func colorFromHex(_ hex: String) -> UIColor {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hexString.hasPrefix("#"){
            hexString.remove(at: hexString.startIndex)
        }
        if hexString.count != 6 {
            return UIColor.black
        }
        var rgb : UInt32 = 0
        Scanner(string: hexString).scanHexInt32(&rgb)
        
        return UIColor.init(red: CGFloat((rgb & 0xFF0000) >> 16)/255.0,
                            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
                            blue: CGFloat(rgb & 0x0000FF) / 255.0 ,
                            alpha: 1.0)
    }

}
extension MKPinAnnotationView {
    class func greenpinColor() -> UIColor {
        return UIColor.green
    }
}
