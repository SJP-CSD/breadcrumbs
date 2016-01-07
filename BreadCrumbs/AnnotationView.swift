//
//  AnnotationView.swift
//  BreadCrumbs
//
//  Created by Robotics Team on 12/15/15.
//  Copyright © 2015 Joseph Straceski. All rights reserved.
//

import Foundation
import MapKit
import UIKit

class AnnotationView: MKAnnotationView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame:CGRect) {
        super.init(frame: frame)
    }
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        if let mapAnnotation = self.annotation as? Annotation {
        image = (mapAnnotation.isPin) ? UIImage(named: "pin"):UIImage(named: "pathdot")
        }
    }
}