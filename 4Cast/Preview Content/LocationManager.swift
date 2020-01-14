//
//  LocationManager.swift
//  4Cast
//
//  Created by Dylan MacFarlane on 12/13/19.
//  Copyright © 2019 Dylan MacFarlane. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationFetcherDelegate {
    func didUpdateLocation(_ locationAt: LocationFetcher, location: CLLocationCoordinate2D)
}

class LocationFetcher: NSObject, CLLocationManagerDelegate {
    
    let manager = CLLocationManager()
    
    var delegate: LocationFetcherDelegate?
    
    var lastKnownLocation: CLLocationCoordinate2D?

    override init() {
        super.init()
        manager.delegate = self
        
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func start() {
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
        manager.stopUpdatingLocation()
    }
}
