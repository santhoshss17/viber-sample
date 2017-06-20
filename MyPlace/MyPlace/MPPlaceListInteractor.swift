//
//  MPPlaceListInteractor.swift
//  MyPlace
//
//  Created by Santosh S on 20/6/17.
//  Copyright © 2017 Santosh. All rights reserved.
//

import Foundation

class MPPlaceListInteractor: PlaceListUseCase {
    weak var output: PlaceListInteractorOutput!

    func fetchNearbyPlace(category : MPCategory) {
        
        MPPlaceNetworkService().fetchPlace(nearBy: 500, category: category.title) { 
            
            
        }
    }

}
