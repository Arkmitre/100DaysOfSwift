//
//  ViewController.swift
//  Project 12
//
//  Created by Alexander on 26/08/2024.
//  Copyright © 2024 Alexander Khorkov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        
        defaults.set(25, forKey: "Age")
        defaults.set(true, forKey: "UserFaceID")
        defaults.set(CGFloat.pi, forKey: "Pi")
        
        defaults.set("Alexander Khorkov", forKey: "Name")
        defaults.set(Date(), forKey: "LastRun")
        
        let array = ["Hello", "World"]
        defaults.set((array), forKey: "SavedArray")
        
        let dict = ["Name": "Alexander", "Country": "Russia"]
        defaults.set(dict, forKey: "SavedDictionary")
        
        let savedInteger = defaults.integer(forKey: "Age")
        let savedBoolen = defaults.bool(forKey: "UserFaceID")
        
        let savedArray = defaults.object(forKey: "SavedArray") as? [String] ?? [String]()
        let savedDictionary = defaults.object(forKey: "SavedDictionary") as? [String: String] ?? [String: String]()
        

    }



}

