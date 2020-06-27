//
//  StringExtension.swift
//  JET2Test
//
//  Created by VB Padey on 25/06/20.
//  Copyright © 2020 com.JET2.Test. All rights reserved.
//

import Foundation
import UIKit
extension String
{
//---------------------------------------------------------------------------------
//-------------------- Creates a UIColor from a Hex string. -------------------------
//------------------------------------------------------------------------------------

    func colorWithHexString (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: NSCharacterSet.whitespaces).uppercased()
        if (cString.hasPrefix("#")) {
            cString = String(cString.dropFirst())
        }
        
        if (cString.count != 6) {
            return UIColor.gray
        }
        
        let rString = String(cString[cString.index(cString.startIndex, offsetBy: 0)..<cString.index(cString.endIndex, offsetBy: -4)])
        let gString = String(cString[cString.index(cString.startIndex, offsetBy: 2)..<cString.index(cString.endIndex, offsetBy: -2)])
        let bString = String(cString[cString.index(cString.startIndex, offsetBy: 4)..<cString.index(cString.endIndex, offsetBy: -0)])
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(Float(r) / 255.0), green: CGFloat(Float(g) / 255.0), blue: CGFloat(Float(b) / 255.0), alpha: CGFloat(Float(1)))
    }
//---------------------------------------------------------------------------------
//-------------------- Convert String to CGFloat -------------------------
//------------------------------------------------------------------------------------
    func CGFloatValue() -> CGFloat? {
        guard let doubleValue = Double(self) else {
            return nil
        }
        
        return CGFloat(doubleValue)
    }

}
