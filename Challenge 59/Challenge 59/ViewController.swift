//
//  ViewController.swift
//  Challenge 59
//
//  Created by Alexander on 04/09/2024.
//  Copyright © 2024 Alexander Khorkov. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var countries = [Country]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.fetchJSON()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    
    @objc func fetchJSON() {
        if let url = Bundle.main.url(forResource: "Countries", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Countries.self, from: data)
                countries = jsonData.country
                return
            } catch {
                print("Can't load JSON")
            }
        }
        return
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Country", for: indexPath)
        let country = countries[indexPath.row]
        cell.textLabel?.text = country.title
        cell.textLabel?.textAlignment = .center
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.country = countries[indexPath.row]

            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

