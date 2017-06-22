//
//  MPMapDisplayPresenter.swift
//  MyPlace
//
//  Created by Santosh S on 21/6/17.
//  Copyright © 2017 Santosh. All rights reserved.
//

import Foundation

protocol MPMapDisplayPresenterDatasource {
    
    func place(at context : Int) -> MPPlace?
}

class MPMapDisplayPresenter : MapDisplayPresenter {
    
    weak var view: MapDisplayView!
    var interactor: MapDisplayUseCase?
    var router: MapDisplayWireframe!
    private var place : MPPlace?
    var context : Int
    var datasource : MPMapDisplayPresenterDatasource
    
    init(context : Int, datasource : MPMapDisplayPresenterDatasource) {
        self.context = context
        self.datasource = datasource
    }
    
    func viewReadyToConfigure() {
        
        if let place = self.datasource.place(at: self.context) {
            self.place = place
            self.view.updateUI(for : place)
        }
    }
}

extension MPMapDisplayPresenter : MapDisplayInteractorOutput {
    

}
