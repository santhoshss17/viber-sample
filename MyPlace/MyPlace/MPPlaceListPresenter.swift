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
    
    init(category : MPCategory) {
        
        self.category = category
    }
    
    func viewReadyToConfigure() {
        
        self.view.setTitle(title: "Neaby - \(self.category.title)")
        self.interactor?.fetchNearbyPlace(category : category)
    }
}

extension MPPlaceListPresenter : PlaceListInteractorOutput {
    
    func didFetchPlaces(places : [MPPlace]) {
        
        print("Found Places - \(places.count)")
    }
}
