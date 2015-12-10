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
        
    }
    @IBAction func loadData(sender: UIButton) {
        
    }
    
    func saveName(name: String) {
        //1
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let entity =  NSEntityDescription.entityForName("Location",
            inManagedObjectContext:managedContext)
        
        let person = NSManagedObject(entity: entity!,
            insertIntoManagedObjectContext: managedContext)
        
        //3
        person.setValue(name, forKey: "name")
        
        //4
        do {
        try managedContext.save()
        //5
        people.append(person)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
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