//
//  CategoryTableViewController.swift
//  ListDo
//
//  Created by user162511 on 4/23/20.
//  Copyright © 2020 lac0084. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {
    
    
    var categoryArray = [Category]()
    

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()

    }
    
    //MARK: - TableView DataSource Methods - Information to dispaly in our category tableView
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categoryArray[indexPath.row].name
//        let category = categoryArray[indexPath.row].name
//        cell.textLabel?.text = category.name
        return cell
    }
    
    
    //MARK: - TableView Data Manip Methods -- User interaction

    @IBAction func addButton(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "List of Do's", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Do's", style: .default) { (action) in
            
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            
            self.categoryArray.append(newCategory)
            self.saveCategories()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new List of Do's"
            textField = alertTextField
        
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: -  Utility methods - used to save and load data through our context
    
    func saveCategories() {
        do {
            try self.context.save()
        } catch {
            print("Error saving list of do's in context. \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadCategories() {
        
        // header for use in extension - implementation of searchBar func
//    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        let request  : NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            categoryArray = try context.fetch(request)
        } catch {
            print("Error fetching categorie list from context. \(error)")
        }
        tableView.reloadData()
    }
    

    

    
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItemList", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ListDoViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }

    
}
