//
//  LabelExtension.swift
//  JET2Test
//
//  Created by VB Padey on 25/06/20.
//  Copyright © 2020 com.JET2.Test. All rights reserved.
//

import Foundation
import UIKit
extension UILabel {
    
//--------------------------------------------------------------------------------------------
// ------------------------------------ Make Circuler------------------------------
//--------------------------------------------------------------------------------------------

    func setCircular(cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius * self.bounds.size.width
        self.clipsToBounds = true
    }

//--------------------------------------------------------------------------------------------
// ------------------------------------ change Bg Color ------------------------------
//--------------------------------------------------------------------------------------------
    func setBackgroundColor(backgroundColor: String?) {
        if let backgroundColor = backgroundColor {
            self.backgroundColor = backgroundColor.colorWithHexString(hex: backgroundColor)
        }
        
    }
//--------------------------------------------------------------------------------------------
// ------------------------------------ Add Shadow ------------------------------
//--------------------------------------------------------------------------------------------
    func addShadow(shadowColor : UIColor) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = 0.6
        self.layer.shadowOffset = .init(width: 1, height: 1)
        self.layer.shadowRadius = 3.0
    }
    
    
//--------------------------------------------------------------------------------------------
// ------------------------------------ set Text color font of ------------------------------
//--------------------------------------------------------------------------------------------
    func setCustomText(text:String? ,font:String? ,size:String? ,color:String?,style:String?) {
    
        if let text = text {
            self.text = text
        }
        if let color = color {
            self.textColor = color.colorWithHexString(hex: color)
        }
        if let size = size {
            if let size = size.CGFloatValue() {
                if let font = font {
                    
                     self.font = UIFont.init(name: font, size:size)
                }
            }
        }
        
    }

}
