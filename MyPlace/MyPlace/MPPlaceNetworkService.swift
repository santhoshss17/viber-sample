//
//  MPPlaceNetworkService.swift
//  MyPlace
//
//  Created by Santosh S on 20/6/17.
//  Copyright © 2017 Santosh. All rights reserved.
//

import Foundation

class MPPlaceNetworkService : MPNetworkService {
    //"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=-33.8670522,151.1957362&radius=500&type=restaurant&keyword=cruise&key=
    func fetchPlace(nearBy radius:Int, category : MPCategory, completion : @escaping (_ response : MPResponse)->Void) {
        
        if let url = URL(string: kGAPIPlace) {
            
            let request = MPRequest(url: url)
            var params : [String:AnyObject] = [:]
            params["location"] = "-33.8670522,151.195736" as AnyObject
            params["radius"] = "500" as AnyObject
            params["type"] = "restaurant" as AnyObject
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
