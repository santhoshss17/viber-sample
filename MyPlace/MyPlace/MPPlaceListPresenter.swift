//
//  MPPlaceListPresenter.swift
//  MyPlace
//
//  Created by Santosh S on 20/6/17.
//  Copyright © 2017 Santosh. All rights reserved.
//

import Foundation

class MPPlaceListPresenter: PlaceListPresenter {
    
    weak var view: PlaceListView!
    var interactor: PlaceListUseCase?
    var router: PlaceListWireframe!
    fileprivate var category : MPCategory
    
    var places : [MPPlace] = [MPPlace]()
    fileprivate var morePlacesToken : String?
    
    init(category : MPCategory) {
        
        self.category = category
    }
    
    func viewReadyToConfigure() {
        
        self.view.setTitle(title: "Neaby - \(self.category.title)")
        
        guard MPLocationManager.shared.locationServicesEnabled() == true else {
            
            self.view.displayAlert(message: "Location service is not enabled. Please enable from settings", primaryButtonTitle: "Ok")
            return
        }
        
        if MPLocationManager.shared.currentLocation != nil {
            
            self.fetchPlaces()
            
        } else {
            
            NotificationCenter.default.addObserver(self, selector: #selector(locationDidUpdated), name: NSNotification.Name(rawValue: kMPLocationUpdateNotificationKey), object: nil)
        }
    }
    
    func didSelectPlace(place : MPPlace) {
        
        if let index = self.index(place: place) {
            self.router.displayMap(for : index, mapDatasource: self)
        }
    }
    
    func index(place : MPPlace) -> Int? {
        
        let index = self.places.index { (aPlace) -> Bool in
            return aPlace == place
        }

        return index
    }
    
    func fetchPlaces() {
        
        if let location = MPLocationManager.shared.currentLocation {
            
            self.interactor?.fetchNearbyPlace(location: location, category : category, morePlacesToken: self.morePlacesToken)
        }
    }
    
    @objc func locationDidUpdated() {
        
        NotificationCenter.default.removeObserver(self)
        self.fetchPlaces()
    }
    
    func didReachedEndOfContent() {
        
        self.fetchPlaces()
    }
    
    func needsImageForCell(context : IndexPath, place : MPPlace) {
        
        self.interactor?.downloadImage(context : context, place : place)
    }
}

extension MPPlaceListPresenter : PlaceListInteractorOutput {
    
    func didFetchPlaces(places : [MPPlace], morePlacesToken:String?){
    
        self.morePlacesToken = morePlacesToken
        self.places.append(contentsOf: places)
        self.view.reloadPlaces()
        
        print("Found Places - \(places.count)")
    }
    
    func imageDownloaded(context : IndexPath, place : MPPlace) {
        
        self.view.imageDownloaded(context: context, place: place)
    }

}

extension MPPlaceListPresenter : MPMapDisplayPresenterDatasource {
    
    func place(at context : Int) -> MPPlace? {
        
        if context < self.places.count && context >= 0 {

            return self.places[context]
        }
        
        return nil
    }
}
