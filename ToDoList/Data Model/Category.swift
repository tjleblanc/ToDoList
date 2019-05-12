//
//  Category.swift
//  ToDoList
//
//  Created by Thomas LeBlanc on 5/11/19.
//  Copyright © 2019 AnyoneCanInvest. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    // forward relationship: 1 to many
    let items = List<Item>()            // initialize items as an empty list of Item
}
