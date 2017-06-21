//
//  MPPlace.swift
//  MyPlace
//
//  Created by Santosh S on 21/6/17.
//  Copyright © 2017 Santosh. All rights reserved.
//

import UIKit

class MPPlace {
    
    enum MPPlaceState {
        case open
        case close
        case notApplicable
    }
    
    var id : String
    var name : String
    var vicinity : String?
    var types : [String]?
    var photoRef : String?
    var placeState : MPPlaceState = .notApplicable
    
    init(id :String, name : String) {
        self.id = id
        self.name = name
    }
    
    convenience init?(jsonResponse : Dictionary<String, AnyObject>) {
        
        guard let name = jsonResponse["name"] as? String, let id = jsonResponse["place_id"] as? String else {
            
            print("Place should have name and id")
            return nil
        }
        
        self.init(id: name, name: id)
        
        //Photo Ref
        if let photosRes = jsonResponse["photos"] as? [AnyObject], photosRes.count > 0{
            
            if let photoRef = photosRes[0]["photo_reference"] as? String {
                self.photoRef = photoRef
            }
        }
        
        self.vicinity = jsonResponse["vicinity"] as? String
        self.types = jsonResponse["types"] as? [String]
        
        if let placeStateJson = jsonResponse["opening_hours"] as? [String : AnyObject], let state = placeStateJson["open_now"] as? Bool{

            self.placeState = (state) ? .open : .close
        }
    }
}
