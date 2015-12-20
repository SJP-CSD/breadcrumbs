//
//  SavedMapsTableViewController.swift
//  BreadCrumbs
//
//  Created by JoeFrankMike on 12/19/15.
//  Copyright © 2015 Joseph Straceski. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class SavedMapsTableViewController: UITableViewController, SavedMapsTableViewDataSource, MapViewDataSource {
    
    let tv = SavedMapsTableView()
    var cd: CoreDataTest? = nil
    var mapDataArray: [NSManagedObject] = []
//    var currentImage: UIImage? = nil
    var selectedIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate      =   tv
        tableView.dataSource    =   tv
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
        })
        let result = cd!.getData()
        mapDataArray = result
        tv.mapData = self
        
        for map in result
        {
            if let name: AnyObject = map.valueForKey("name") {
                tv.append(name as! String)
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                })
            }
            else
            {
                tv.append("?")
            }
        }
    }
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
    }
    
    func cellSelected(i: Int)
    {
        selectedIndex = i
        performSegueWithIdentifier("CellSegue", sender: nil)
    }
    
    func getMapData() -> LocationData?
    {
        let rawData = mapDataArray[selectedIndex!]
        if let rawLocation = rawData.valueForKey("data") {
            let location = NSKeyedUnarchiver.unarchiveObjectWithData(rawLocation as! NSData) as! [LocationData]
            if let data: LocationData = location.last {
                return data
            }
        }
        return nil
    }
    
    func getPhotoFromURL(photoURL: String) -> UIImage?
    {
        if let photo = cd?.loadImageFromPath(photoURL) {
            return photo
        }
        return nil
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "CellSegue":
                if let vc = segue.destinationViewController as? ImageViewController {
                    vc.mapDataSource = self
                }
            default: break
            }
        }
    }
    
    
    
}