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

    func fetchNearbyPlace(location : CLLocationCoordinate2D, category : MPCategory) {
        
        MPPlaceNetworkService().fetchPlace(nearBy:location , radius: kGMAPRadius, category: category) { (response) in
            
            if let places = response.context as? [MPPlace] {
                self.output.didFetchPlaces(places: places)
            }
        }
    }

}
