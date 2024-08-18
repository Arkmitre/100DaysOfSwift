//
//  ViewController.swift
//  Project 4
//
//  Created by Alexander on 18/08/2024.
//  Copyright © 2024 Alexander Khorkov. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UITableViewController, WKNavigationDelegate{
    var webView: WKWebView!
    var progressView: UIProgressView!
    var websites = ["apple.com", "hackingwithswift.com", "e1.ru", "google.com"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return websites.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(5)
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Site", for: indexPath)
        cell.textLabel?.text = websites[indexPath.section]
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "WebView") as? WebView {
            vc.site = websites[indexPath.section]
            vc.allowedSites = websites
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}

