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

    /* func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
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
    */
    //  XCODE 7 XCPODE 7 XKPDE 7 ZKDD 7
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        if didPressButton {
            let anno: Annotation = Annotation(name: "Matt", coordinate: locValue, type: true)
            mapView.addAnnotation(anno)
            didPressButton = false
        }
        if didInit == false
        {
            mapView.setRegion(MKCoordinateRegionMake(locValue, MKCoordinateSpanMake(0.01, 0.01)), animated: true)
            didInit = true
        }
        else if follow {
            var span = mapView.region.span
            mapView.setRegion(MKCoordinateRegionMake(locValue, span), animated: true)
        }
        if drawPath {
            let pathMarker: Annotation = Annotation(name: "", coordinate: locValue, type: false)
            mapView.addAnnotation(pathMarker)
        }
    }
    
    func locationManager(manager: CLLocationManager,
        didFailWithError error: NSError)
    {
        
    }
    

}

extension MapViewController {
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = AnnotationView(annotation: annotation, reuseIdentifier: "Map")
        annotationView.canShowCallout = true
        return annotationView
    }
}


