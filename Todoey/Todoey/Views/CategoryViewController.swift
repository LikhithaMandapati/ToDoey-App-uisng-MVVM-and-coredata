//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Likhitha Mandapati on 5/7/2024.
//  Copyright © 2017 Angela Yu. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: SwipeTableViewController {
    
    var viewModel = CategoryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadCategories()
        tableView.reloadData()
        tableView.rowHeight = 80.0
    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.textLabel?.text = viewModel.categories[indexPath.row].name
        return cell
    }

    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = viewModel.categories[indexPath.row]
        }
    }
    
    
    //MARK: - Delete data from Swipe
    
    override func updateModel(at indexPath: IndexPath) {
        viewModel.deleteCategory(at: indexPath)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    
    //MARK: - Add New Categories

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            if let name = textField.text, !name.isEmpty {
                self.viewModel.createCategory(name: name)
                self.tableView.reloadData()
            }
        }
        alert.addAction(action)
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add a new category"
        }
        present(alert, animated: true, completion: nil)
    }
}


