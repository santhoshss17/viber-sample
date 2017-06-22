//
//  MPCategoryListProtocol.swift
//  MyPlace
//
//  Created by Santosh S on 19/6/17.
//  Copyright © 2017 Santosh. All rights reserved.
//

import UIKit

protocol CategoryListView : class {
    var presenter: CategoryListPresenter! { get set }
    
    func setTitle(title : String)
    func reloadCategories(sort : MPSortCategory)
}

protocol CategoryListPresenter: class {
    weak var view: CategoryListView! { get set }
    var interactor: CategoryListUseCase? { get set }
    var router: CategoryListWireframe! { get set }
    var categories : [MPCategory]? { get }
    
    func viewReadyToConfigure()
    func userDidSelect(category : MPCategory)
}

protocol CategoryListUseCase: class {
    weak var output: CategoryListInteractorOutput! { get set }
    
    func fetchCategories(completion : ([MPCategory])->Void)
    func updateRank(category : MPCategory)
}

protocol CategoryListInteractorOutput: class {
    
}

protocol CategoryListWireframe: class {
    weak var viewController: UIViewController? { get set }
    
    func displayPlaceListView(category : MPCategory)
}
