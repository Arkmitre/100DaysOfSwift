//
//  WebView.swift
//  Project 16
//
//  Created by Alexander on 19/09/2024.
//  Copyright © 2024 Alexander Khorkov. All rights reserved.
//

import UIKit
import WebKit

class WebView: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    var pinTitle: String?
    
    
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(string: "https://en.wikipedia.org/wiki/" + pinTitle!) else {
            let url = "https://en.wikipedia.org"
            return
        }
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }


}
