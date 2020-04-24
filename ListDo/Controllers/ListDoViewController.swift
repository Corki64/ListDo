//
//  ViewController.swift
//  ListDo
//
//  Created by user162511 on 3/30/20.
//  Copyright © 2020 lac0084. All rights reserved.
//

import UIKit
import CoreData

class ListDoViewController: UITableViewController {

    
    var itemArray = [Item]()
    
    // Will create an instance of the persistentContainer (sqlite db) and retrieve the context of the entry in the db.
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
//    var itemArray = ["Learn to program", "Do not catch Covid-19", "Go on vacation"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        loadItems()
    }
    
    // MARK: - Table View Data Source Methods
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListDoCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        return cell
    }
    
    // MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        // Will outright delete any item that is clicked
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)

        
        // Changes the checkmark property to be the opposite of the current value.
//        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
        // This will only animate the cell when it is initially clicked but it will return to normal afterwards.
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Do", message:"", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Do", style: .default) { (action) in
            
            // Will then let assign the value of the context to the item we adding
            let newItem = Item(context: self.context)
            
            // Assigns the text to the do list.
            newItem.title = textField.text!
            // Initializes status of do list boolean (done or not done) to false
            newItem.done = false
            // Adds item to the end of array
            self.itemArray.append(newItem)
            self.saveItems()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Do"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    // Will save items using our context area to our sqlite db.
    func saveItems() {
        do {
            try self.context.save()
        } catch {
            print("Error saving context. \(error)")
        }
        self.tableView.reloadData()
    }
    
    // Will load items from our sqlite db.
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()) {
        do {
            itemArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context. \(error)")
        }
        tableView.reloadData()
    }
}


//MARK: - Search bar methods

//extension ListDoViewController: UISearchBarDelegate {
//
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//
//        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
//        loadItems(with: request)
//    }
//
//}

    // Functions below are for saving and retrieving items through a custome plist - for this project we have progressed to using a core data model (sqlite db).
    
//    // Function will encode an object to save on a plist // Will also reload tableView data for screen update.
//    func saveItems() {
//        let encoder = PropertyListEncoder()
//
//        do {
//            let data = try encoder.encode(itemArray)
//            try data.write(to: dataFilePath!)
//        } catch {
//            print("Error encoding item array, \(error)")
//        }
//        tableView.reloadData()
//    }
//
//
//    func loadItems() {
//        if let data = try? Data(contentsOf: dataFilePath!) {
//            let decoder = PropertyListDecoder()
//            do {
//                itemArray = try decoder.decode([Item].self, from: data)
//            } catch {
//                print("Error decoding item array, \(error)")
//            }
//        }

    
    
