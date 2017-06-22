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
    var currentDownloader : [IndexPath:MPImageDownloader]?
    
    func fetchNearbyPlace(location : CLLocationCoordinate2D, category : MPCategory, morePlacesToken : String? = nil) {
        MPPlaceNetworkService().fetchPlace(nearBy:location , radius: kGMAPRadius, category: category, morePlacesToken : morePlacesToken) { (response) in
            
            if let places = response.context?["Places"] as? [MPPlace] {
                self.output.didFetchPlaces(places: places, morePlacesToken:response.context?["MorePlacesToken"] as?String)
            }
        }
    }
    
    func downloadImage(context : IndexPath, place : MPPlace) {

        if self.currentDownloader == nil {
            
            self.currentDownloader = [IndexPath:MPImageDownloader]()
        }
        
        if nil == self.currentDownloader?[context] {
            
            let imageDownloader = MPImageDownloader(dataSource: place, context: context as AnyObject)
            self.currentDownloader?[context] = imageDownloader
            imageDownloader.startDownload(completion: { 
                
                self.currentDownloader?[context] = nil
                
                if let indexpath = imageDownloader.context as? IndexPath, let place = imageDownloader.dataSource as? MPPlace {
                    
                    self.output.imageDownloaded(context: indexpath, place: place)
                }
            })
        }
    }
}
