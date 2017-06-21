//
//  MPPlaceListProtocol.swift
//  MyPlace
//
//  Created by Santosh S on 20/6/17.
//  Copyright © 2017 Santosh. All rights reserved.
//

import UIKit
import CoreLocation

protocol PlaceListView : class {
    var presenter: PlaceListPresenter! { get set }
    
    func setTitle(title : String)
    func reloadPlaces()
}

protocol PlaceListPresenter: class {
    weak var view: PlaceListView! { get set }
    var interactor: PlaceListUseCase? { get set }
    var router: PlaceListWireframe! { get set }
    var places: [MPPlace] {get}
    
    func viewReadyToConfigure()
    func didSelectPlace(place : MPPlace)
}

protocol PlaceListUseCase: class {
    weak var output: PlaceListInteractorOutput! { get set }
    
    func fetchNearbyPlace(location : CLLocationCoordinate2D, category : MPCategory)
}

protocol PlaceListInteractorOutput: class {
    
    func didFetchPlaces(places : [MPPlace])
}

protocol PlaceListWireframe: class {
    weak var viewController: UIViewController? { get set }
    
    func displayMap(for place:MPPlace)
}
