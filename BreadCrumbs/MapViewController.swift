//
//  ViewController.swift
//  BreadCrumbs
//
//  Created by Joseph Straceski on 12/1/15.
//  Copyright (c) 2015 Joseph Straceski. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    let locationManager = CLLocationManager()
    var didPressButton = false
    var didInit = false
    var follow = true
    var drawPath = false
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestAlwaysAuthorization()
        mapView.delegate = self
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
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
        follow = !follow
    }
    
    @IBAction func togglePath() {
        drawPath = !drawPath
    }

    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
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
        
    }
}


