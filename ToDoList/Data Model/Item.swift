//
//  Item.swift
//  ToDoList
//
//  Created by Thomas LeBlanc on 5/11/19.
//  Copyright © 2019 AnyoneCanInvest. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    //reverse relationship: many to 1
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
