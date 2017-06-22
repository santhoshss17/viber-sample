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

    class func buildMapDisplayModule(context :Int, mapDatasource : MPMapDisplayPresenterDatasource) -> UIViewController {
        
        let router = MPMapDisplayRouter()
        let interactor = MPMapDisplayInteractor()
        let presenter = MPMapDisplayPresenter(context:context, datasource: mapDatasource)
        
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
