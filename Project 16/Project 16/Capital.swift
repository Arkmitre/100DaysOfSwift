//
//  Capital.swift
//  Project 16
//
//  Created by Alexander on 19/09/2024.
//  Copyright © 2024 Alexander Khorkov. All rights reserved.
//

import  MapKit
import UIKit

class Capital: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
}
