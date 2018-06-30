//
//  ViewController.swift
//  Todeey
//
//  Created by Surya Kona on 25/06/2018.
//  Copyright © 2018 hive. All rights reserved.
//

import UIKit

class ToDoListController: UITableViewController {
    
    var items = [Item]()
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let item1 = Item()
        item1.title = "Buy stuff"
        
        let item2 = Item()
        item2.title = "Sell stuff"
        
        let item3 = Item()
        item3.title = "Go somewhere"
        
        items.append(item1)
        items.append(item2)
        items.append(item3)
    
        if let itemArray = defaults.array(forKey: "ToDoItemCell") as? [Item] {
            items = itemArray
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK - TableView Data Source methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].title
        
        cell.accessoryType = items[indexPath.row].done == true ? .checkmark : .none
        
        return cell
    }

    //MARK - TableView Delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        items[indexPath.row].done = !items[indexPath.row].done
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addButtonPreseed(_ sender: UIBarButtonItem) {
        
        var newTodoeyItem = UITextField()
        
        let alert = UIAlertController(title: "Add new Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            let item = Item()
            item.title = newTodoeyItem.text!
            
            self.items.append(item)
            self.defaults.set(self.items, forKey: "ToDoListItems")
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "New Todoey Item"
            newTodoeyItem = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
        
    }
}

