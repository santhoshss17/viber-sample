//
//  MPMapDisplayProtocol.swift
//  MyPlace
//
//  Created by Santosh S on 21/6/17.
//  Copyright © 2017 Santosh. All rights reserved.
//

import UIKit

protocol MapDisplayView : class {
    var presenter: MapDisplayPresenter! { get set }
    
    func updateUI(for place : MPPlace)
    func displayAlert(message : String, primaryButtonTitle : String)
}

protocol MapDisplayPresenter: class {
    weak var view: MapDisplayView! { get set }
    var interactor: MapDisplayUseCase? { get set }
    var router: MapDisplayWireframe! { get set }
    
    func viewReadyToConfigure()
    func userNeedPreviousMap()
    func userNeedNextMap()
}

protocol MapDisplayUseCase: class {
    weak var output: MapDisplayInteractorOutput! { get set }
    
}

protocol MapDisplayInteractorOutput: class {
    
}

protocol MapDisplayWireframe: class {
    weak var viewController: UIViewController? { get set }
}

