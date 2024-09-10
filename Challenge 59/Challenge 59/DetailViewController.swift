//
//  DetailViewController.swift
//  Challenge 59
//
//  Created by Alexander on 04/09/2024.
//  Copyright © 2024 Alexander Khorkov. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var capital: UILabel!
    @IBOutlet var population: UILabel!
    @IBOutlet var size: UILabel!
    @IBOutlet var currency: UILabel!
    
    var country: Country?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard  let country = country else { return }
        print(country)
        navigationItem.title = country.title
        capital.text = "Capital: \(country.capital)"
        population.text = "Population: \(country.population)"
        size.text = "Size: \(country.size)"
        currency.text = "Currency: \(country.currency)"
    }
}
