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
    
    func locationServicesEnabled() -> Bool{
        
        return CLLocationManager.locationServicesEnabled()
    }
    
    func distanceFromCurrentLocation(to location:CLLocationCoordinate2D) -> Double {
        
        var distanceInMeters :Double = 0
        
        if let lat = self.currentLocation?.latitude, let lng = self.currentLocation?.latitude {
            let currentCoordinate = CLLocation(latitude: lat, longitude: lng)
            let coordinate = CLLocation(latitude: location.latitude, longitude: location.longitude)
            
            distanceInMeters = currentCoordinate.distance(from: coordinate)
        }
        
        return distanceInMeters
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
