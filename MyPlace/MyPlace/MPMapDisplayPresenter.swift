//
//  MPMapDisplayPresenter.swift
//  MyPlace
//
//  Created by Santosh S on 21/6/17.
//  Copyright © 2017 Santosh. All rights reserved.
//

import Foundation

class MPMapDisplayPresenter : MapDisplayPresenter {
    
    weak var view: MapDisplayView!
    var interactor: MapDisplayUseCase?
    var router: MapDisplayWireframe!
    var place : MPPlace
    
    init(place : MPPlace) {
        self.place = place
    }
    
    func viewReadyToConfigure() {
        
        self.view.updateUI(for : self.place)
    }
}

extension MPMapDisplayPresenter : MapDisplayInteractorOutput {
    

}
