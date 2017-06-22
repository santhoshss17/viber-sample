//
//  MPPlaceListInteractor.swift
//  MyPlace
//
//  Created by Santosh S on 20/6/17.
//  Copyright © 2017 Santosh. All rights reserved.
//

import Foundation
import CoreLocation

class MPPlaceListInteractor: PlaceListUseCase {
    weak var output: PlaceListInteractorOutput!

    func fetchNearbyPlace(location : CLLocationCoordinate2D, category : MPCategory, morePlacesToken : String? = nil) {
        MPPlaceNetworkService().fetchPlace(nearBy:location , radius: kGMAPRadius, category: category, morePlacesToken : morePlacesToken) { (response) in
            
            if let places = response.context?["Places"] as? [MPPlace] {
                self.output.didFetchPlaces(places: places, morePlacesToken:response.context?["MorePlacesToken"] as?String)
            }
        }
    }
    
    func fetchPlace(token : String) {
        
        
    }

}
