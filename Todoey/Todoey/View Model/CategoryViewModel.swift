//
//  CategoryViewModel.swift
//  Todoey
//
//  Created by Likhitha Mandapati on 5/16/24.
//  Copyright © 2024 Angela Yu. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CategoryViewModel {
    
    var categories: [Category] = []
    
    init() {
        loadCategories()
    }
    
    func createCategory(name: String) {
        CRUD.createCategory(newName: name)
        
        loadCategories()
    }
    
    func updateCategory(category: Category) {
        CRUD.updateCategory(category: category)
    }
    
    func deleteCategory(at indexPath: IndexPath) {
        let category = categories[indexPath.row]
        categories.remove(at: indexPath.row)
        CRUD.deleteCategory(category: category)
    }
    
    func loadCategories() {
        categories = CRUD.readCategory() ?? []
    }
}
