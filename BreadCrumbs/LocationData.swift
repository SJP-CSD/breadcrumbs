//
//  LocationData.swift
//  BreadCrumbs
//
//  Created by JoeFrankMike on 12/18/15.
//  Copyright © 2015 Joseph Straceski. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MapKit

class LocationData: NSObject {
    
    var location: CLLocationCoordinate2D = CLLocationCoordinate2D()
    var photos: [String] = []

    override init()
    {
        
    }
    
    func getLocationDegrees() -> [CLLocationDegrees]
    {
        return [location.latitude, location.longitude]
    }
    
    func setLocationDegrees(value: [CLLocationDegrees])
    {
        self.location = CLLocationCoordinate2D(latitude: value[0], longitude: value[1])
    }
    
    func encodeWithCoder(aCoder: NSCoder!) {
        aCoder.encodeObject(getLocationDegrees(), forKey: "location")
        aCoder.encodeObject(photos, forKey: "photos")
    }
    
    init (coder aDecoder: NSCoder!) {
        let value = aDecoder.decodeObjectForKey("location") as! [CLLocationDegrees]
        self.location = CLLocationCoordinate2D(latitude: value[0], longitude: value[1])
        self.photos = aDecoder.decodeObjectForKey("photos") as! [String]
    }
    
}