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
    //"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=-33.8670522,151.1957362&radius=500&type=restaurant&keyword=cruise&key=
    func fetchPlace(nearBy location : CLLocationCoordinate2D, radius:String, category : MPCategory, completion : @escaping (_ response : MPResponse)->Void) {
        
        if let url = URL(string: kGAPIPlace) {
            
            let request = MPRequest(url: url)
            var params : [String:AnyObject] = [:]
            params["location"] =  "\(location.latitude),\(location.longitude)" as AnyObject //"-33.8670522,151.195736"
            params["radius"] = radius as AnyObject
            params["type"] = category.title as AnyObject
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
                    
                    response.context = places as AnyObject
                }
                
                completion(response)
            })
        }
    }
}
