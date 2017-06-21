//
//  MPPlaceListRouter.swift
//  MyPlace
//
//  Created by Santosh S on 20/6/17.
//  Copyright © 2017 Santosh. All rights reserved.
//

import UIKit

class MPPlaceListRouter : PlaceListWireframe {
    
    weak var viewController: UIViewController?
    
    class func buildPlaceListModule(category : MPCategory) -> UIViewController {
        
        let router = MPPlaceListRouter()
        let interactor = MPPlaceListInteractor()
        let presenter = MPPlaceListPresenter(category: category)
        
        if let placeListVC = UIViewController.viewController(storyboard : "MPPlaceListViewController") as? MPPlaceListViewController {
            
            router.viewController = placeListVC
            
            placeListVC.presenter = presenter
            presenter.view = placeListVC
            presenter.interactor = interactor
            presenter.router = router
            
            interactor.output = presenter
        }
        
        assert(router.viewController != nil, "Place List view cannot be nil")
        
        return router.viewController!
    }

    func displayMap(for place:MPPlace) {
        
        let mapDisplayViewController = MPMapDisplayRouter.buildMapDisplayModule(place: place)
        self.viewController?.navigationController?.pushViewController(mapDisplayViewController, animated: true)
    }
}
