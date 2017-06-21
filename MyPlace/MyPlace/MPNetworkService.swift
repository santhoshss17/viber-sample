//
//  MPNetworkBase.swift
//  MyPlace
//
//  Created by Santosh S on 20/6/17.
//  Copyright © 2017 Santosh. All rights reserved.
//

import UIKit
import Alamofire

class MPNetworkService {
    
    func makeRequest(request : MPRequest, completion : @escaping (_ response : MPResponse) -> Void) {

        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        Alamofire.request(request.url, method: request.method, parameters: request.params, headers: nil).responseJSON { (response) in
            
            let responseObj = MPResponse()
            responseObj.result = response.result as AnyObject
            
            if let json = response.result.value {
                responseObj.jsonResponse = json as AnyObject
            }

            completion(responseObj)
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
    
}
