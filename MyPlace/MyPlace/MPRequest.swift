//
//  MPRequest.swift
//  MyPlace
//
//  Created by Santosh S on 20/6/17.
//  Copyright © 2017 Santosh. All rights reserved.
//

import UIKit
import Alamofire

class MPRequest {
    
    var url : URL
    var method : HTTPMethod
    var params : Dictionary<String,AnyObject>?
    
    init(url : URL, method : HTTPMethod = .get) {
        
        self.url = url
        self.method = method
    }
}
