//
//  ViewController.swift
//  ListDo
//
//  Created by user162511 on 3/30/20.
//  Copyright © 2020 lac0084. All rights reserved.
//

import UIKit
import RealmSwift


class ListDoViewController: UITableViewController {

    var itemArray: Results<Item>?
    let realm = try! Realm()
    
    
    var selectedCategory : Category? {
        didSet {
            loadItems()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
        tableView.separatorStyle = .none
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//
//        title = selectedCategory?.name
//
//        guard let colourHex = selectedCategory?.colour else { fatalError() }
//
//        updateNavBar(withHexCode: colourHex)
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//
//        updateNavBar(withHexCode: "1D9BF6")
//
//    }
    
//    //MARK: - NavBar Setup Methods
//    func updateNavBar(withHexCode colourHexCode: String){
//
//        guard let navBar = navigationController?.navigationBar else {fatalError("Navigation controller does not exist.")}
//
//        guard let navBarColour = UIColor(hexString: colourHexCode) else { fatalError()}
//
//        navBar.barTintColor = navBarColour
//
//        navBar.tintColor = ContrastColorOf(navBarColour, returnFlat: true)
//
//        navBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : ContrastColorOf(navBarColour, returnFlat: true)]
//
//        searchBar.barTintColor = navBarColour
//
//    }
    
    
    
    
    // MARK: - Table View Data Source Methods
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListDoCell", for: indexPath)

        if let item = itemArray?[indexPath.row] {
            do {
                try realm.write {
                    item.done = !item.done
                }
            } catch {
                print("Error saving done status, \(error)")
            }
        }
        return cell
    }
    
    // MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = itemArray?[indexPath.row] {
            do {
                try realm.write {
                    item.done = !item.done
                }
            } catch {
                print("Error saving done status, \(error)")
            }
        }
        
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Do", message:"", preferredStyle: .alert)
        
        
        let action = UIAlertAction(title: "Add Do", style: .default) { (action) in
            
            
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                } catch {
                    print("Error saving new item -- \(error)")
                }
            }
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Do"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    

    
    func loadItems() {
        itemArray = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
    
    
    
    
    
    

}




    
    
