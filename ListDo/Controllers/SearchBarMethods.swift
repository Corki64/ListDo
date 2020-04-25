//
//  SearchBarMethods.swift
//  ListDo
//
//  Created by user162511 on 4/21/20.
//  Copyright © 2020 lac0084. All rights reserved.
//

import Foundation

import UIKit
import CoreData

extension ListDoViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
//        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(with: request, predicate: predicate)
    }
    
    
    // Will activate when text in the searchbar has changed
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        // When text bar is empty it will call on the original list with all items.
        if searchBar.text?.count == 0 {
            loadItems()
            
            // also will give the screen back from the keyboard + searchbar object
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
