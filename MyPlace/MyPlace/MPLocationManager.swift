//
//  MPLocationManager.swift
//  MyPlace
//
//  Created by Santosh S on 21/6/17.
//  Copyright © 2017 Santosh. All rights reserved.
//

import Foundation
import CoreLocation

class MPLocationManager : NSObject, CLLocationManagerDelegate{
    
    static let shared : MPLocationManager = MPLocationManager()
    private let locationManager  = CLLocationManager()
    private var lastAvailableLocation : CLLocationCoordinate2D?
    var currentLocation : CLLocationCoordinate2D? {
        
        if lastAvailableLocation == nil {
            
            self.refreshCurrentLocaiton()
        }
        return lastAvailableLocation
    }
    
    //Assuming currentlocation used only when required
    func refreshCurrentLocaiton() {
        
        self.requestLocationUpdates()
    }
    
    private func requestLocationUpdates() {

        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
            locationManager.startUpdatingLocation()
        }
    }
    
    //MARK : - Location Delegates
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let locValue = manager.location?.coordinate {
            
            self.lastAvailableLocation = locValue
            NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: kMPLocationUpdateNotificationKey)))
            self.locationManager.stopUpdatingLocation()
        }
    }
    
}
