//
//  ViewController.swift
//  Project2
//
//  Created by Alexander on 16/08/2024.
//  Copyright © 2024 Alexander Khorkov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var label1: UILabel!
    @IBOutlet var label2: UILabel!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var roundCount = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshScoreAndRound()
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.purple.cgColor
        button2.layer.borderColor = UIColor.purple.cgColor
        button3.layer.borderColor = UIColor.purple.cgColor
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        askQuestion()
        
    }
    
    func refreshScoreAndRound() {
        label1.text = "Your Score: \(score)"
        label2.text = "Round: \(roundCount)"
    }
    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle() //Not implemented in Swift 4.0 so use extension
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        correctAnswer = Int(arc4random_uniform(2))
        title = countries[correctAnswer].uppercased()
    }
    func finalScore(action: UIAlertAction! = nil) {
        if roundCount == 10 {
            let final = UIAlertController(title: "Congrats", message: "Your finale score is \(score)", preferredStyle: .alert)
            final.addAction(UIAlertAction(title: "Continue?", style: .default, handler: askQuestion))
            present(final, animated: true)
            score = 0
            roundCount = 0
            refreshScoreAndRound()
        }
    }
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong, its \(countries[sender.tag].uppercased()) flag"
            score -= 1
        }
        roundCount += 1

        let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: roundCount == 10 ? finalScore : askQuestion))
        present(ac, animated: true)
        refreshScoreAndRound()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

extension Array {
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            let d: Int = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            let i = index(firstUnshuffled, offsetBy: d)
            swapAt(firstUnshuffled, i)
        }
    }
}

