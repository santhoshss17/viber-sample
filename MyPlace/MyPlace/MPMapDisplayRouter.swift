//
//  MPMapDisplayRouter.swift
//  MyPlace
//
//  Created by Santosh S on 21/6/17.
//  Copyright © 2017 Santosh. All rights reserved.
//

import UIKit

class MPMapDisplayRouter : MapDisplayWireframe {

    weak var viewController: UIViewController?

    class func buildMapDisplayModule(place : MPPlace) -> UIViewController {
        
        let router = MPMapDisplayRouter()
        let interactor = MPMapDisplayInteractor()
        let presenter = MPMapDisplayPresenter(place: place)
        
        if let MapDisplayVC = UIViewController.viewController(storyboard : "MPMapDisplayViewController") as? MPMapDisplayViewController {
            
            router.viewController = MapDisplayVC
            
            MapDisplayVC.presenter = presenter
            presenter.view = MapDisplayVC
            presenter.interactor = interactor
            presenter.router = router
            
            interactor.output = presenter
        }
        
        assert(router.viewController != nil, "Map Display view cannot be nil")
        
        return router.viewController!
    }
}
