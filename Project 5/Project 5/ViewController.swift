//
//  ViewController.swift
//  Project 5
//
//  Created by Alexander on 18/08/2024.
//  Copyright © 2024 Alexander Khorkov. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var allWords = [String]()
    var usedWords = [String]()
    var currentWord = [""]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        read()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promtForAnswer))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(startGame))
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        if allWords.isEmpty {
            allWords = ["silkworm"]
        }
        if title?.isEmpty ?? true {
            startGame()
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    @objc func startGame() {
        title = allWords[Int(arc4random_uniform(UInt32(allWords.count)))]
        usedWords.removeAll(keepingCapacity: true)
        currentWord[0] = title!
        save()
        tableView.reloadData()
    }
    func submit(_ answer: String) {
        let lowerAnswer = answer.lowercased()
        
        if isPossible(word: lowerAnswer) {
            if isOriginal(word: lowerAnswer) {
                if isReal(word: lowerAnswer) {
                    usedWords.insert(lowerAnswer, at: 0)
                    currentWord[0] = title!
                    save()
                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)
                    
                    return
                } else { showErrorMessage(title: "Word not recognized", message: "You can't just make them up, you know!") }
            } else { showErrorMessage(title: "Word used already", message: "Be more original!") }
        } else {
            guard let title = title?.lowercased() else { return }
            showErrorMessage(title: "Word not possible", message: "You can't spell that word from \(title)")
        }
    }
    @objc func promtForAnswer() {
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    func isPossible(word: String) -> Bool {
        guard var tempWord = title?.lowercased() else { return false }
        
        for letter in word {
            if let position = tempWord.index(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
        return true
    }
    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        if word.count < 3 { return false }
        if word == title { return false }
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    func showErrorMessage(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func read() {
        DispatchQueue.global(qos: .userInteractive).async {
            let defaults = UserDefaults.standard
            let jsonDecoder = JSONDecoder()
            if let savedTitle = defaults.object(forKey: "currentWord") as? Data {
                DispatchQueue.main.async {
                    do {
                        self.title = try jsonDecoder.decode([String].self, from: savedTitle).first
                    } catch {
                        print("Failed to load savedTitle") }
                }
            }
            if let savedWords = defaults.object(forKey: "usedWords") as? Data {
                DispatchQueue.main.async {
                    do {
                        self.usedWords = try jsonDecoder.decode([String].self, from: savedWords)
                    } catch { print("Failed to load savedWords") }
                
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func save() {
        DispatchQueue.global(qos: .background).async {
            let jsonEncoder = JSONEncoder()
            let defaults = UserDefaults.standard
            if let savedTitle = try? jsonEncoder.encode(self.currentWord) {
                defaults.set(savedTitle, forKey: "currentWord")
            } else {
                print("Failed to save savedTitle")
            }
            if let savedWords = try? jsonEncoder.encode(self.usedWords) {
                defaults.set(savedWords, forKey: "usedWords")
            } else {
                print("Failed to save savedWords")
            }
        }
    }



}

