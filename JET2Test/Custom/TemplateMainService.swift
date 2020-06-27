//
//  TemplateMainService.swift
//  JET2Test
//
//  Created by VB Padey on 25/06/20.
//  Copyright © 2020 com.JET2.Test. All rights reserved.
//
import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

@objc protocol AppMainServiceDelegate : class {
    
    func didFetchData(responseData:Any) -> Void
    func didFailWithError(error:NSError) -> Void
}

class TemplateMainService: NSObject {
    
    weak var mainServerdelegate:AppMainServiceDelegate?
    var responseType = NSString()

    override init() {
    }
    
    //--------------------------------------------------------------------------
    //------------ Get call through Alamofire ---------------------------------
    //--------------------------------------------------------------------------
    func getCallWithAlamofire(serverUrl: String) -> Void
    {
        
        print(serverUrl)
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Accept": "application/json"
        ]
        
        AF.request(serverUrl, method: .get, parameters: nil ,encoding:URLEncoding.default , headers: headers).responseJSON {  response in
            
            switch response.result {
            case let .success(value):
                self.mainServerdelegate?.didFetchData(responseData: value)
                print("JSON: \(value)") 
                return
            case let .failure(error):
                self.mainServerdelegate?.didFailWithError(error: error as NSError)
                return
            }
            
        }
    }
  
    
}
