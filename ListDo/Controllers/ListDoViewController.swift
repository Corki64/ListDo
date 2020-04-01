//
//  ViewController.swift
//  ListDo
//
//  Created by user162511 on 3/30/20.
//  Copyright © 2020 lac0084. All rights reserved.
//

import UIKit

class ListDoViewController: UITableViewController {

    
    var itemArray = [Item]()
//    var itemArray = ["Learn to program", "Do not catch Covid-19", "Go on vacation"]
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let newItem1 = Item()
        newItem1.title = "Learn to Program"
        itemArray.append(newItem1)
        
        let newItem2 = Item()
        newItem2.title = "Do not catch Covid-19"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Go on Vacation!"
        itemArray.append(newItem3)
        
        itemArray.append(newItem3)
                itemArray.append(newItem3)
                itemArray.append(newItem3)
                itemArray.append(newItem3)
                itemArray.append(newItem3)
                itemArray.append(newItem3)
                itemArray.append(newItem3)
                itemArray.append(newItem3)
                itemArray.append(newItem3)
                itemArray.append(newItem3)
                itemArray.append(newItem3)
                itemArray.append(newItem3)
                itemArray.append(newItem3)
                itemArray.append(newItem3)
                itemArray.append(newItem3)
                itemArray.append(newItem3)
                itemArray.append(newItem3)
                itemArray.append(newItem3)
                itemArray.append(newItem3)
        
        
        
//        if let items = defaults.array(forKey: "DoListArray") as? [String] {
//            itemArray = items
//        }
        
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
        
        // Changes the checkmark property to be the opposite of the current value.
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        
        // This will only animate the cell when it is initially clicked but it will return to normal afterwards.
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Do", message:"", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Do", style: .default) { (action) in
            
            
            // What will happen once user clicks Add Item button on UIAlert
            // This will append the data entered into my array
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.defaults.setValue(self.itemArray, forKey: "DoListArray")
            
            // Once data has been added to the array we will need to reload the data to display on our tableview
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Do"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    

}






