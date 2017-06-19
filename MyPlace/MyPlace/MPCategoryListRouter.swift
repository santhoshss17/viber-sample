//
//  MPCategoryListRouter.swift
//  MyPlace
//
//  Created by Santosh S on 19/6/17.
//  Copyright © 2017 Santosh. All rights reserved.
//

import UIKit

class  MPCategoryListRouter : CategoryListWireframe {
 
    weak var viewController: UIViewController?
    
    func buildCategoryListModule() -> UIViewController {
        
        let router = MPCategoryListRouter()
        let interactor = MPCategoryListInteractor()
        let presenter = MPCategoryListPresenter()
        
        if let catListVC = UIViewController.viewController(storyboard : "MPCategoryListviewController") as? MPCategoryListviewController {
            
            router.viewController = catListVC
            catListVC.presenter = presenter
            
            presenter.view = catListVC
            presenter.interactor = interactor
            presenter.router = router
            
            interactor.output = presenter
        }
        
        assert(router.viewController != nil, "Root view cannot be nil")
        
        return router.viewController!
    }
}

extension MPCategoryListRouter : MPRootRouter {
    
    func loadRootView(window : UIWindow) {
        
        window.makeKeyAndVisible()
        window.rootViewController = self.buildCategoryListModule()
    }
}
