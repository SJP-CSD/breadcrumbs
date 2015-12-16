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
    @IBOutlet weak var label: UILabel!
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let imagePicker = UIImagePickerController()
    
    
    @IBOutlet weak var imageDisplay: UIImageView!
    
    @IBAction func saveData(sender: UIButton) {
        let managedContext = appDelegate.managedObjectContext
        let entity =  NSEntityDescription.entityForName("Location",
            inManagedObjectContext: managedContext)
        let person = NSManagedObject(entity: entity!,
            insertIntoManagedObjectContext: managedContext)
        person.setValue(text.text, forKey: "name")
        //let error = NSErrorPointer()
        do {
            try managedContext.save()
        } catch  {
            print("Invalid File.")
        }
    }
    @IBAction func clearData(sender: UIButton) {
        
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Location")
        //let error = NSErrorPointer()
        do {
            let data = try managedContext.executeFetchRequest(fetchRequest)
            let results = data as! [NSManagedObject]
            for result in results {
                managedContext.deleteObject(result)
            }
        } catch  {
            print("Invalid File.")
        }
    }
    @IBAction func loadData(sender: UIButton) {
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Location")
            //let error = NSErrorPointer()
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            let people = results as! [NSManagedObject]
            if let name: AnyObject = people.last?.valueForKey("name") {
                label.text = "\(name)"
            }
        } catch  {
            print("Invalid File.")
        }
        
    }

    func saveImage (image: UIImage, path: String ) -> Bool {
        let pngImageData = UIImagePNGRepresentation(image)
        let result = pngImageData!.writeToFile(path, atomically: true)
        return result
    }
    
    func loadImageFromPath(path: String) -> UIImage? {
        let image = UIImage(contentsOfFile: path)
        if image == nil {
            print("missing image at: \(path)")
        }
        print("Loading image from path: \(path)")
        return image
        
    }
    
    @IBAction func LoadImageButton(sender: UIButton) {
        let imagePath = fileInDocumentsDirectory("9296984.png")
        //let image = loadImageFromPath(imagePath)
        imageDisplay.image = UIImage(named: "9296984")
    }
    
    @IBAction func takePhoto(sender: UIButton) {
        imagePicker.sourceType = .Camera
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imageDisplay.contentMode = .ScaleAspectFit
        imageDisplay.image = image
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func saveName(name: String) {
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}