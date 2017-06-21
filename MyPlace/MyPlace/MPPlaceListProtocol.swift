//
//  MPPlaceListProtocol.swift
//  MyPlace
//
//  Created by Santosh S on 20/6/17.
//  Copyright © 2017 Santosh. All rights reserved.
//

import UIKit

protocol PlaceListView : class {
    var presenter: PlaceListPresenter! { get set }
    
    func setTitle(title : String)
}

protocol PlaceListPresenter: class {
    weak var view: PlaceListView! { get set }
    var interactor: PlaceListUseCase? { get set }
    var router: PlaceListWireframe! { get set }
    
    func viewReadyToConfigure()
}

protocol PlaceListUseCase: class {
    weak var output: PlaceListInteractorOutput! { get set }
    
    func fetchNearbyPlace(category : MPCategory)
}

protocol PlaceListInteractorOutput: class {
    
    func didFetchPlaces(places : [MPPlace])
}

protocol PlaceListWireframe: class {
    weak var viewController: UIViewController? { get set }
}
