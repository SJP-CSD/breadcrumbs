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
    
    var locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
    }

    @IBAction func getLocation(sender: AnyObject) {
        locationManager.startUpdatingLocation()
        print("bruh", terminator: "")
    }
    
    func locationManager(manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation])
    {
        // Handle location updates here
        outputLabel.text = "bruh"
        print("brah", terminator: "")
    }
    
    func locationManager(manager: CLLocationManager,
        didFailWithError error: NSError)
    {
        // Handle errors here 
        print("breh", terminator: "")
        outputLabel.text = "breh"
    }
}

