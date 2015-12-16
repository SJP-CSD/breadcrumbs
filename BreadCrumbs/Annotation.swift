//
//  Annotation.swift
//  Map
//
//  Created by Jack on 12/6/15.
//  Copyright © 2015 William Parker. All rights reserved.
//

import Foundation
import MapKit

@objc class Annotation: NSObject, MKAnnotation {
    
    var name:String
    var thecoordinate:CLLocationCoordinate2D
    var isPin:Bool
    
    init(name:String,coordinate:CLLocationCoordinate2D,type:Bool) {
        self.name = name
        self.thecoordinate = coordinate
        self.isPin = type
    }
    
    @objc var coordinate: CLLocationCoordinate2D {
        get {
            return self.thecoordinate
        }
    }
    
    @objc var title: String? {
        get {
            return self.name
        }
    }
}