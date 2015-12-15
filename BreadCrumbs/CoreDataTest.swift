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
    
    @IBOutlet weak var imageDisplay: UIImageView!
    
    @IBAction func saveData(sender: UIButton) {
        if let managedContext = appDelegate.managedObjectContext
        {
            println("managedContext")
            let entity =  NSEntityDescription.entityForName("Location",
                inManagedObjectContext: managedContext)
            let person = NSManagedObject(entity: entity!,
                insertIntoManagedObjectContext: managedContext)
            person.setValue(text.text, forKey: "name")
            let error = NSErrorPointer()
            managedContext.save(error)
        }
    }
    @IBAction func clearData(sender: UIButton) {
        
        if let managedContext = appDelegate.managedObjectContext
        {
            let fetchRequest = NSFetchRequest(entityName: "Location")
            let error = NSErrorPointer()
            let data = managedContext.executeFetchRequest(fetchRequest, error: error)
            let results = data as! [NSManagedObject]
            for result in results {
                managedContext.deleteObject(result)
            }
        }
    }
    @IBAction func loadData(sender: UIButton) {
        if let managedContext = appDelegate.managedObjectContext {
            let fetchRequest = NSFetchRequest(entityName: "Location")
            let error = NSErrorPointer()
            let results = managedContext.executeFetchRequest(fetchRequest, error: error)
            let people = results as! [NSManagedObject]
            if let name: AnyObject = people.last?.valueForKey("name") {
                label.text = "\(name)"
            }
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
            println("missing image at: \(path)")
        }
        println("Loading image from path: \(path)")
        return image
        
    }
    
    @IBAction func LoadImageButton(sender: UIButton) {
        let imagePath = fileInDocumentsDirectory("9296984.png")
        let image = loadImageFromPath(imagePath)
        imageDisplay.image = UIImage(named: "9296984")
    }
    
    var imagePicker: UIImagePickerController!
    @IBAction func takePhoto(sender: UIButton) {
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        //imagePicker.sourceType = .Camera
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        imageDisplay.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    
    func saveName(name: String) {
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}