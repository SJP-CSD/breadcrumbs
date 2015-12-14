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

class CoreDataTest: UIViewController {
    
    
    @IBOutlet weak var text: UITextField!
    @IBOutlet weak var label: UILabel!
   
    
    
    @IBAction func saveData(sender: UIButton) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        if let managedContext = appDelegate.managedObjectContext
        {
            //2
            println("managedContext")
            let entity =  NSEntityDescription.entityForName("Location",
                inManagedObjectContext: managedContext)
            
            let person = NSManagedObject(entity: entity!,
                insertIntoManagedObjectContext: managedContext)
            
            //3
            person.setValue(text.text, forKey: "name")
            
            //4
            let error = NSErrorPointer()
            managedContext.save(error)
        }
    }
    @IBAction func clearData(sender: UIButton) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
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
        //1
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if let managedContext = appDelegate.managedObjectContext {
            
            //2
            let fetchRequest = NSFetchRequest(entityName: "Location")
            
            //3
            let error = NSErrorPointer()
            let results = managedContext.executeFetchRequest(fetchRequest, error: error)
            let people = results as! [NSManagedObject]
            if let name: AnyObject = people.last?.valueForKey("name") {
                label.text = "\(name)"
            }
        }
        
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