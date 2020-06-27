//
//  Enum.swift
//  JET2Test
//
//  Created by VB Padey on 25/06/20.
//  Copyright © 2020 com.JET2.Test. All rights reserved.
//

import Foundation
import UIKit

struct Font
{
    static let SFProTextMedium = "SFProText-Medium"
    static let SFProTextRegular = "SFProText-Regular"
    static let SFProTextSemibold = "SFProText-Semibold"
    
}

struct ErrorMsg {
    static let noInternateMsg = "No Internet connection. Please try again."
    static let serverErrorMsg = "Something went wrong. Please try again sometime."
    static let serverErrorTitle = "Server Error."
}

struct resourceType {
    static let GETARTICLESLIST = "GETARTICLESLIST"
}

enum Result<T, E: Error> {
    case success(T)
    case failure(E)
}
enum ErrorResult: Error {
    case network(string: String)
    case custom(string: String)
}

struct ApiName
{
    static let GETARTICLESLIST = "https://5e99a9b1bc561b0016af3540.mockapi.io/jet2/api/v1/blogs?"
}

struct  Color {
    static let grayColor = "BFBFBF"
    static let grayColorNew = "9BA0B8"
    static let textBlue = "3E4677"
    static let white = "ffffff"
    static let cellSeparatorLine = "E9E9E9"
    static let btnBlueColor = "00D6DA"
    static let blackColor = "231F20"
}

struct Comman {
    static let objAppDelegate = UIApplication.shared.delegate as! AppDelegate
   
}
