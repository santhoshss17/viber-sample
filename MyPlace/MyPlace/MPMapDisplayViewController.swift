//
//  MPMapDisplayViewController.swift
//  MyPlace
//
//  Created by Santosh S on 21/6/17.
//  Copyright © 2017 Santosh. All rights reserved.
//

import UIKit
import GoogleMaps

class MPMapDisplayViewController : UIViewController {
    
    var presenter: MapDisplayPresenter!
    var mapView : GMSMapView?

    @IBOutlet weak var placeVicinity: UILabel!
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var mapHolderView: UIView!
    @IBOutlet weak var placeState: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let camera = GMSCameraPosition.camera(withLatitude: 0, longitude: 0, zoom: 6.0)
        self.mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)

        if let mapView = self.mapView {
            
            self.mapHolderView.addSubview(mapView)
            
            let views = ["newView": mapView]
            mapView.translatesAutoresizingMaskIntoConstraints = false
            
            var actConstraints = [NSLayoutConstraint]()
            let hConstraint  = NSLayoutConstraint.constraints(withVisualFormat: "H:|[newView]|", options: [], metrics: nil, views: views)
            actConstraints += hConstraint
            let vConstraint  = NSLayoutConstraint.constraints(withVisualFormat: "V:|[newView]|", options: [], metrics: nil, views: views)
            actConstraints += vConstraint
            
            self.mapHolderView.addConstraints(actConstraints)
        }
        
        self.presenter.viewReadyToConfigure()
    }
    
    @IBAction func leftNavMapTapped(_ sender: Any) {
        
        self.presenter.userNeedPreviousMap()
    }
    
    @IBAction func rightNavMapTapped(_ sender: Any) {
        
        self.presenter.userNeedNextMap()
    }
    
}

extension MPMapDisplayViewController : MapDisplayView {
    
    func updateUI(for place : MPPlace) {
        
        if let lat = place.location?.latitude, let lng = place.location?.latitude {
            let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lng, zoom: 6.0)
            self.mapView?.camera = camera
            
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lng)
            marker.title = place.name
            marker.snippet = place.vicinity
            marker.map = mapView
        }

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
        
        if let placeLocation = place.location {
            let distance = round(MPLocationManager.shared.distanceFromCurrentLocation(to: placeLocation)/1000)
            self.distance.text = "\(distance) KM"
        }
    }
    
    func displayAlert(message : String, primaryButtonTitle : String) {
        
        let alert = UIAlertController(title: self.title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: primaryButtonTitle, style: .default, handler: { (action) in
            
        }))
        self.present(alert, animated: true, completion: {
            
        })
    }

}
