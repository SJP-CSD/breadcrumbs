//
//  ViewController.swift
//  Map
//
//  Created by William Parker on 12/1/15.
//  Copyright (c) 2015 William Parker. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var outputLabel: UILabel!
    
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hi")
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        else {
            print("Location Services Disabled")
        }
    }

    @IBAction func getLocation(sender: AnyObject) {
        locationManager.startUpdatingLocation()
        print("bruh", terminator: "")
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        outputLabel.text = "\(locValue.latitude) \(locValue.longitude)"
        //MATT MATT MATT MATT MATT MATT
        //MATT MATT MATT MATT MATT MATT
        //MATT MATT MATT MATT MATT MATT
        //MATT MATT MATT MATT MATT MATT
        //MATT MATT MATT MATT MATT MATT
        //MATT MATT MATT MATT MATT MATT
        //in this method, locValue stores the location in a CLLocationCoordinate2D
        //if that helps you,
        //for putting it into map and stuff
        
    }
    
    func locationManager(manager: CLLocationManager,
        didFailWithError error: NSError)
    {
        // Handle errors here 
        print("breh", terminator: "")
        outputLabel.text = "breh"
    }
}

