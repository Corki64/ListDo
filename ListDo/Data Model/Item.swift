//
//  Item.swift
//  ListDo
//
//  Created by user162511 on 3/31/20.
//  Copyright © 2020 lac0084. All rights reserved.
//

import Foundation

// In order to use a plist for data must use - encoding for saving to the plist and decoding for reading from the plist
class Item: Codable {
    
    // For a class to be encodable all the properties must have standard data types - ie String, Bool etc.
    var title : String = ""
    var done : Bool = false
}
