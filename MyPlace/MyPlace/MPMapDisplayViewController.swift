//
//  MPMapDisplayViewController.swift
//  MyPlace
//
//  Created by Santosh S on 21/6/17.
//  Copyright © 2017 Santosh. All rights reserved.
//

import UIKit

class MPMapDisplayViewController : UIViewController {
    
    var presenter: MapDisplayPresenter!

    @IBOutlet weak var placeVicinity: UILabel!
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var mapHolderView: UIView!
    @IBOutlet weak var placeState: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter.viewReadyToConfigure()
    }
    
}

extension MPMapDisplayViewController : MapDisplayView {
    
    func updateUI(for place : MPPlace) {
        
        self.title = place.name
        self.placeName.text = place.name
        self.placeVicinity.text = place.vicinity
        
        self.placeState.isHidden = true
        let placeState = place.placeState
        if placeState != .notApplicable {
            
            self.placeState.isHidden = false
            self.placeState.text = placeState.rawValue
            self.placeState.backgroundColor = placeState.bgColor()
        }
    }

}
