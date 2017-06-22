//
//  MPPlaceNetworkService.swift
//  MyPlace
//
//  Created by Santosh S on 20/6/17.
//  Copyright © 2017 Santosh. All rights reserved.
//

import Foundation
import CoreLocation

class MPPlaceNetworkService : MPNetworkService {

    func fetchPlace(nearBy location : CLLocationCoordinate2D, radius:String, category : MPCategory,morePlacesToken : String?, completion : @escaping (_ response : MPResponse)->Void) {
        
        if let url = URL(string: kGAPIPlace) {
            
            let request = MPRequest(url: url)
            var params : [String:AnyObject] = [:]
            
            if(morePlacesToken == nil) {
                params["location"] =  "\(location.latitude),\(location.longitude)" as AnyObject //"-33.8670522,151.195736"
                params["radius"] = radius as AnyObject
                params["type"] = category.type as AnyObject
            } else {
                
                params["pagetoken"] = morePlacesToken as AnyObject
            }
            params["key"] = kGAPIKey as AnyObject
            request.params = params
            self.makeRequest(request: request, completion: { (response) in
                
                if let responseJson = response.jsonResponse as? Dictionary<String,AnyObject>, let placesJson = responseJson["results"] as? Array<Dictionary<String,AnyObject>>{
                    
                    var places = [MPPlace]()
                    for place in placesJson {
                        if let place = MPPlace(jsonResponse: place) {
                            places.append(place)
                        }
                    }
                    
                    var contextDict : [String:AnyObject?] = [:]
                    contextDict["Places"] = places as AnyObject
                    
                    if let nextToken = responseJson["next_page_token"] {
                        
                        contextDict["MorePlacesToken"] = nextToken as AnyObject
                    }
                    
                    response.context = contextDict as AnyObject
                }
                
                completion(response)
            })
        }
    }
}
