//
//  CoreDataTest.swift
//  BreadCrumbs
//
//  Created by Joseph Straceski on 12/10/15.
//  Copyright (c) 2015 Joseph Straceski. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import CoreLocation
import MapKit

func getDocumentsURL() -> NSURL {
    let documentsURL: AnyObject = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
    return documentsURL as! NSURL
}

func fileInDocumentsDirectory(filename: String) -> String {
    
    let fileURL = getDocumentsURL().URLByAppendingPathComponent(filename)
    return fileURL.path!
    
}

class CoreDataTest: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
    @IBOutlet weak var text: UITextField!
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var numberField1: UITextField!
    @IBOutlet weak var numberField2: UITextField!
    
    @IBOutlet weak var imageDisplay: UIImageView!
    
    @IBAction func saveData(sender: UIButton) {
        let managedContext = appDelegate.managedObjectContext
        let entity =  NSEntityDescription.entityForName("Map",
            inManagedObjectContext: managedContext)
        let person = NSManagedObject(entity: entity!,
            insertIntoManagedObjectContext: managedContext)
        person.setValue(text.text, forKey: "name")
        
       
        
        if let n1 = NSNumberFormatter().numberFromString(numberField1.text!){
            if let n2 = NSNumberFormatter().numberFromString(numberField2.text!){
                let locationData = LocationData()
                locationData.location = CLLocationCoordinate2D(latitude: n1 as Double, longitude: n2 as Double)
                
                let image = imageDisplay.image
                let uniqueURL = "image" + "\(NSUUID())"
                saveImage(image!, path: uniqueURL)
                locationData.photos = [uniqueURL, uniqueURL]
                
                let mapData: [LocationData] = [locationData, locationData]
                let data = NSKeyedArchiver.archivedDataWithRootObject(mapData)
                
                person.setValue(data, forKey: "data")
                do {
                    try managedContext.save()
                } catch  {
                    print("Invalid File.")
                }
            }
        }
    }
    @IBAction func clearData(sender: UIButton) {
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Map")
        fetchRequest.returnsObjectsAsFaults = false
        do
        {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                managedContext.deleteObject(managedObjectData)
            }
        } catch {
        }
    }
    @IBAction func loadData(sender: UIButton) {
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Map")
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            let people = results as! [NSManagedObject]
            if let name: AnyObject = people.last?.valueForKey("name") {
                text.text = "\(name)"
            }
            if let rawLocation = people.last?.valueForKey("data") {
                let location = NSKeyedUnarchiver.unarchiveObjectWithData(rawLocation as! NSData) as! [LocationData]
                if let data: LocationData = location.last {
                    let value = data.location
                    numberField1.text = "\(value.latitude)"
                    numberField2.text = "\(value.longitude)"
                    let photos = data.photos as [String]
                    imageDisplay.image = loadImageFromPath(photos.first!)
                }
            }
        } catch  {
            print("Invalid File.")
        }
        
    }

    func saveImage (image: UIImage, path: String ){
        if let data = UIImagePNGRepresentation(image) {
            let filename = getDocumentsDirectory().stringByAppendingPathComponent(path)
            data.writeToFile(filename, atomically: true)
        }
    }
    
    func getDocumentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    
    func loadImageFromPath(path: String) -> UIImage? {
        let filename = getDocumentsDirectory().stringByAppendingPathComponent(path)
        let image = UIImage(contentsOfFile: filename)
        if image == nil {
            print("missing image at: \(path)")
        }
        return image
        
    }
    
    @IBAction func LoadDeaultImageButton(sender: UIButton) {
        imageDisplay.image = UIImage(named: "9296984")
    }
    
    @IBAction func takePhoto(sender: UIButton) {
        let alert = UIAlertController()
        alert.title = "Get a Picture From"
        
        alert.addAction(UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            self.imagePicker.sourceType = .Camera
            self.presentViewController(self.imagePicker, animated: true, completion: nil)
        })
        alert.addAction(UIAlertAction(title: "Camera Roll", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            self.imagePicker.sourceType = .PhotoLibrary
            self.presentViewController(self.imagePicker, animated: true, completion: nil)
        })
        presentViewController(alert, animated:true, completion:nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imageDisplay.image = image
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func saveName(name: String) {
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imageDisplay.contentMode = .ScaleAspectFit
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}