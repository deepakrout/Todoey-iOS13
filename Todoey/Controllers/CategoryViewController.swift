//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Deepak Rout on 6/26/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categories = [`Category`]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        loadCategories()
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell",for: indexPath)
        let category = categories[indexPath.row]
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
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            // TODO: What will happem when the user clicks the Add item
            
            let category = Category(context: self.context)
            category.name = textField.text ?? ""
            
            
            self.categories.append(category)
            self.saveCategories()
            
            
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
    fileprivate func saveCategories() {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
    }
    
    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        
        do {
            categories = try context.fetch(request)
            self.tableView.reloadData()
        } catch {
            print("Error fetching data from context \(error)")
        }
        
        
    }
    
}
