//
//  ViewController.swift
//  Map(tt)
//
//  Created by William Parker on 12/1/15.
//  Copyright (c) 2015 William Parker. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var outputLabel: UILabel!
    let locationManager = CLLocationManager()
    var didPressButton = false
    var didInit = false
    var follow = false
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestAlwaysAuthorization()
        mapView.delegate = self
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.distanceFilter = 1
            locationManager.startUpdatingLocation()
        }
        else {
            print("Location Services Disabled")
        }
        
    }
    
    @IBAction func dropPin(sender: AnyObject) {
        locationManager.startUpdatingLocation()
        didPressButton = true
    }
    
    
    @IBAction func toggleFollow() {
        switch follow {
        case true: follow = false;
        case false: follow = true;
        default: break
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        outputLabel.text = "\(locValue.latitude) \(locValue.longitude)"

        if didPressButton {
            let anno: MKPointAnnotation = MKPointAnnotation()
            anno.coordinate = locValue
            anno.title = "Matt G."
            anno.subtitle = "Also Will Parker"
            mapView.addAnnotation(anno)
            didPressButton = false
        }
        if didInit == false || follow
        {
        mapView.setRegion(MKCoordinateRegionMake(locValue, MKCoordinateSpanMake(0, 0)), animated: true)
            didInit = true
        }
        
        
    }
    /*  XCODE 7 XCPODE 7 XKPDE 7 ZKDD 7
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
    let locValue:CLLocationCoordinate2D = manager.location!.coordinate
    outputLabel.text = "\(locValue.latitude) \(locValue.longitude)"
    
    mapView.setRegion(MKCoordinateRegionMake(locValue, MKCoordinateSpanMake(0, 0)), animated: true)
    //Find out what coordinate thing does
    }*/
    
    func locationManager(manager: CLLocationManager,
        didFailWithError error: NSError)
    {
        outputLabel.text = "Could Not Retrieve Location"
    }
}

