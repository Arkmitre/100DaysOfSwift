//
//  WebView.swift
//  Project 4
//
//  Created by Alexander on 18/08/2024.
//  Copyright © 2024 Alexander Khorkov. All rights reserved.
//

import UIKit
import WebKit

class WebView: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    var progressView: UIProgressView!
    var site: String?
    var allowedSites: [String] = []

    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        progressView.progressTintColor = UIColor.red
        let progressButton = UIBarButtonItem(customView: progressView)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        let forward = UIBarButtonItem(barButtonSystemItem: .redo, target: webView, action: #selector(webView.goForward))
        let back = UIBarButtonItem(barButtonSystemItem: .undo, target: webView, action: #selector(webView.goBack))
        
        toolbarItems = [progressButton, spacer, forward, back, refresh]
        navigationController?.isToolbarHidden = false
        let url = URL(string: "https://" + site!)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)

    }
    @objc func openTapped() {
        let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: site, style: .default, handler: openPage))
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    func openPage(action: UIAlertAction) {
        let url = URL(string: "https://" + action.title!)!
        webView.load(URLRequest(url: url))
    }
    func websiteDontAllowed() {
        let ac = UIAlertController(title: "This website not secure", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        
        if let host = url?.host {
            for allowed in allowedSites {
                if host.contains(allowed) {
                    decisionHandler(.allow)
                    return
                }
            }
        } else { websiteDontAllowed() }
        
        decisionHandler(.cancel)
            
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
}
