//
//  DetailViewController.swift
//  Project1
//
//  Created by Alexander on 16/08/2024.
//  Copyright © 2024 Alexander Khorkov. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var viewsCount: UILabel!
    
    var selectedImage: String?
    var imageIndex: (Int, Int)?
    var viewCount = [Int]()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if viewCount.isEmpty { viewCount = [Int](repeating: 0, count: imageIndex!.1) }
        read()
        
        
        if let imageIndex = imageIndex {
            title = "Picture \(imageIndex.0 + 1) of \(imageIndex.1)"
            viewsCount.text = "Views: \(viewCount[imageIndex.0])"
        }
        navigationItem.largeTitleDisplayMode = .never
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
        viewCount[imageIndex!.0] += 1
        viewsCount.text = "Views: \(viewCount[imageIndex!.0])"
        save()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    func read() {
        DispatchQueue.global(qos: .userInteractive).async {
            let defaults = UserDefaults.standard
            if let savedViewsCount = defaults.object(forKey: "viewsCount") as? Data {
                let jsonDecoder = JSONDecoder()
                do {
                    self.viewCount = try jsonDecoder.decode([Int].self, from: savedViewsCount)
                    DispatchQueue.main.async {
                        self.viewsCount.text = "Views: \(self.viewCount[self.imageIndex!.0])"
                    }
                } catch {
                    DispatchQueue.main.async { print("Failed to load viewsCount") }
                }
                
            }
        }
    }
    
    func save() {
        DispatchQueue.global(qos: .background).async {
            let jsonEncoder = JSONEncoder()
            
            if let savedData = try? jsonEncoder.encode(self.viewCount) {
                let defaults = UserDefaults.standard
                defaults.set(savedData, forKey: "viewsCount")
            } else {
                print("Failed to load viewsCount")
            }
        }
    }
}
