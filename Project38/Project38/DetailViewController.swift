//
//  DetailViewController.swift
//  Project38
//
//  Created by Александр on 20.09.2025.
//

import UIKit
import WebKit
import SafariServices

class DetailViewController: UIViewController, WKNavigationDelegate {
    @IBOutlet var detailLabel: UILabel!
    
    var detailItem: Commit?
    var webView: WKWebView!
    
//    override func loadView() {
//        let configuration = WKWebViewConfiguration()
//        let preferences = WKWebpagePreferences()
//        preferences.allowsContentJavaScript = true
//        configuration.defaultWebpagePreferences = preferences
//        
//        webView = WKWebView(frame: view.bounds, configuration: configuration)
//        webView.customUserAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Mobile/15E148 Safari/604.1"
//        
//        webView.navigationDelegate = self
//        view = webView
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show in GitHub", style: .plain, target: self, action: #selector(showCommitInGitHub))
        
//        if let detail = self.detailItem {
//            //let url = URL(string: "https://support.apple.com/ru-ru")!
//            print(detail.url)
//            let url = URL(string: detail.url)!
//            print(url)
//            webView.load(URLRequest(url: url))
//            webView.allowsBackForwardNavigationGestures = true
//        }
        
        
        if let detail = self.detailItem {
            detailLabel.text = detail.message
            //navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Commit 1 /\(detail.author.commits.count)", style: .plain, target: self, action: #selector(showAuthorCommits))
        }

    }
    
    @objc func showCommitInGitHub() {
        
        if let detail = self.detailItem {
            //let url = URL(string: "https://support.apple.com/ru-ru")!
            print(detail.url)
            let safariVC = SFSafariViewController(url: URL(string: detail.url)!)
            present(safariVC, animated: true)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
//extension DetailViewController: SFSafariViewControllerDelegate {
//    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
//        .dismiss(animated: true)
//    }
//}
