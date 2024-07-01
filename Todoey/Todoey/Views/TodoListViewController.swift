//
//  ViewController.swift
//  Todoey
//
//  Created by Likhitha Mandapati on 5/7/2024.
//  Copyright © 2017 Angela Yu. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: SwipeTableViewController {
    
    var viewModel: ToDoListViewModel!
    
    var selectedCategory: Category? {
        didSet {
            viewModel = ToDoListViewModel(category: selectedCategory!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.reloadData()
        tableView.rowHeight = 80.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = selectedCategory!.name
    }
    
    //MARK: - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        let item = viewModel.itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.itemArray[indexPath.row]
        item.done = !item.done
        viewModel.updateItem(item: item)
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            if let newItemTitle = textField.text {
                self.viewModel.createItem(title: newItemTitle, done: false, date: Date())
                self.tableView.reloadData()
            }
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Model Manupulation Methods
    
    func loadItems(title: String? = nil) {
        viewModel.loadItems(title: title)
        tableView.reloadData()
    }
    
    override func updateModel(at indexPath: IndexPath) {
        viewModel.deleteItem(at: indexPath)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}

//MARK: - Search bar methods

extension TodoListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        loadItems(title: searchBar.text)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
        
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}








