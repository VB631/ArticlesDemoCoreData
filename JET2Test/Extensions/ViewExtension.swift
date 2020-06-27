//
//  ViewExtension.swift
//  JET2Test
//
//  Created by VB Padey on 25/06/20.
//  Copyright © 2020 com.JET2.Test. All rights reserved.
//

import Foundation
import UIKit
extension UIView {
    
    
/* Applying Shadow to View ith corner radius */
//---------------------------------------------------------------------------------------
//-------------------- Applying Shadow to View ith corner radius -------------------------
//---------------------------------------------------------------------------------------
func addCustomBorder(borderColor: String?, cornerRadius: String?, borderWidth: String?) {
      if let borderWidth = borderWidth?.CGFloatValue()  {
          self.layer.borderWidth = borderWidth
      }
      if let cornerRadius = cornerRadius?.CGFloatValue() {
          self.layer.cornerRadius = cornerRadius
      }
      if let borderColor = borderColor {
          self.layer.borderColor = borderColor.colorWithHexString(hex: borderColor).cgColor
      }
     
  }
//-----------------------------------------------------------------------------
//-------------------- Make Circle -------------------------
    @objc //--@objc --------------------------------------------------------------------------
    func makeCircle(){
        self.layer.cornerRadius =  self.bounds.size.width / 2
        self.clipsToBounds = true
    }

}

