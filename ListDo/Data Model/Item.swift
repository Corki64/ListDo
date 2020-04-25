//
//  Item.swift
//  ListDo
//
//  Created by user162511 on 4/25/20.
//  Copyright © 2020 lac0084. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
