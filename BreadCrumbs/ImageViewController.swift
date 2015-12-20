//
//  ImageViewController.swift
//  BreadCrumbs
//
//  Created by JoeFrankMike on 12/20/15.
//  Copyright © 2015 Joseph Straceski. All rights reserved.
//

import UIKit

protocol MapViewDataSource: class
{
    func getMapData() -> LocationData?
    func getPhotoFromURL(path: String) -> UIImage?
}

class ImageViewController: UIViewController {

    var image: UIImage?
    var mapDataSource: MapViewDataSource?
    @IBOutlet weak var imageview: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mapData = mapDataSource!.getMapData()
        if let realMapData = mapData {
            if let photoURL = realMapData.photos.first {
                if let photo = mapDataSource!.getPhotoFromURL(photoURL) {
                    imageview.image = photo
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
