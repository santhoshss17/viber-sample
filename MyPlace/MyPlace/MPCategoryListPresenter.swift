//
//  MPCategoryListPresenter.swift
//  MyPlace
//
//  Created by Santosh S on 19/6/17.
//  Copyright © 2017 Santosh. All rights reserved.
//

import UIKit

class MPCategoryListPresenter : CategoryListPresenter {
    
    weak var view: CategoryListView!
    var interactor: CategoryListUseCase?
    var router: CategoryListWireframe!
    
    func viewReadyToConfigure() {
        
        self.view.setTitle(title: "Category")
        self.interactor?.fetchCategories(completion: { (categories) in
            
            self.view.updateCategories(categories: categories)
        })
    }
    
    func userDidSelect(category : MPCategory) {
        
        self.interactor?.updateCategoryRank(category : category)
        self.router.displayPlaceListView(category: category)
    }
}

extension MPCategoryListPresenter : CategoryListInteractorOutput {
    
    
}
