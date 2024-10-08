//
//  ViewController.swift
//  Project1
//
//  Created by Alexander on 16/08/2024.
//  Copyright © 2024 Alexander Khorkov. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Strom Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        loadData()
        
    }
    
    @objc func loadData() {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        DispatchQueue.global(qos: .userInitiated).async {
            let items = try! fm.contentsOfDirectory(atPath: path)
            
            for item in items {
                if item.hasPrefix("nssl") {
                        self.pictures.append(item)
                }
            }
            self.pictures.sort()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView , numberOfRowsInSection: Int) -> Int {
        return pictures.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        cell.imageView?.image = UIImage(named: pictures[indexPath.row])
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            vc.imageIndex = (indexPath.row, pictures.count)

            navigationController?.pushViewController(vc, animated: true)
        }
    }
        
}

