//
//  ViewController.swift
//  1-2-3-Compared
//
//  Created by Alexander on 17/08/2024.
//  Copyright © 2024 Alexander Khorkov. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasSuffix("3x.png") {
                pictures.append(item)
            }
        }
        pictures.sort()
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return pictures.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(5)
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        let countryName = pictures[indexPath.section].components(separatedBy: "@")
        cell.textLabel?.text = countryName[0].uppercased()
        cell.imageView?.image = UIImage(named: pictures[indexPath.section])
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        //cell.clipsToBounds = true
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.section]
            vc.imageName = pictures[indexPath.section].components(separatedBy: "@")[0].uppercased()
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}
