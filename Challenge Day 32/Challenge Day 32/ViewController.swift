//
//  ViewController.swift
//  Challenge Day 32
//
//  Created by Alexander on 19/08/2024.
//  Copyright © 2024 Alexander Khorkov. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var shoppingList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(promtForItem))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Clear list", style: .plain, target: self, action: #selector(clearShoppingList))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
    
    @objc func clearShoppingList() {
        shoppingList.removeAll()
        tableView.reloadData()
    }
    @objc func promtForItem() {
        let ac = UIAlertController(title: "Add item to shopping list", message: nil, preferredStyle: .alert)
        ac.addTextField()

        let submitAction = UIAlertAction(title: "Add", style: .default) { [weak self, weak ac] action in
            guard let newItem = ac?.textFields?[0].text else { return }
            self?.addItem(newItem)
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    func addItem(_ item: String) {
        if item.isEmpty {
            emptyItemError()
            return
        }
        shoppingList.append(item)
        let indexPath = IndexPath(row: shoppingList.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
//        tableView.reloadData()
//        let indexPath = IndexPath(row: 0, section: 0)
//        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    func emptyItemError() {
        let ac = UIAlertController(title: "Can't add empty Item in list", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel ))
        present(ac, animated: true)
    }

}

