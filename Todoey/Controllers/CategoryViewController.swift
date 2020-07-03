//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Deepak Rout on 6/26/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: SwipeTableViewController{
    
    let realm = try! Realm()
    
    var categories:  Results<Category>?
    
    //let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
        tableView.rowHeight = 80.0
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
        let cell  = super.tableView(tableView, cellForRowAt: indexPath)
        
        var category = Category()
        category = categories?[indexPath.row] as! Category
        cell.textLabel?.text = category.name
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    //MARK - Table view delegate method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoToItem", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC  = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            // TODO: What will happem when the user clicks the Add item
            
            let category = Category()
            category.name = textField.text ?? ""
            
            
            //self.categories.append(category)
            self.save(category)
            
            
            self.tableView.reloadData()
            //print("Success")
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Category"
            textField = alertTextField
            
        }
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
    }
    
    //MARK - Data Manipulation method
    fileprivate func save(_ category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving context \(error)")
        }
    }
    
    func loadCategories()  {
        categories =  realm.objects(Category.self)
        self.tableView.reloadData()
    }
    
    //MARK: Delete data for Swipe
    
    override func updateModel(at indexPath: IndexPath) {
        guard let categoryForDeletion = self.categories?[indexPath.row] else {
            return
        }
        do {
            try self.realm.write{
                self.realm.delete(categoryForDeletion)
            }
        } catch {
            print("Error  to delete categorty")
        }
        //tableView.reloadData()
    }
    
}

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {0
            if let result = self[i] as? T {
                array.append(result)
            }
        }
        return array
    }
}


