//
//  ImageViewExtension.swift
//  JET2Test
//
//  Created by VB Padey on 25/06/20.
//  Copyright © 2020 com.JET2.Test. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    //---------------------------------------------------------------------------------------
    //-------------------- Make image Round -------------------------
    //---------------------------------------------------------------------------------------
    func setSimpleProfileRoundImage() {
        DispatchQueue.main.async {
            super.layoutSubviews()
            let radius = self.frame.height/2.0
            self.layer.cornerRadius = radius
            self.layer.masksToBounds = false
            self.clipsToBounds = true
            self.layoutIfNeeded()
        }
        
    }
    //---------------------------------------------------------------------------------------
    //-------------------- Applying border --------------------
    //---------------------------------------------------------------------------------------
    func addBorder(borderColor: String?, borderWidth: String?) {
        if let borderWidth = borderWidth?.CGFloatValue()  {
            self.layer.borderWidth = borderWidth
        }
        if let borderColor = borderColor {
            self.layer.borderColor = borderColor.colorWithHexString(hex: borderColor).cgColor
        }
    }
    
    
    func tintImageColor(color : UIColor) {
        self.image = self.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        self.tintColor = color
    }
}
