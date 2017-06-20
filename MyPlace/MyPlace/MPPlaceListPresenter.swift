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
    
    func viewReadyToConfigure() {
        
        
    }

}

extension MPPlaceListPresenter : PlaceListInteractorOutput {
    
    
}
