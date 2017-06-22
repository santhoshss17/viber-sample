//
//  MPPlace.swift
//  MyPlace
//
//  Created by Santosh S on 21/6/17.
//  Copyright © 2017 Santosh. All rights reserved.
//

import UIKit
import CoreLocation

class MPPlace: Equatable {
    
    enum MPPlaceState : String {
        case open = "Open"
        case close = "Closed"
        case notApplicable = "NA"
        
        func bgColor() -> UIColor {
            
            switch self {
            case .open:
                return UIColor.init(colorLiteralRed: 3/255.0, green: 137/255.0, blue: 22/255.0, alpha: 1.0)
            case .close:
                return UIColor.init(colorLiteralRed: 160/255.0, green: 10/255.0, blue: 25/255.0, alpha: 1.0)
            default:
                return UIColor.clear
            }
        }
    }
    
    var id : String
    var name : String
    var vicinity : String?
    var types : [String]?
    var photoRef : String?
    var photo : UIImage?
    var placeState : MPPlaceState = .notApplicable
    var location : CLLocationCoordinate2D?
    
    init(id :String, name : String) {
        self.id = id
        self.name = name
    }
    
    convenience init?(jsonResponse : Dictionary<String, AnyObject>) {
        
        guard let name = jsonResponse["name"] as? String, let id = jsonResponse["place_id"] as? String else {
            
            print("Place should have name and id")
            return nil
        }
        
        self.init(id: id, name: name)
        
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
        
        if let photosRes = jsonResponse["geometry"] as? [String : AnyObject], let lat = photosRes["location"]?["lat"] as? Double, let lng = photosRes["location"]?["lng"] as? Double{

            self.location = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        }
    }
    
    func typesDescription() -> String {
        
        var typesDescription : String = ""
        if let types = self.types {
            
            for type in types {
                
                typesDescription += "\(type), "
            }
        }
        
        return typesDescription
    }
}

func ==(lhs: MPPlace, rhs: MPPlace) -> Bool {
    
    return lhs.id == rhs.id
}
