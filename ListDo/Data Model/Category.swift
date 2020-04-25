//
//  Category.swift
//  ListDo
//
//  Created by user162511 on 4/25/20.
//  Copyright © 2020 lac0084. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    @objc dynamic var color: String = ""
    
    let items = List<Item>()
    
}
