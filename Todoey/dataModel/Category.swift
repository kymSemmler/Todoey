//
//  Category.swift
//  Todoey
//
//  Created by User on 23/6/19.
//  Copyright © 2019 kymsemmler. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
