//
//  Person.swift
//  Project 10
//
//  Created by Alexander on 23/08/2024.
//  Copyright © 2024 Alexander Khorkov. All rights reserved.
//

import UIKit

class Person: NSObject, Codable {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
