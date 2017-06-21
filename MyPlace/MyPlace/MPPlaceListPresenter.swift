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
    var category : MPCategory
    var places : [MPPlace] = [MPPlace]()
    
    init(category : MPCategory) {
        
        self.category = category
    }
    
    func viewReadyToConfigure() {
        
        self.view.setTitle(title: "Neaby - \(self.category.title)")
        
        if MPLocationManager.shared.currentLocation != nil {
            
            self.fetchPlaces()
            
        } else {
            
            NotificationCenter.default.addObserver(self, selector: #selector(locationDidUpdated), name: NSNotification.Name(rawValue: kMPLocationUpdateNotificationKey), object: nil)
        }
    }
    
    func didSelectPlace(place : MPPlace) {
        
        self.router.displayMap(for : place)
    }
    
    func fetchPlaces() {
        
        if let location = MPLocationManager.shared.currentLocation {
            self.interactor?.fetchNearbyPlace(location: location, category : category)
        }
    }
    
    @objc func locationDidUpdated() {
        
        NotificationCenter.default.removeObserver(self)
        self.fetchPlaces()
    }
}

extension MPPlaceListPresenter : PlaceListInteractorOutput {
    
    func didFetchPlaces(places : [MPPlace]) {
        
        self.places.append(contentsOf: places)
        self.view.reloadPlaces()
        print("Found Places - \(places.count)")
    }
}
