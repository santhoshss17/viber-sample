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
    var categories : [MPCategory]?
    
    func viewReadyToConfigure() {
        
        self.view.setTitle(title: "Category")
        self.interactor?.fetchCategories(completion: { (categories) in
            
            self.categories = categories
            self.categories?.sort(by: {$0.rank > $1.rank})
            
            self.view.reloadCategories()
        })
    }
    
    func userDidSelect(category : MPCategory) {
        
        self.updateRank(category:category)
        
        self.router.displayPlaceListView(category: category)
    }
    
    private func updateRank(category : MPCategory) {
        
        category.incrementRank()
        self.categories?.sort(by: {$0.rank > $1.rank})

        self.view.reloadCategories()
    }
}

extension MPCategoryListPresenter : CategoryListInteractorOutput {
    
    
}
