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
        
        if let catListNavVC = UIViewController.viewController(storyboard : "MPCategoryNavListviewController") as? UINavigationController, let catListVC = catListNavVC.viewControllers.first as? MPCategoryListviewController {
            
            router.viewController = catListNavVC

            catListVC.presenter = presenter
            presenter.view = catListVC
            presenter.interactor = interactor
            presenter.router = router
            
            interactor.output = presenter
        }
        
        assert(router.viewController != nil, "Root view cannot be nil")
        
        return router.viewController!
    }
    
    func displayPlaceListView(category : MPCategory) {
        
        let placeListViewController = MPPlaceListRouter.buildPlaceListModule(category: category)
        
        if let navController = self.viewController as? UINavigationController {
            navController.pushViewController(placeListViewController, animated: true)
        }
    }
}

extension MPCategoryListRouter : MPRootRouter {
    
    func loadRootView(window : UIWindow) {
        
        window.makeKeyAndVisible()
        window.rootViewController = self.buildCategoryListModule()
    }
}
