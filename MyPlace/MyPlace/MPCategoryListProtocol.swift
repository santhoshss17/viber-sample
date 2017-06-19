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
    func updateCategories(categories : [MPCategory])
}

protocol CategoryListPresenter: class {
    weak var view: CategoryListView! { get set }
    var interactor: CategoryListUseCase? { get set }
    var router: CategoryListWireframe! { get set }
    
    func viewReadyToConfigure()
}

protocol CategoryListUseCase: class {
    weak var output: CategoryListInteractorOutput! { get set }
}

protocol CategoryListInteractorOutput: class {
    
}

protocol CategoryListWireframe: class {
    weak var viewController: UIViewController? { get set }
}
