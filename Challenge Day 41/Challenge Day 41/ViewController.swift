//
//  ViewController.swift
//  Challenge Day 41
//
//  Created by Alexander on 21/08/2024.
//  Copyright © 2024 Alexander Khorkov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var lifeLabels: [UILabel]!
    @IBOutlet var riddleLabel: UILabel!
    @IBOutlet var usedCharactersCollection: UICollectionView!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var answerTextField: UITextField!
    @IBAction func guessCharacter(_ sender: UIButton) { playerGuessCharacter(answerTextField.text) }
    
    
    var playerLifes = 6  // + 0 so 7
    var round = 0
    var riddles = [String]()
    var riddle = [Character]()
    var visibleRiddle: [Character] = ["?","?","?","?","?","?","?"] {
        didSet {
            if !visibleRiddle.contains("?") {
                showGameWin()
            }
        }
    }
    var usedCharacters = [Character]()
    var score = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "Score: \(score)"
        riddleLabel.text = String(visibleRiddle)
        loadRiddle()
    }
    
    @objc func loadRiddle() {
        
        DispatchQueue.global(qos: .background).async {
            if let riddleFileURL = Bundle.main.url(forResource: "Riddles", withExtension: "txt") {
                if let riddlesContents = try? String(contentsOf: riddleFileURL) {
                    self.riddles = riddlesContents.components(separatedBy: "\n")
                    self.riddles.shuffle()
                    
                    DispatchQueue.main.async {
                        self.riddle = Array(self.riddles[self.round].lowercased())
                    }
                }
            }
        }
    }
    
    @objc func playerGuessCharacter(_ answer: String?) {
        var correctAnswer = false
        guard let answer = answer?.first else { /* Error */ return }
        
        if usedCharacters.contains(answer) {
            showErrorUsedCharacter(answer)
            answerTextField.text = ""
            return
        } else {
            usedCharacters.append(answer)
        }
        for i in 0..<7 {
            if answer == riddle[i] {
                visibleRiddle[i] = answer
                riddleLabel.text = String(visibleRiddle)
                correctAnswer = true
            }
        }
        if correctAnswer {
            showUserCorrectAnswer()
        } else {
            showUserWrongAnswer()
        }
        answerTextField.text = ""
    }
    
    func loseLife(action: UIAlertAction) {
        lifeLabels[playerLifes].text = "💀"
        if playerLifes == 0 { showGameOver() }
        playerLifes -= 1
    }
    
    func showGameWin() {
        let ac = UIAlertController(title: "You got it!", message: "", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Next riddle?", style: .default, handler: newGame))
        present(ac, animated: true)
    }
    
    func showUserCorrectAnswer() {
        let ac = UIAlertController(title: "Correct", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(ac, animated: true)
    }
    
    func showUserWrongAnswer() {
        let ac = UIAlertController(title: "No such character in riddle", message: "Wrong answers have a price -1 life", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: loseLife))
        present(ac, animated: true)
    }
    
    func showErrorUsedCharacter(_ character: Character) {
        let ac = UIAlertController(title: "\(character) already used", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(ac, animated: true)
    }
    
    func showGameOver() {
        let ac = UIAlertController(title: "GAME OVER", message: "You lost all lifes", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Try again?", style: .default, handler: newGame))
        present(ac, animated: true)
    }
    
    func outOfRiddles() {
        let ac = UIAlertController(title: "Sorry", message: "Riddles out of stock", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Leave", style: .cancel))
        ac.addAction(UIAlertAction(title: "Start game with same words?", style: .default, handler: startGameAgain))
        present(ac, animated: true)
    }
    
    func startGameAgain(action: UIAlertAction) {
        loadRiddle()
    }
    
    func newGame(action: UIAlertAction) {
        score += playerLifes
        scoreLabel.text = "Score: \(score)"
        round += 1
        usedCharacters.removeAll()
        if riddles.count < round - 1 { outOfRiddles() }
        riddle = Array(riddles[round].lowercased())
        visibleRiddle = ["?","?","?","?","?","?","?"]
        riddleLabel.text = String(visibleRiddle)
        for i in 0...6 {
            lifeLabels[i].text = "❤️"
        }
    }
}



extension MutableCollection {
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            let i = index(firstUnshuffled, offsetBy: d)
            swapAt(firstUnshuffled, i)
        }
    }
}
