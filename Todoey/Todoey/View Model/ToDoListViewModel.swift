//
//  ToDoListViewModel.swift
//  Todoey
//
//  Created by Likhitha Mandapati on 5/16/24.
//  Copyright © 2024 Angela Yu. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ToDoListViewModel {
    
    var itemArray : [Item] = []
    var selectedCategory: Category?
    
    init(category: Category){
        self.selectedCategory = category
        loadItems()
    }
    
    func createItem(title: String, done: Bool, date: Date) {
        if let currentCategory = selectedCategory {
            CRUD.createItem(title: title, done: done, date: date, parentCategory: currentCategory)
            loadItems()
        }
    }
    
    func deleteItem(at indexPath: IndexPath) {
        let item = itemArray[indexPath.row]
        itemArray.remove(at: indexPath.row)
        CRUD.deleteItem(item: item)
        loadItems()
    }
    
    func updateItem(item: Item) {
        CRUD.updateItem(item: item)
        loadItems()
    }
    
    func loadItems(title: String? = nil) {
        if let currentCategory = selectedCategory {
            itemArray = CRUD.readItem(title: title, parentCategory: currentCategory) ?? []
        }
    }
}
