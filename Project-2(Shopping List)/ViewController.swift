//
//  ViewController.swift
//  Project-2(Shopping List)
//
//  Created by Sheena on 11/02/22.
//

import UIKit

class ViewController: UITableViewController {
    
    var lists = [String]()
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        defaults.array(forKey: "ShoppingList")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(clear))
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        navigationItem.rightBarButtonItems = [shareButton, addButton]
        
        if let shoppingList = defaults.array(forKey: "ShoppingList") as? [String] {
            lists = shoppingList
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "List", for: indexPath)
        cell.textLabel?.text = lists[indexPath.row]
        
        return cell
    }
    
    @objc func addTapped() {
        
        let alert = UIAlertController(title: "What do you want to buy today?", message: "Add item to the list", preferredStyle: .alert)
        alert.addTextField()
        let action = UIAlertAction(title: "Add", style: .default) { action in
            guard let item = alert.textFields?[0].text else{return}
            self.addItem(item)
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    @objc func clear() {
        lists.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    @objc func shareTapped() {
        let text = "Item to buy:"
        let item = lists.joined(separator: "\n")
        
        let vc = UIActivityViewController(activityItems: [text,item], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItems![0]
        
        self.present(vc, animated: true, completion: nil)
    }
    
    func addItem(_ item: String) {
        if !item.isEmpty {
            lists.insert(item, at: 0)
            defaults.set(lists, forKey: "ShoppingList")
        }
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }


}

