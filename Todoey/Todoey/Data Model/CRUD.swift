//
//  CRUD.swift
//  Todoey
//
//  Created by Likhitha Mandapati on 5/16/24.
//  Copyright © 2024 Angela Yu. All rights reserved.
//

import UIKit
import CoreData

class CRUD: NSObject {
    
    //MARK: - Category CRUD operations
    
    static func createCategory(newName:String) {
                //Get the managed context context from AppDelegate
                if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                    let managedContext = appDelegate.persistentContainer.viewContext
                    //Create a new empty record.
                    let categoryEntity = NSEntityDescription.entity(forEntityName: "Category", in: managedContext)!
                    //Fill the new record with values
                    let categoryObj = NSManagedObject(entity: categoryEntity, insertInto: managedContext)
                    categoryObj.setValue(newName, forKeyPath: "name")
                    
                    do {
                        //Save the managed object context
                        try managedContext.save()
                    } catch let error as NSError {
                        print("Could not create the new record! \(error), \(error.userInfo)")
                    }
                }
            }
        
        
        static func readCategory(name:String? = nil) -> [Category]? {
            //Get the managed context context from AppDelegate
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                let managedContext = appDelegate.persistentContainer.viewContext
                
                //Prepare the request of type NSFetchRequest  for the entity (SELECT * FROM)
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
                //Add a contition to the fetch request (WHERE)
                if let name = name {
                    fetchRequest.predicate = NSPredicate(format: "name CONTAINS[cd] %@", name)
                }
                //Add a sorting preference (ORDER BY)
                //fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "dueDate", ascending: true)]
                
                do {
                    let result = try managedContext.fetch(fetchRequest)
                    return result as? [Category]
                } catch let error as NSError {
                    print("Could not fetch the record! \(error), \(error.userInfo)")
                }
            }
            return nil
        }
        
        
        static func deleteCategory(category: Category) {
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                let managedContext = appDelegate.persistentContainer.viewContext
                
                managedContext.delete(category)
                
                do {
                    try managedContext.save()
                } catch let error as NSError {
                    print("Could not fetch the record to delete! \(error), \(error.userInfo)")
                }
            }
        }
    
        static func updateCategory(category: Category) {
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                let managedContext = appDelegate.persistentContainer.viewContext
                
                do {
                    try managedContext.save()
                } catch let error as NSError {
                    print("Could not fetch the record to delete! \(error), \(error.userInfo)")
                }
            }
        }

    
    //MARK: - Item CRUD operations
    
    static func createItem(title:String, done:Bool, date:Date, parentCategory: Category) {
                //Get the managed context context from AppDelegate
                if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                    let managedContext = appDelegate.persistentContainer.viewContext
                    //Create a new empty record.
                    let itemEntity = NSEntityDescription.entity(forEntityName: "Item", in: managedContext)!
                    //Fill the new record with values
                    let itemObj = NSManagedObject(entity: itemEntity, insertInto: managedContext)
                    itemObj.setValue(title, forKeyPath: "title")
                    itemObj.setValue(done, forKey: "done")
                    itemObj.setValue(date, forKey: "dateCreated")
                    itemObj.setValue(parentCategory, forKey: "parentCategory")
                    
                    do {
                        //Save the managed object context
                        try managedContext.save()
                    } catch let error as NSError {
                        print("Could not create the new record! \(error), \(error.userInfo)")
                    }
                }
            }
    
    
        static func readItem(title:String? = nil, parentCategory: Category? = nil) -> [Item]? {
            //Get the managed context context from AppDelegate
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                let managedContext = appDelegate.persistentContainer.viewContext
                
                //Prepare the request of type NSFetchRequest  for the entity (SELECT * FROM)
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
                
                var predicates: [NSPredicate] = []
                //Add a contition to the fetch request (WHERE)
                if let title = title {
                    fetchRequest.predicate = NSPredicate(format: "name CONTAINS[cd] %@", title)
                }
                
                if let parentCategory = parentCategory {
                    predicates.append(NSPredicate(format: "parentCategory == %@", parentCategory))
                }
                
                if !predicates.isEmpty {
                    fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
                }
                
                //Add a sorting preference (ORDER BY)
                fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "dateCreated", ascending: true)]
                
                do {
                    let result = try managedContext.fetch(fetchRequest)
                    return result as? [Item]
                } catch let error as NSError {
                    print("Could not fetch the record! \(error), \(error.userInfo)")
                }
            }
            return nil
        }
    
    
        static func deleteItem(item: Item) {
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                let managedContext = appDelegate.persistentContainer.viewContext
                
                managedContext.delete(item)
                
                do {
                    try managedContext.save()
                } catch let error as NSError {
                    print("Could not fetch the record to delete! \(error), \(error.userInfo)")
                }
            }
        }
    
    
        static func updateItem(item: Item) {
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                let managedContext = appDelegate.persistentContainer.viewContext
                
                do {
                    try managedContext.save()
                } catch let error as NSError {
                    print("Could not fetch the record to delete! \(error), \(error.userInfo)")
                }
            }
        }
}
