//
//  SavedMapsTableView.swift
//  BreadCrumbs
//
//  Created by JoeFrankMike on 12/20/15.
//  Copyright © 2015 Joseph Straceski. All rights reserved.
//

import UIKit

protocol SavedMapsTableViewDataSource: class
{
    func cellSelected(index : Int)
}

class SavedMapsTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
        var items: [String] = []
        var mapData: SavedMapsTableViewDataSource?
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.items.count
        }
        
        func append(s: String) {
            items.append(s)
        }
        
        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell")!
            cell.textLabel?.text = self.items[indexPath.row]
            return cell
        }
        
        func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            mapData!.cellSelected(indexPath.row)
        }
}
